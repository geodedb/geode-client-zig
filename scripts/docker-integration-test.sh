#!/bin/bash
# =============================================================================
# Docker Integration Test Script for Geode Zig Client
#
# This script manages a Docker container for integration testing:
# - Starts a Geode container with dynamic port allocation
# - Waits for the server to be ready
# - Runs integration tests
# - Cleans up the container
#
# Usage:
#   ./scripts/docker-integration-test.sh [options]
#
# Options:
#   --image IMAGE    Docker image to use (default: geodedb/geode:latest)
#   --timeout SECS   Startup timeout in seconds (default: 60)
#   --keep           Keep container running after tests
#   --pull           Pull latest image before running
#   --verbose        Show verbose output
#
# Copyright (c) 2024-2026 CodePros
# SPDX-License-Identifier: Apache-2.0
# =============================================================================

set -e

# Configuration
DOCKER_IMAGE="${GEODE_IMAGE:-geodedb/geode:latest}"
CONTAINER_NAME="geode-zig-test-$$"
CONTAINER_PORT=3141
GRPC_CONTAINER_PORT=50051
STARTUP_TIMEOUT=60
KEEP_CONTAINER=false
PULL_IMAGE=false
VERBOSE=false

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --image)
            DOCKER_IMAGE="$2"
            shift 2
            ;;
        --timeout)
            STARTUP_TIMEOUT="$2"
            shift 2
            ;;
        --keep)
            KEEP_CONTAINER=true
            shift
            ;;
        --pull)
            PULL_IMAGE=true
            shift
            ;;
        --verbose)
            VERBOSE=true
            shift
            ;;
        --help)
            echo "Usage: $0 [options]"
            echo ""
            echo "Options:"
            echo "  --image IMAGE    Docker image to use"
            echo "  --timeout SECS   Startup timeout in seconds (default: 60)"
            echo "  --keep           Keep container running after tests"
            echo "  --pull           Pull latest image before running"
            echo "  --verbose        Show verbose output"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

log() {
    echo -e "${GREEN}[docker-test]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[docker-test]${NC} $1"
}

error() {
    echo -e "${RED}[docker-test]${NC} $1" >&2
}

verbose() {
    if [ "$VERBOSE" = true ]; then
        echo -e "${YELLOW}[docker-test]${NC} $1"
    fi
}

# Find an available UDP port
find_available_port() {
    # Try to find an available port in the range 10000-60000
    for port in $(shuf -i 10000-60000 -n 100); do
        if ! ss -uln | grep -q ":$port "; then
            echo $port
            return 0
        fi
    done
    # Fallback to default port
    echo $CONTAINER_PORT
}

# Cleanup function
cleanup() {
    if [ "$KEEP_CONTAINER" = false ]; then
        log "Stopping container: $CONTAINER_NAME"
        docker stop "$CONTAINER_NAME" 2>/dev/null || true
        docker rm -f "$CONTAINER_NAME" 2>/dev/null || true
    else
        warn "Container kept running: $CONTAINER_NAME"
        warn "Stop it manually with: docker stop $CONTAINER_NAME"
    fi
}

# Set up trap for cleanup
trap cleanup EXIT

# Check if Docker is available
if ! command -v docker &> /dev/null; then
    error "Docker is not installed or not in PATH"
    exit 1
fi

if ! docker info &> /dev/null; then
    error "Docker daemon is not running"
    exit 1
fi

# Pull image if requested
if [ "$PULL_IMAGE" = true ]; then
    log "Pulling Docker image: $DOCKER_IMAGE"
    docker pull "$DOCKER_IMAGE"
fi

# Find available ports
HOST_PORT=$(find_available_port)
log "Using QUIC host port: $HOST_PORT"
GRPC_HOST_PORT=$(find_available_port)
log "Using gRPC host port: $GRPC_HOST_PORT"

# Start container
log "Starting Geode container: $CONTAINER_NAME"
verbose "Image: $DOCKER_IMAGE"
verbose "Container port: $CONTAINER_PORT -> Host port: $HOST_PORT"

CONTAINER_ID=$(docker run -d --rm \
    --name "$CONTAINER_NAME" \
    -p "$HOST_PORT:$CONTAINER_PORT/udp" \
    -p "$GRPC_HOST_PORT:$GRPC_CONTAINER_PORT/tcp" \
    "$DOCKER_IMAGE" \
    serve --listen "0.0.0.0:$CONTAINER_PORT" --listen-grpc "0.0.0.0:$GRPC_CONTAINER_PORT" --log-level info)

if [ -z "$CONTAINER_ID" ]; then
    error "Failed to start container"
    exit 1
fi

log "Container started: ${CONTAINER_ID:0:12}"

# Wait for server to be ready
log "Waiting for server to be ready (timeout: ${STARTUP_TIMEOUT}s)..."
START_TIME=$(date +%s)

while true; do
    CURRENT_TIME=$(date +%s)
    ELAPSED=$((CURRENT_TIME - START_TIME))

    if [ $ELAPSED -ge $STARTUP_TIMEOUT ]; then
        error "Timeout waiting for server to be ready"
        echo ""
        error "Container logs:"
        docker logs "$CONTAINER_NAME" 2>&1 | tail -50
        exit 1
    fi

    # Check for "Server ready" or "Listening on" in logs
    if docker logs "$CONTAINER_NAME" 2>&1 | grep -q "Server ready\|Listening on"; then
        log "Server is ready!"
        break
    fi

    # Check if container is still running
    if ! docker ps -q -f name="$CONTAINER_NAME" | grep -q .; then
        error "Container stopped unexpectedly"
        echo ""
        error "Container logs:"
        docker logs "$CONTAINER_NAME" 2>&1 | tail -50
        exit 1
    fi

    verbose "Waiting... (${ELAPSED}s/${STARTUP_TIMEOUT}s)"
    sleep 1
done

# Give it an extra moment to fully initialize
sleep 1

# Show container info
if [ "$VERBOSE" = true ]; then
    echo ""
    log "Container info:"
    docker ps -f name="$CONTAINER_NAME" --format "  Name: {{.Names}}\n  Status: {{.Status}}\n  Ports: {{.Ports}}"
    echo ""
fi

# Run integration tests
log "Running integration tests..."
echo ""

export GEODE_SERVER="127.0.0.1:$HOST_PORT"
export GEODE_INSECURE=1

# Change to project directory
cd "$(dirname "$0")/.."

# Run tests
if zig build test-integration; then
    echo ""
    log "✓ All integration tests passed!"
    TEST_RESULT=0
else
    echo ""
    error "✗ Some integration tests failed"
    TEST_RESULT=1
fi

# Show container logs on failure
if [ $TEST_RESULT -ne 0 ] && [ "$VERBOSE" = true ]; then
    echo ""
    warn "Container logs:"
    docker logs "$CONTAINER_NAME" 2>&1 | tail -100
fi

exit $TEST_RESULT

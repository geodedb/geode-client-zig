# =============================================================================
# Geode Zig Client Makefile
# Convenient shortcuts for build, test, lint, and integration operations
# =============================================================================

ZIG ?= zig
ZIG_FLAGS ?=

# Docker settings
DOCKER_IMAGE ?= registry.gitlab.com/devnw/geode/geode:latest
DOCKER_CONTAINER_NAME ?= geode-test-server
GEODE_HOST ?= 127.0.0.1
GEODE_PORT ?= 3141

.PHONY: all build release test test-unit test-integration test-integration-docker \
        test-integration-docker-legacy test-integration-docker-verbose test-integration-docker-keep \
        test-connection test-connection-v2 test-all test-fuzz bench \
        fmt fmt-check lint clean check ci ci-quick ci-full help \
        docker-start docker-stop docker-logs docker-status docker-pull docker-wait \
        run run-v2 deps watch deps-tree build-verbose \
        pre-commit pre-commit-install pre-commit-update pre-commit-all setup-dev

# Default target
all: build fmt-check test
	@echo ""
	@echo "==== All Checks Complete ===="
	@echo "✓ Build successful"
	@echo "✓ Format check passed"
	@echo "✓ Tests passed"
	@echo ""
	@echo "Note: Run 'make test-integration' separately (requires Geode server)"

# Help target
help:
	@echo "Geode Zig Client Makefile"
	@echo "========================="
	@echo ""
	@echo "Build targets:"
	@echo "  make build          - Build debug version"
	@echo "  make release        - Build release version"
	@echo "  make clean          - Clean build artifacts"
	@echo "  make deps           - Fetch dependencies"
	@echo ""
	@echo "Test targets:"
	@echo "  make test           - Run all unit tests"
	@echo "  make test-unit      - Run unit tests only"
	@echo "  make test-integration        - Run integration tests (requires Geode server)"
	@echo "  make test-integration-docker - Run integration tests with Docker (auto container)"
	@echo "  make test-integration-docker-verbose - Run with verbose Docker output"
	@echo "  make test-integration-docker-keep    - Keep container running after tests"
	@echo "  make test-fuzz      - Run property-based and fuzz tests"
	@echo ""
	@echo "Quality targets:"
	@echo "  make lint           - Run zig fmt check (lint)"
	@echo "  make fmt            - Format code with zig fmt"
	@echo "  make fmt-check      - Check formatting without changes"
	@echo "  make check          - Run build check (fast compile check)"
	@echo ""
	@echo "Docker targets:"
	@echo "  make docker-start   - Start Geode server in Docker"
	@echo "  make docker-stop    - Stop Geode Docker container"
	@echo "  make docker-logs    - Show Docker container logs"
	@echo "  make docker-status  - Check Docker container status"
	@echo ""
	@echo "Run targets:"
	@echo "  make run            - Run test_connection"
	@echo "  make run-v2         - Run test_connection_v2"
	@echo ""
	@echo "Benchmark targets:"
	@echo "  make bench          - Run performance benchmarks"
	@echo ""
	@echo "CI targets:"
	@echo "  make ci             - Run full CI pipeline"
	@echo "  make ci-quick       - Run quick CI (no integration tests)"
	@echo "  make ci-full        - Run full CI with Docker integration tests"
	@echo ""
	@echo "Pre-commit targets:"
	@echo "  make pre-commit-install - Install pre-commit hooks"
	@echo "  make pre-commit         - Run pre-commit on all files"
	@echo "  make pre-commit-update  - Update hooks to latest versions"
	@echo "  make pre-commit-all     - Run all hooks (commit + push stages)"
	@echo "  make setup-dev          - Full development environment setup"
	@echo ""
	@echo "Environment variables:
	@echo "  ZIG_FLAGS           - Additional flags for zig commands"
	@echo "  GEODE_HOST          - Geode server host (default: 127.0.0.1)"
	@echo "  GEODE_PORT          - Geode server port (default: 3141)"
	@echo "  DOCKER_IMAGE        - Docker image for Geode server"

# =============================================================================
# Build Targets
# =============================================================================

build:
	@echo "Building debug version..."
	$(ZIG) build $(ZIG_FLAGS)
	@echo "✓ Build complete"

release:
	@echo "Building release version..."
	$(ZIG) build -Doptimize=ReleaseSafe $(ZIG_FLAGS)
	@echo "✓ Release build complete"

check:
	@echo "Running build check..."
	$(ZIG) build --summary all $(ZIG_FLAGS)
	@echo "✓ Check complete"

clean:
	@echo "Cleaning build artifacts..."
	rm -rf zig-out/
	rm -rf .zig-cache/
	rm -rf zig-cache/
	rm -rf reports/
	rm -rf coverage/
	rm -rf bench-results/
	@echo "✓ Clean complete"

deps:
	@echo "Fetching dependencies..."
	$(ZIG) build --fetch $(ZIG_FLAGS)
	@echo "✓ Dependencies fetched"

# =============================================================================
# Test Targets
# =============================================================================

test: test-unit
	@echo "✓ All tests complete"

test-unit:
	@echo "Running unit tests..."
	$(ZIG) build test $(ZIG_FLAGS)
	@echo "✓ Unit tests complete"

test-integration:
	@echo "Running integration tests..."
	@echo ""
	@echo "Tests connect to Geode server at $(GEODE_HOST):$(GEODE_PORT)"
	@echo "Start server first: cd ../geode && ./zig-out/bin/geode serve"
	@echo "Or use: make test-integration-docker"
	@echo ""
	GEODE_SERVER=$(GEODE_HOST):$(GEODE_PORT) GEODE_INSECURE=1 $(ZIG) build test-integration $(ZIG_FLAGS)
	@echo ""
	@echo "✓ Integration tests complete"

test-integration-docker: build
	@echo "Running integration tests with Docker..."
	@./scripts/docker-integration-test.sh
	@echo ""
	@echo "✓ Docker integration tests complete"

test-integration-docker-verbose: build
	@echo "Running integration tests with Docker (verbose)..."
	@./scripts/docker-integration-test.sh --verbose
	@echo ""
	@echo "✓ Docker integration tests complete"

test-integration-docker-keep: build
	@echo "Running integration tests with Docker (keeping container)..."
	@./scripts/docker-integration-test.sh --keep --verbose
	@echo ""
	@echo "✓ Docker integration tests complete"

# Legacy Docker integration test (manual container management)
test-integration-docker-legacy: build docker-start docker-wait
	@echo "Running integration tests with Docker (legacy)..."
	@echo ""
	@echo "Using Docker container: $(DOCKER_CONTAINER_NAME)"
	@echo ""
	GEODE_SERVER=127.0.0.1:$(GEODE_PORT) GEODE_INSECURE=1 $(ZIG) build test-integration $(ZIG_FLAGS) || ($(MAKE) docker-stop && exit 1)
	@echo ""
	@echo "✓ Docker integration tests complete"
	$(MAKE) docker-stop

# Run test executables (legacy)
test-connection: build
	@echo "Running test_connection..."
	GEODE_SERVER=$(GEODE_HOST):$(GEODE_PORT) ./zig-out/bin/test_connection

test-connection-v2: build
	@echo "Running test_connection_v2..."
	GEODE_SERVER=$(GEODE_HOST):$(GEODE_PORT) GEODE_INSECURE=1 ./zig-out/bin/test_connection_v2

test-all: test-unit test-integration test-fuzz
	@echo "✓ All tests complete (including integration and fuzz)"

test-fuzz:
	@echo "Running property-based and fuzz tests..."
	$(ZIG) build test-fuzz $(ZIG_FLAGS)
	@echo "✓ Fuzz tests complete"

# =============================================================================
# Benchmark Targets
# =============================================================================

bench:
	@echo "Running performance benchmarks..."
	@echo ""
	$(ZIG) build bench $(ZIG_FLAGS)
	@echo ""
	@echo "✓ Benchmarks complete"

# =============================================================================
# Code Quality Targets
# =============================================================================

lint: fmt-check
	@echo "✓ Lint complete (all files pass zig fmt)"

fmt:
	@echo "Formatting all code..."
	$(ZIG) fmt *.zig src/*.zig tests/*.zig benchmarks/*.zig fuzz/*.zig
	@echo "✓ Format complete"

fmt-check:
	@echo "Checking code format..."
	@$(ZIG) fmt --check *.zig && \
	$(ZIG) fmt --check src/*.zig && \
	$(ZIG) fmt --check tests/*.zig && \
	$(ZIG) fmt --check benchmarks/*.zig && \
	$(ZIG) fmt --check fuzz/*.zig
	@echo "✓ Format check complete (all files properly formatted)"

# =============================================================================
# Docker Targets
# =============================================================================

docker-start:
	@echo "Starting Geode server in Docker..."
	@if docker ps -q -f name=$(DOCKER_CONTAINER_NAME) | grep -q .; then \
		echo "Container already running"; \
	else \
		docker run -d --rm \
			--name $(DOCKER_CONTAINER_NAME) \
			-p $(GEODE_PORT):3141/udp \
			$(DOCKER_IMAGE) \
			serve --listen 0.0.0.0:3141 --log-level info; \
		echo "✓ Container started: $(DOCKER_CONTAINER_NAME)"; \
	fi

docker-wait:
	@echo "Waiting for Geode server to be ready..."
	@for i in 1 2 3 4 5 6 7 8 9 10; do \
		if docker logs $(DOCKER_CONTAINER_NAME) 2>&1 | grep -q "Server ready"; then \
			echo "✓ Server ready"; \
			break; \
		fi; \
		echo "  Waiting... ($$i/10)"; \
		sleep 1; \
	done

docker-stop:
	@echo "Stopping Geode Docker container..."
	@docker stop $(DOCKER_CONTAINER_NAME) 2>/dev/null || true
	@echo "✓ Container stopped"

docker-logs:
	@echo "Showing Docker container logs..."
	@docker logs -f $(DOCKER_CONTAINER_NAME) 2>/dev/null || echo "Container not running"

docker-status:
	@echo "Docker container status:"
	@docker ps -f name=$(DOCKER_CONTAINER_NAME) --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}" 2>/dev/null || echo "Docker not available"

docker-pull:
	@echo "Pulling latest Geode Docker image..."
	docker pull $(DOCKER_IMAGE)
	@echo "✓ Image pulled"

# =============================================================================
# Run Targets
# =============================================================================

run: build
	@echo "Running test_connection..."
	GEODE_SERVER=$(GEODE_HOST):$(GEODE_PORT) ./zig-out/bin/test_connection

run-v2: build
	@echo "Running test_connection_v2..."
	GEODE_SERVER=$(GEODE_HOST):$(GEODE_PORT) ./zig-out/bin/test_connection_v2

# =============================================================================
# CI Targets
# =============================================================================

ci: fmt-check build test-unit
	@echo ""
	@echo "==== CI Pipeline Complete ===="
	@echo "✓ Format check passed"
	@echo "✓ Build successful"
	@echo "✓ Unit tests passed"
	@echo ""

ci-quick: fmt-check build
	@echo ""
	@echo "==== Quick CI Complete ===="
	@echo "✓ Format check passed"
	@echo "✓ Build successful"
	@echo ""

ci-full: ci docker-pull test-integration-docker
	@echo ""
	@echo "==== Full CI Complete (with Docker integration tests) ===="
	@echo ""

# =============================================================================
# Development Helpers
# =============================================================================

# Watch for changes (requires entr or similar)
watch:
	@echo "Watching for changes..."
	@echo "Note: Requires 'entr' (apt install entr / brew install entr)"
	@find . -name "*.zig" | entr -c $(MAKE) build test-unit

# Show dependency tree
deps-tree:
	@echo "Dependency tree:"
	@cat build.zig.zon

# Verbose build
build-verbose:
	@echo "Building with verbose output..."
	$(ZIG) build --verbose $(ZIG_FLAGS)

# =============================================================================
# Pre-commit Targets
# =============================================================================

# Run pre-commit on all files
pre-commit:
	@if command -v pre-commit >/dev/null 2>&1; then \
		pre-commit run --all-files; \
	else \
		echo "pre-commit not installed. Run 'make pre-commit-install' first."; \
		exit 1; \
	fi

# Install pre-commit hooks
pre-commit-install:
	@if ! command -v pre-commit >/dev/null 2>&1; then \
		echo "Installing pre-commit..."; \
		pip3 install --user pre-commit || pip install --user pre-commit; \
	fi
	@echo "Installing pre-commit hooks..."
	pre-commit install
	pre-commit install --hook-type commit-msg
	pre-commit install --hook-type pre-push
	@echo "✓ Pre-commit hooks installed"

# Update pre-commit hooks to latest versions
pre-commit-update:
	@if command -v pre-commit >/dev/null 2>&1; then \
		pre-commit autoupdate; \
	else \
		echo "pre-commit not installed. Run 'make pre-commit-install' first."; \
		exit 1; \
	fi

# Run all pre-commit checks (including push hooks)
pre-commit-all:
	@if command -v pre-commit >/dev/null 2>&1; then \
		echo "Running pre-commit hooks..."; \
		pre-commit run --all-files --hook-stage pre-commit; \
		echo ""; \
		echo "Running pre-push hooks..."; \
		pre-commit run --all-files --hook-stage pre-push; \
	else \
		echo "pre-commit not installed. Run 'make pre-commit-install' first."; \
		exit 1; \
	fi

# Full development environment setup
setup-dev: deps pre-commit-install
	@echo ""
	@echo "==== Development Environment Setup Complete ===="
	@echo "✓ Dependencies fetched"
	@echo "✓ Pre-commit hooks installed"
	@echo ""
	@echo "You can now:"
	@echo "  - Run 'make build' to build the project"
	@echo "  - Run 'make test' to run tests"
	@echo "  - Run 'make pre-commit' to check all files"
	@echo ""
	@echo "Pre-commit hooks will run automatically on:"
	@echo "  - git commit (format, build checks)"
	@echo "  - git push (tests, additional checks)"
	@echo ""

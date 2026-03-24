#!/bin/bash
# SPDX-License-Identifier: Apache-2.0
# Copyright (c) 2024-2026 CodePros
#
# Generate a basic SBOM (Software Bill of Materials) from build.zig.zon dependencies.
# This is a workaround until Zig ecosystem has proper SBOM tooling.
#
# SECURITY: Addresses Issue #24 - dependency scanning coverage for Zig packages

set -euo pipefail

ZON_FILE="${1:-build.zig.zon}"

if [ ! -f "$ZON_FILE" ]; then
    echo "ERROR: build.zig.zon not found at: $ZON_FILE"
    exit 1
fi

echo "=== Zig Dependency SBOM ==="
echo "Generated: $(date -u +%Y-%m-%dT%H:%M:%SZ)"
echo "Source: $ZON_FILE"
echo ""
echo "Dependencies:"
echo ""

# Extract dependency information from build.zig.zon
# Format: name, url, hash
awk '
    /^[[:space:]]*\.[a-z_]+ = \./ {
        # Start of dependency block
        dep_name = $1
        gsub(/^\./, "", dep_name)
        gsub(/ = .*/, "", dep_name)
    }
    /\.url = "/ {
        # Extract URL
        url = $0
        gsub(/.*\.url = "/, "", url)
        gsub(/".*/, "", url)
    }
    /\.hash = "/ {
        # Extract hash and output
        hash = $0
        gsub(/.*\.hash = "/, "", hash)
        gsub(/".*/, "", hash)

        if (dep_name && url && hash) {
            printf "- Name: %s\n", dep_name
            printf "  URL: %s\n", url
            printf "  Hash: %s\n", hash
            printf "\n"
            dep_name = ""
            url = ""
            hash = ""
        }
    }
' "$ZON_FILE"

# Count dependencies
DEP_COUNT=$(grep -c "^[[:space:]]*\.[a-z_]* = \." "$ZON_FILE" || echo "0")
echo "Total dependencies: $DEP_COUNT"
echo ""
echo "NOTE: This is a basic SBOM. For vulnerability scanning, dependencies should be"
echo "      checked against known vulnerability databases (e.g., OSV, NVD)."
echo ""
echo "Zig dependencies are Git-based packages. To check for vulnerabilities:"
echo "  1. Review each Git repository for security advisories"
echo "  2. Check commit SHAs match expected values"
echo "  3. Monitor upstream repositories for security updates"

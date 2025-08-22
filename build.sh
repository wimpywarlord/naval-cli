#!/bin/bash

# Build script for naval-cli
# This script builds binaries for multiple platforms

set -e

VERSION=${1:-1.0.0}
BUILD_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
GIT_COMMIT=$(git rev-parse --short HEAD 2>/dev/null || echo "unknown")

echo "Building naval-cli v${VERSION}"
echo "Build date: ${BUILD_DATE}"
echo "Git commit: ${GIT_COMMIT}"

# Create dist directory
mkdir -p dist

# Build flags
LDFLAGS="-s -w -X main.Version=${VERSION} -X main.BuildDate=${BUILD_DATE} -X main.GitCommit=${GIT_COMMIT}"

# Function to build for a specific platform
build_platform() {
    GOOS=$1
    GOARCH=$2
    OUTPUT_NAME=$3
    
    echo "Building for ${GOOS}/${GOARCH}..."
    
    env GOOS=${GOOS} GOARCH=${GOARCH} CGO_ENABLED=0 go build \
        -ldflags "${LDFLAGS}" \
        -o "dist/${OUTPUT_NAME}" \
        .
    
    # Create archive
    if [ "${GOOS}" = "windows" ]; then
        # For Windows, create a zip file
        (cd dist && zip -q "${OUTPUT_NAME%.exe}.zip" "${OUTPUT_NAME}")
        rm "dist/${OUTPUT_NAME}"
    else
        # For Unix systems, create a tar.gz
        (cd dist && tar -czf "${OUTPUT_NAME}.tar.gz" "${OUTPUT_NAME}")
        rm "dist/${OUTPUT_NAME}"
    fi
    
    echo "✓ Built ${OUTPUT_NAME}"
}

# Build for different platforms
build_platform "darwin" "amd64" "naval-cli-darwin-amd64"
build_platform "darwin" "arm64" "naval-cli-darwin-arm64"
build_platform "linux" "amd64" "naval-cli-linux-amd64"
build_platform "linux" "arm64" "naval-cli-linux-arm64"
build_platform "linux" "386" "naval-cli-linux-386"
build_platform "windows" "amd64" "naval-cli-windows-amd64.exe"
build_platform "windows" "386" "naval-cli-windows-386.exe"
build_platform "freebsd" "amd64" "naval-cli-freebsd-amd64"

# Generate checksums
echo "Generating checksums..."
(cd dist && shasum -a 256 *.{tar.gz,zip} > checksums.txt 2>/dev/null || sha256sum *.{tar.gz,zip} > checksums.txt)

echo ""
echo "✅ Build complete! Binaries are in the dist/ directory"
echo ""
echo "Files created:"
ls -lh dist/

echo ""
echo "To create a GitHub release:"
echo "1. git tag v${VERSION}"
echo "2. git push origin v${VERSION}"
echo "3. Create a release on GitHub and upload the files from dist/"
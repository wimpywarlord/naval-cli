#!/bin/bash

# naval-cli Installation Script
# This script downloads and installs the latest version of naval-cli

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
REPO="wimpywarlord/naval-cli"
INSTALL_DIR="${INSTALL_DIR:-/usr/local/bin}"
BINARY_NAME="naval-cli"

# Functions
error() {
    echo -e "${RED}Error: $1${NC}" >&2
    exit 1
}

success() {
    echo -e "${GREEN}$1${NC}"
}

info() {
    echo -e "${YELLOW}$1${NC}"
}

# Detect OS and architecture
detect_platform() {
    OS=$(uname -s | tr '[:upper:]' '[:lower:]')
    ARCH=$(uname -m)
    
    case "$OS" in
        linux*)
            OS="linux"
            ;;
        darwin*)
            OS="darwin"
            ;;
        freebsd*)
            OS="freebsd"
            ;;
        *)
            error "Unsupported operating system: $OS"
            ;;
    esac
    
    case "$ARCH" in
        x86_64|amd64)
            ARCH="amd64"
            ;;
        aarch64|arm64)
            ARCH="arm64"
            ;;
        i386|i686)
            ARCH="386"
            ;;
        armv7l)
            ARCH="arm"
            ;;
        *)
            error "Unsupported architecture: $ARCH"
            ;;
    esac
    
    PLATFORM="${OS}-${ARCH}"
    info "Detected platform: $PLATFORM"
}

# Get the latest release version
get_latest_version() {
    info "Fetching latest version..."
    
    if command -v curl &> /dev/null; then
        VERSION=$(curl -s "https://api.github.com/repos/${REPO}/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
    elif command -v wget &> /dev/null; then
        VERSION=$(wget -qO- "https://api.github.com/repos/${REPO}/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
    else
        error "Neither curl nor wget is available. Please install one of them."
    fi
    
    if [ -z "$VERSION" ]; then
        error "Failed to fetch the latest version. Please check your internet connection."
    fi
    
    info "Latest version: $VERSION"
}

# Download the binary
download_binary() {
    local version=$1
    local platform=$2
    
    # Remove 'v' prefix if present
    version_num=${version#v}
    
    DOWNLOAD_URL="https://github.com/${REPO}/releases/download/${version}/${BINARY_NAME}-${platform}.tar.gz"
    TEMP_DIR=$(mktemp -d)
    ARCHIVE_PATH="${TEMP_DIR}/${BINARY_NAME}.tar.gz"
    
    info "Downloading ${BINARY_NAME} ${version} for ${platform}..."
    
    if command -v curl &> /dev/null; then
        curl -L -o "$ARCHIVE_PATH" "$DOWNLOAD_URL" || error "Failed to download binary"
    else
        wget -O "$ARCHIVE_PATH" "$DOWNLOAD_URL" || error "Failed to download binary"
    fi
    
    info "Extracting archive..."
    tar -xzf "$ARCHIVE_PATH" -C "$TEMP_DIR" || error "Failed to extract archive"
    
    # Find the binary (it should be named naval-cli)
    if [ -f "${TEMP_DIR}/${BINARY_NAME}" ]; then
        BINARY_PATH="${TEMP_DIR}/${BINARY_NAME}"
    elif [ -f "${TEMP_DIR}/${BINARY_NAME}-${platform}" ]; then
        BINARY_PATH="${TEMP_DIR}/${BINARY_NAME}-${platform}"
    else
        error "Binary not found in archive"
    fi
    
    chmod +x "$BINARY_PATH"
}

# Install the binary
install_binary() {
    local binary_path=$1
    
    # Check if we need sudo
    if [ -w "$INSTALL_DIR" ]; then
        SUDO=""
    else
        info "Administrator privileges required to install to $INSTALL_DIR"
        SUDO="sudo"
    fi
    
    info "Installing ${BINARY_NAME} to ${INSTALL_DIR}..."
    $SUDO mv "$binary_path" "${INSTALL_DIR}/${BINARY_NAME}" || error "Failed to install binary"
    
    # Clean up temp directory
    rm -rf "$TEMP_DIR"
}

# Verify installation
verify_installation() {
    if command -v "$BINARY_NAME" &> /dev/null; then
        success "✅ ${BINARY_NAME} has been successfully installed!"
        echo ""
        "$BINARY_NAME" --version
        echo ""
        info "Run '${BINARY_NAME} --help' to get started"
    else
        error "Installation verification failed. Please check your PATH."
    fi
}

# Main installation flow
main() {
    echo "======================================"
    echo "   naval-cli Installation Script"
    echo "======================================"
    echo ""
    
    # Check for custom version
    if [ -n "$1" ]; then
        VERSION="$1"
        info "Installing specified version: $VERSION"
    else
        get_latest_version
    fi
    
    detect_platform
    download_binary "$VERSION" "$PLATFORM"
    install_binary "$BINARY_PATH"
    verify_installation
    
    echo ""
    echo "======================================"
    success "   Installation Complete! 🎉"
    echo "======================================"
}

# Run the installation
main "$@"
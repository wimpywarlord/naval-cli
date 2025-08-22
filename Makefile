# Makefile for naval-cli
# Provides common development and build tasks

.PHONY: build test lint fmt clean install dev run help

# Build variables
BINARY_NAME=naval-cli
BUILD_DIR=dist
CMD_DIR=./cmd/naval-cli

# Version variables (can be overridden)
VERSION ?= $(shell git describe --tags --always --dirty 2>/dev/null || echo "dev")
BUILD_DATE ?= $(shell date -u +"%Y-%m-%dT%H:%M:%SZ")
GIT_COMMIT ?= $(shell git rev-parse --short HEAD 2>/dev/null || echo "unknown")

# Linker flags for version injection
LDFLAGS = -ldflags "\
    -X github.com/wimpywarlord/naval-cli/internal/version.Version=$(VERSION) \
    -X github.com/wimpywarlord/naval-cli/internal/version.BuildDate=$(BUILD_DATE) \
    -X github.com/wimpywarlord/naval-cli/internal/version.GitCommit=$(GIT_COMMIT)"

# Default target
all: build

# Build the application
build:
	@echo "Building $(BINARY_NAME)..."
	@mkdir -p $(BUILD_DIR)
	go build $(LDFLAGS) -o $(BUILD_DIR)/$(BINARY_NAME) $(CMD_DIR)
	@echo "Built: $(BUILD_DIR)/$(BINARY_NAME)"

# Run tests
test:
	@echo "Running tests..."
	go test -v ./...

# Format code
fmt:
	@echo "Formatting code..."
	go fmt ./...

# Lint code
lint:
	@echo "Linting code..."
	@if command -v golangci-lint >/dev/null 2>&1; then \
		golangci-lint run; \
	else \
		echo "golangci-lint not installed. Install with: go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest"; \
		go vet ./...; \
	fi

# Clean build artifacts
clean:
	@echo "Cleaning build artifacts..."
	rm -rf $(BUILD_DIR)
	go clean

# Install to $GOPATH/bin
install:
	@echo "Installing $(BINARY_NAME)..."
	go install $(LDFLAGS) $(CMD_DIR)

# Development build (no version injection)
dev:
	@echo "Building development version..."
	go build -o $(BINARY_NAME) $(CMD_DIR)

# Run the application
run:
	go run $(CMD_DIR)

# Cross-compile for multiple platforms
build-all:
	@echo "Cross-compiling for multiple platforms..."
	@mkdir -p $(BUILD_DIR)
	
	# macOS
	GOOS=darwin GOARCH=amd64 go build $(LDFLAGS) -o $(BUILD_DIR)/$(BINARY_NAME)-darwin-amd64 $(CMD_DIR)
	GOOS=darwin GOARCH=arm64 go build $(LDFLAGS) -o $(BUILD_DIR)/$(BINARY_NAME)-darwin-arm64 $(CMD_DIR)
	
	# Linux
	GOOS=linux GOARCH=amd64 go build $(LDFLAGS) -o $(BUILD_DIR)/$(BINARY_NAME)-linux-amd64 $(CMD_DIR)
	GOOS=linux GOARCH=arm64 go build $(LDFLAGS) -o $(BUILD_DIR)/$(BINARY_NAME)-linux-arm64 $(CMD_DIR)
	
	# Windows
	GOOS=windows GOARCH=amd64 go build $(LDFLAGS) -o $(BUILD_DIR)/$(BINARY_NAME)-windows-amd64.exe $(CMD_DIR)
	
	@echo "Cross-compilation complete. Binaries in $(BUILD_DIR)/"

# Release using GoReleaser (requires tag)
release:
	@if [ -z "$(shell git tag --points-at HEAD)" ]; then \
		echo "Error: No tag found at HEAD. Create a tag first: git tag v1.x.x"; \
		exit 1; \
	fi
	@echo "Creating release..."
	goreleaser release --clean

# Create a new release tag
tag:
	@if [ -z "$(TAG)" ]; then \
		echo "Usage: make tag TAG=v1.x.x"; \
		exit 1; \
	fi
	@echo "Creating tag $(TAG)..."
	git tag $(TAG)
	@echo "Push with: git push origin $(TAG)"

# Check dependencies
deps:
	@echo "Checking dependencies..."
	go mod tidy
	go mod verify

# Display help
help:
	@echo "Available targets:"
	@echo "  build      - Build the application"
	@echo "  test       - Run tests"
	@echo "  fmt        - Format code"
	@echo "  lint       - Lint code"
	@echo "  clean      - Clean build artifacts"
	@echo "  install    - Install to GOPATH/bin"
	@echo "  dev        - Quick development build"
	@echo "  run        - Run the application"
	@echo "  build-all  - Cross-compile for multiple platforms"
	@echo "  release    - Create release using GoReleaser"
	@echo "  tag        - Create a new git tag (Usage: make tag TAG=v1.x.x)"
	@echo "  deps       - Check and tidy dependencies"
	@echo "  help       - Show this help"
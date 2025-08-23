# Changelog

All notable changes to naval-cli will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.4] - 2025-08-23

### Fixed
- Added missing CHANGELOG.md file required by GoReleaser

## [1.0.3] - 2025-08-23

### Fixed
- Added missing cmd/naval-cli/main.go file that was accidentally removed during refactor
- Fixed .gitignore to only exclude root binary, not cmd directory
- Resolved GoReleaser build failure in GitHub Actions

## [1.0.2] - 2025-08-23

### Fixed
- Updated installation script to use correct GitHub release URL format
- Fixed archive naming convention to match GoReleaser output

## [1.0.1] - 2025-08-22

### Added
- Restructured project following Go best practices
- Added Makefile for common development tasks
- Improved GitHub Actions workflow

### Changed
- Reorganized code into proper Go package structure
- Updated GoReleaser configuration

## [1.0.0] - 2025-08-22

### Added
- Initial release of naval-cli
- ASCII art portrait of Naval Ravikant
- 50+ curated quotes on wealth, happiness, and life
- Command-line options for customization
- Colored output support
- Multiple quote display
- Cross-platform binary support (Linux, macOS, Windows, FreeBSD)
- Installation script for easy setup
- Homebrew formula support
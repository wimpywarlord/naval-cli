# Changelog

All notable changes to naval-cli will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2024-01-22

### Added
- Initial release of naval-cli
- ASCII art portrait of Naval Ravikant
- 50+ curated quotes on wealth, happiness, and life
- Command-line flags for customization:
  - `--no-ascii` to display quotes without ASCII art
  - `--count` to display multiple quotes
  - `--no-color` to disable colored output
  - `--version` to show version information
  - `--help` to display usage information
- Colored terminal output using fatih/color
- Cross-platform support (macOS, Linux, Windows)
- Single binary distribution

### Technical Details
- Written in Go 1.20+
- Zero runtime dependencies (single static binary)
- Efficient random quote selection
- Text wrapping for better terminal display

## [Unreleased]

### Planned Features
- Configuration file support for default settings
- More quotes and categories
- Interactive mode for browsing quotes
- Export quotes to different formats (JSON, Markdown)
- Integration with other wisdom sources

---

For detailed release notes, see the [GitHub Releases](https://github.com/wimpywarlord/naval-cli/releases) page.
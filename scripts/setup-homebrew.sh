#!/bin/bash

# Script to set up Homebrew tap for naval-cli
# This will enable: brew install wimpywarlord/naval-cli/naval-cli

echo "🍺 Setting up Homebrew Tap for naval-cli"
echo "========================================"
echo ""

# Check if GitHub CLI is installed
if ! command -v gh &> /dev/null; then
    echo "❌ GitHub CLI (gh) is not installed"
    echo "Install it with: brew install gh"
    echo "Then run: gh auth login"
    exit 1
fi

# Create the tap repository
echo "1. Creating homebrew-naval-cli repository on GitHub..."
gh repo create homebrew-naval-cli --public --description "Homebrew tap for naval-cli" --clone

cd homebrew-naval-cli || exit 1

# Create Formula directory
echo "2. Setting up Formula directory..."
mkdir -p Formula

# Get the SHA256 for the latest release
echo "3. Fetching SHA256 checksums for v1.0.0..."
VERSION="1.0.0"

# Download and calculate SHA256 for each platform
echo "Calculating checksums..."
DARWIN_ARM64_SHA=$(curl -sL "https://github.com/wimpywarlord/naval-cli/releases/download/v${VERSION}/naval-cli_${VERSION}_Darwin_arm64.tar.gz" | shasum -a 256 | cut -d' ' -f1)
DARWIN_AMD64_SHA=$(curl -sL "https://github.com/wimpywarlord/naval-cli/releases/download/v${VERSION}/naval-cli_${VERSION}_Darwin_x86_64.tar.gz" | shasum -a 256 | cut -d' ' -f1)
LINUX_ARM64_SHA=$(curl -sL "https://github.com/wimpywarlord/naval-cli/releases/download/v${VERSION}/naval-cli_${VERSION}_Linux_arm64.tar.gz" | shasum -a 256 | cut -d' ' -f1)
LINUX_AMD64_SHA=$(curl -sL "https://github.com/wimpywarlord/naval-cli/releases/download/v${VERSION}/naval-cli_${VERSION}_Linux_x86_64.tar.gz" | shasum -a 256 | cut -d' ' -f1)

# Create the formula
echo "4. Creating Formula/naval-cli.rb..."
cat > Formula/naval-cli.rb << EOF
class NavalCli < Formula
  desc "Display Naval Ravikant's wisdom with ASCII art in your terminal"
  homepage "https://github.com/wimpywarlord/naval-cli"
  version "${VERSION}"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wimpywarlord/naval-cli/releases/download/v${VERSION}/naval-cli_${VERSION}_Darwin_arm64.tar.gz"
      sha256 "${DARWIN_ARM64_SHA}"
    else
      url "https://github.com/wimpywarlord/naval-cli/releases/download/v${VERSION}/naval-cli_${VERSION}_Darwin_x86_64.tar.gz"
      sha256 "${DARWIN_AMD64_SHA}"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/wimpywarlord/naval-cli/releases/download/v${VERSION}/naval-cli_${VERSION}_Linux_arm64.tar.gz"
      sha256 "${LINUX_ARM64_SHA}"
    else
      url "https://github.com/wimpywarlord/naval-cli/releases/download/v${VERSION}/naval-cli_${VERSION}_Linux_x86_64.tar.gz"
      sha256 "${LINUX_AMD64_SHA}"
    end
  end

  def install
    bin.install "naval-cli"
  end

  test do
    assert_match "naval-cli v#{version}", shell_output("#{bin}/naval-cli --version")
  end
end
EOF

# Create README
echo "5. Creating README.md..."
cat > README.md << 'EOF'
# homebrew-naval-cli

Homebrew tap for [naval-cli](https://github.com/wimpywarlord/naval-cli)

## Installation

```bash
brew tap wimpywarlord/naval-cli
brew install naval-cli
```

Or install directly:

```bash
brew install wimpywarlord/naval-cli/naval-cli
```

## Usage

After installation, run:

```bash
naval-cli          # Display quote with ASCII art
naval-cli --help   # Show help
```
EOF

# Commit and push
echo "6. Committing and pushing..."
git add .
git commit -m "Add naval-cli formula v${VERSION}"
git push origin main

echo ""
echo "✅ Homebrew tap setup complete!"
echo ""
echo "People can now install your tool with:"
echo "  brew tap wimpywarlord/naval-cli"
echo "  brew install naval-cli"
echo ""
echo "Or in one command:"
echo "  brew install wimpywarlord/naval-cli/naval-cli"
echo ""
echo "Test it yourself:"
echo "  brew tap wimpywarlord/naval-cli"
echo "  brew install naval-cli"
echo "  naval-cli"
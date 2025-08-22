# Homebrew Formula for naval-cli
# This file should be placed in your homebrew-naval-cli tap repository
# Repository: https://github.com/wimpywarlord/homebrew-naval-cli
# File path: Formula/naval-cli.rb

class NavalCli < Formula
  desc "Display Naval Ravikant's wisdom with ASCII art in your terminal"
  homepage "https://github.com/wimpywarlord/naval-cli"
  version "1.0.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wimpywarlord/naval-cli/releases/download/v1.0.0/naval-cli_1.0.0_Darwin_arm64.tar.gz"
      sha256 "PLACEHOLDER_SHA256_DARWIN_ARM64"
    else
      url "https://github.com/wimpywarlord/naval-cli/releases/download/v1.0.0/naval-cli_1.0.0_Darwin_x86_64.tar.gz"
      sha256 "PLACEHOLDER_SHA256_DARWIN_AMD64"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/wimpywarlord/naval-cli/releases/download/v1.0.0/naval-cli_1.0.0_Linux_arm64.tar.gz"
      sha256 "PLACEHOLDER_SHA256_LINUX_ARM64"
    else
      url "https://github.com/wimpywarlord/naval-cli/releases/download/v1.0.0/naval-cli_1.0.0_Linux_x86_64.tar.gz"
      sha256 "PLACEHOLDER_SHA256_LINUX_AMD64"
    end
  end

  def install
    bin.install "naval-cli"
  end

  test do
    assert_match "naval-cli v#{version}", shell_output("#{bin}/naval-cli --version")
    assert_match "Naval Ravikant", shell_output("#{bin}/naval-cli --no-ascii")
  end
end
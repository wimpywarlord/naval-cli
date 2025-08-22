# Deployment Guide for naval-cli

This guide explains how to deploy and distribute naval-cli to users worldwide.

## 📋 Prerequisites

1. **GitHub Account**: Required for hosting code and releases
2. **Go 1.20+**: For building the application
3. **GoReleaser**: For automated releases (optional, handled by GitHub Actions)
4. **Git**: For version control

## 🚀 Quick Start Deployment

### Step 1: Prepare Your First Release

1. Ensure all code is committed:
```bash
git add .
git commit -m "feat: prepare for v1.0.0 release"
git push origin main
```

2. Create and push a version tag:
```bash
git tag v1.0.0
git push origin v1.0.0
```

This will trigger the GitHub Actions workflow to automatically:
- Build binaries for all platforms
- Create a GitHub release
- Upload all binaries and checksums
- Update the Homebrew formula (if tap repo exists)

### Step 2: Manual Release (Alternative)

If you prefer to create a release manually:

```bash
# Build all binaries
./build.sh 1.0.0

# The binaries will be in the dist/ directory
# Upload these to GitHub Releases manually
```

## 📦 Distribution Channels

### 1. GitHub Releases (Primary)

**Automatic (Recommended):**
- Push a tag starting with 'v' (e.g., v1.0.1)
- GitHub Actions will handle everything

**Manual:**
1. Go to https://github.com/wimpywarlord/naval-cli/releases
2. Click "Create a new release"
3. Choose your tag
4. Upload binaries from `dist/` directory
5. Publish release

### 2. Homebrew (macOS/Linux)

**Setup Homebrew Tap:**

1. Create a new repository: `homebrew-naval-cli`
2. Create `Formula/naval-cli.rb` using the template
3. Update SHA256 hashes after building binaries

**Users install with:**
```bash
brew tap wimpywarlord/naval-cli
brew install naval-cli
```

### 3. Go Install

No setup needed! Users with Go installed can run:
```bash
go install github.com/wimpywarlord/naval-cli@latest
```

### 4. Direct Script Installation

The `install.sh` script is already set up. Users can install with:
```bash
curl -sSL https://raw.githubusercontent.com/wimpywarlord/naval-cli/main/install.sh | bash
```

### 5. Docker (Optional)

Build and push Docker image:
```bash
docker build -t wimpywarlord/naval-cli .
docker push wimpywarlord/naval-cli:latest
```

## 🔄 Updating Versions

### For a New Release:

1. Update version in `version.go`:
```go
var Version = "1.0.1"
```

2. Update `CHANGELOG.md` with new changes

3. Commit changes:
```bash
git add .
git commit -m "chore: bump version to v1.0.1"
```

4. Create and push tag:
```bash
git tag v1.0.1
git push origin main
git push origin v1.0.1
```

## 🛠️ Platform-Specific Notes

### macOS
- Binaries might need to be signed for Gatekeeper
- Users may need to allow in System Preferences
- Command: `xattr -d com.apple.quarantine naval-cli`

### Windows
- Provide `.exe` files
- Consider code signing certificate
- Windows Defender might flag unsigned binaries

### Linux
- Consider creating packages for package managers:
  - `.deb` for Debian/Ubuntu
  - `.rpm` for RedHat/Fedora
  - AUR package for Arch Linux

## 📊 Monitoring Adoption

Track your tool's success:

1. **GitHub Insights**:
   - Stars, forks, watchers
   - Release download counts
   - Traffic analytics

2. **Homebrew Analytics** (if in homebrew-core):
```bash
brew info --analytics naval-cli
```

3. **Go Module Proxy**:
   - Check pkg.go.dev for download stats

## 🔐 Security Considerations

1. **Sign Your Releases**:
```bash
# Sign with GPG
gpg --armor --detach-sign naval-cli

# Verify signature
gpg --verify naval-cli.asc naval-cli
```

2. **Provide Checksums**:
   - Always include SHA256 checksums
   - Users can verify with: `sha256sum -c checksums.txt`

3. **Security Policy**:
   - Create SECURITY.md
   - Set up security advisories on GitHub

## 📝 Release Checklist

Before each release:

- [ ] Update version in `version.go`
- [ ] Update CHANGELOG.md
- [ ] Run tests: `go test ./...`
- [ ] Build locally: `./build.sh x.x.x`
- [ ] Test binary on each platform
- [ ] Commit all changes
- [ ] Create and push tag
- [ ] Verify GitHub Actions success
- [ ] Test installation methods
- [ ] Update documentation if needed
- [ ] Announce release (Twitter, Reddit, etc.)

## 🆘 Troubleshooting

### GitHub Actions Failing
- Check Actions tab for error logs
- Ensure GITHUB_TOKEN has correct permissions
- Verify .goreleaser.yml syntax

### Homebrew Formula Issues
- Ensure SHA256 hashes are correct
- Test locally: `brew install --build-from-source ./homebrew-formula.rb`

### Installation Script Problems
- Check platform detection logic
- Ensure GitHub API is accessible
- Verify download URLs are correct

## 🎉 Post-Deployment

1. **Announce Your Release**:
   - Twitter/X
   - Reddit (r/golang, r/commandline)
   - Hacker News
   - Dev.to / Hashnode

2. **Gather Feedback**:
   - GitHub Issues
   - Discord/Slack community
   - User surveys

3. **Monitor and Iterate**:
   - Track issues and feature requests
   - Regular updates and bug fixes
   - Engage with community

## 📚 Additional Resources

- [GoReleaser Documentation](https://goreleaser.com)
- [GitHub Actions Guide](https://docs.github.com/en/actions)
- [Homebrew Formula Cookbook](https://docs.brew.sh/Formula-Cookbook)
- [Semantic Versioning](https://semver.org)

---

Happy deploying! 🚀 If you encounter any issues, please open an issue on GitHub.
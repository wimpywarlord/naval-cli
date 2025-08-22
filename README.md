# naval-cli

A beautiful command-line tool that displays Naval Ravikant's wisdom with ASCII art portrait.

![Version](https://img.shields.io/badge/version-1.0.0-blue)
![Go](https://img.shields.io/badge/Go-1.20+-00ADD8?logo=go)
![License](https://img.shields.io/badge/license-MIT-green)

## ✨ Features

- 🎨 **ASCII Art Portrait**: Beautiful ASCII representation of Naval Ravikant
- 💬 **50+ Curated Quotes**: Inspiring quotes on wealth, happiness, and life
- 🎯 **Simple & Fast**: Instant wisdom in your terminal
- 🌈 **Colored Output**: Beautiful colored display (can be disabled)
- 📦 **Zero Dependencies**: Single binary, works everywhere

## 📦 Installation

### Quick Install (Unix/Linux/macOS)

```bash
curl -sSL https://raw.githubusercontent.com/wimpywarlord/naval-cli/main/install.sh | bash
```

### Homebrew (macOS/Linux)

```bash
brew tap wimpywarlord/naval-cli
brew install naval-cli
```

### Go Install

```bash
go install github.com/wimpywarlord/naval-cli@latest
```

### Download Binary

Download the latest binary for your platform from the [releases page](https://github.com/wimpywarlord/naval-cli/releases).

#### Platform-specific instructions:

**macOS:**
```bash
# Download (Intel Mac)
curl -L https://github.com/wimpywarlord/naval-cli/releases/latest/download/naval-cli-darwin-amd64 -o naval-cli

# Download (Apple Silicon)
curl -L https://github.com/wimpywarlord/naval-cli/releases/latest/download/naval-cli-darwin-arm64 -o naval-cli

# Make executable
chmod +x naval-cli

# Move to PATH (optional)
sudo mv naval-cli /usr/local/bin/
```

**Linux:**
```bash
# Download
curl -L https://github.com/wimpywarlord/naval-cli/releases/latest/download/naval-cli-linux-amd64 -o naval-cli

# Make executable
chmod +x naval-cli

# Move to PATH (optional)
sudo mv naval-cli /usr/local/bin/
```

**Windows:**
```powershell
# Download the .exe from releases page
# Or use scoop (if available):
scoop bucket add wimpywarlord https://github.com/wimpywarlord/scoop-bucket
scoop install naval-cli
```

### Build from Source

```bash
# Clone the repository
git clone https://github.com/wimpywarlord/naval-cli.git
cd naval-cli

# Build
go build -o naval-cli

# Install globally (optional)
go install
```

## 🚀 Usage

### Basic Commands

```bash
# Display a random quote with ASCII art
naval-cli

# Display quote without ASCII art
naval-cli --no-ascii

# Display multiple quotes
naval-cli --count 3

# Disable colors
naval-cli --no-color

# Show help
naval-cli --help

# Show version
naval-cli --version
```

### Example Output

```
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠛⠁⠀⠀⠀⠀⠈⠀⠀⠉⠀⠀⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡀⠀⠀⠙⢿⣿⣿⣿⣿⣿⣿⣿     "Seek wealth, not money or status.
⠛⠿⠿⢿⣿⣿⣿⣿⣿⣿⠁⠀⠀⠀⠀⣀⣄⣤⣤⣤⣤⣴⣷⣿⣆⠀⢄⠈⣿⣿⣿⣿⣿⣿⣿      Wealth is having assets that earn
⠀⠀⠀⢸⣿⣿⣿⣿⣿⡿⠀⠀⠀⠀⣼⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⢠⣴⣿⣿⣿⣿⣿⣿⣿      while you sleep."
⣇⠀⠀⢸⣿⣿⣿⣿⣿⠃⠀⠀⠀⠐⠻⠿⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡀⢿⣿⣿⣿⣿⣿⣿⣿
⣿⣷⠀⠘⣿⣿⡿⠿⠿⠃⠀⠀⠀⠐⠛⠛⡓⢦⣹⣿⡟⢛⣉⣹⣿⣿⣇⢢⣿⣿⣿⣿⣿⣿⣿                    - Naval Ravikant
```

## ⚙️ Command-Line Options

| Flag | Description | Default |
|------|-------------|---------|
| `--no-ascii` | Display quote without ASCII art | `false` |
| `--count <n>` | Number of quotes to display | `1` |
| `--no-color` | Disable colored output | `false` |
| `--help` | Show help message | - |
| `--version` | Show version information | - |

## 🎯 Use Cases

```bash
# Morning motivation
naval-cli

# Share wisdom with your team
naval-cli --count 5 --no-color > team-wisdom.txt

# Add to your shell startup (.bashrc, .zshrc)
echo "naval-cli" >> ~/.zshrc

# Use in scripts
wisdom=$(naval-cli --no-ascii --no-color)
echo "Today's wisdom: $wisdom"
```

## 🤝 Contributing

Contributions are welcome! Feel free to:

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

MIT License - see [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Naval Ravikant for his profound wisdom and insights
- The Go community for excellent tools and libraries
- ASCII art created with custom algorithms

## 📊 Stats

![GitHub stars](https://img.shields.io/github/stars/wimpywarlord/naval-cli?style=social)
![GitHub forks](https://img.shields.io/github/forks/wimpywarlord/naval-cli?style=social)

---

<p align="center">Made with ❤️ by <a href="https://github.com/wimpywarlord">wimpywarlord</a></p>
<p align="center">⭐ Star this repo if you find it useful!</p>
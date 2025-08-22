// Package display handles formatting and presenting quotes with optional ASCII art.
package display

import (
	"fmt"
	"strings"

	"github.com/wimpywarlord/naval-cli/internal/ascii"
	"github.com/wimpywarlord/naval-cli/pkg/naval"
)

// Presenter handles the display logic for quotes and ASCII art.
type Presenter struct {
	noColor bool
}

// New creates a new display presenter with color configuration.
func New(noColor bool) *Presenter {
	return &Presenter{
		noColor: noColor,
	}
}

// Single displays a single quote with optional ASCII art.
func (p *Presenter) Single(quote naval.Quote, noASCII bool) {
	if noASCII {
		p.QuoteOnly(quote)
	} else {
		p.WithASCII(quote)
	}
}

// Multiple displays multiple quotes without ASCII art (to avoid clutter).
func (p *Presenter) Multiple(quotes []naval.Quote) {
	for i, quote := range quotes {
		if i > 0 {
			fmt.Println(strings.Repeat("-", 50))
		}
		p.QuoteOnly(quote)
	}
}

// WithASCII displays a quote alongside Naval's ASCII art portrait.
func (p *Presenter) WithASCII(quote naval.Quote) {
	asciiArt := ascii.Get()
	wrappedText := p.wrapText(quote.Text, 40)
	lines := strings.Split(wrappedText, "\n")
	
	asciiLines := strings.Split(asciiArt, "\n")
	
	fmt.Println()
	
	for i, asciiLine := range asciiLines {
		if i < len(lines) {
			if p.noColor {
				fmt.Printf("%s     \"%s\n", asciiLine, lines[i])
			} else {
				fmt.Printf("\033[36m%s\033[0m     \033[33m\"%s\033[0m\n", asciiLine, lines[i])
			}
		} else if i == len(lines) {
			if p.noColor {
				fmt.Printf("%s\"                    %s\n", asciiLine, quote.Author)
			} else {
				fmt.Printf("\033[36m%s\033[0m\033[33m\"\033[0m                    \033[32m%s\033[0m\n", asciiLine, quote.Author)
			}
		} else {
			if p.noColor {
				fmt.Printf("%s\n", asciiLine)
			} else {
				fmt.Printf("\033[36m%s\033[0m\n", asciiLine)
			}
		}
	}
	
	fmt.Println()
}

// QuoteOnly displays just the quote text without ASCII art.
func (p *Presenter) QuoteOnly(quote naval.Quote) {
	fmt.Println()
	if p.noColor {
		fmt.Printf("\"%s\"\n\n%s\n", quote.Text, quote.Author)
	} else {
		fmt.Printf("\033[33m\"%s\"\033[0m\n\n\033[32m%s\033[0m\n", quote.Text, quote.Author)
	}
	fmt.Println()
}

// Help displays usage information.
func (p *Presenter) Help() {
	help := `naval-cli - Display Naval Ravikant's wisdom with ASCII art

USAGE:
    naval-cli [OPTIONS]

OPTIONS:
    --no-ascii       Display quote without ASCII art
    --count <n>      Number of quotes to display (default: 1)
    --no-color       Disable colored output
    --help           Show this help message
    --version        Show version information

EXAMPLES:
    naval-cli                    # Display random quote with ASCII art
    naval-cli --count 3          # Display 3 random quotes
    naval-cli --no-ascii         # Display quote without ASCII art
    naval-cli --no-color         # Display without colors

For more information, visit: https://github.com/wimpywarlord/naval-cli`

	fmt.Println(help)
}

// wrapText wraps text to specified width, respecting word boundaries.
func (p *Presenter) wrapText(text string, width int) string {
	words := strings.Fields(text)
	if len(words) == 0 {
		return text
	}
	
	var lines []string
	var currentLine strings.Builder
	
	for _, word := range words {
		if currentLine.Len() == 0 {
			currentLine.WriteString(word)
		} else if currentLine.Len()+1+len(word) <= width {
			currentLine.WriteString(" " + word)
		} else {
			lines = append(lines, currentLine.String())
			currentLine.Reset()
			currentLine.WriteString(word)
		}
	}
	
	if currentLine.Len() > 0 {
		lines = append(lines, currentLine.String())
	}
	
	return strings.Join(lines, "\n")
}
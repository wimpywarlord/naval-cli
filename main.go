package main

import (
	"flag"
	"fmt"
	"os"
	"strings"
	"text/tabwriter"
	
	"github.com/fatih/color"
)

func main() {
	var (
		noASCII   = flag.Bool("no-ascii", false, "Display quote without ASCII art")
		count     = flag.Int("count", 1, "Number of quotes to display")
		noColor   = flag.Bool("no-color", false, "Disable colored output")
		help      = flag.Bool("help", false, "Show help message")
		version   = flag.Bool("version", false, "Show version information")
	)

	flag.Parse()

	if *noColor {
		color.NoColor = true
	}

	if *help {
		printHelp()
		os.Exit(0)
	}

	if *version {
		fmt.Println(GetVersionInfo())
		fmt.Println("A CLI tool for Naval Ravikant's wisdom")
		os.Exit(0)
	}

	if *count < 1 {
		*count = 1
	}

	if *count == 1 {
		displaySingleQuote(*noASCII)
	} else {
		displayMultipleQuotes(*count, *noASCII)
	}
}

func displaySingleQuote(noASCII bool) {
	quote := GetRandomQuote()
	
	if !noASCII {
		displayWithASCII(quote)
	} else {
		displayQuoteOnly(quote)
	}
}

func displayMultipleQuotes(count int, noASCII bool) {
	quotes := GetMultipleQuotes(count)
	
	if !noASCII && count == 1 {
		displayWithASCII(quotes[0])
		return
	}
	
	numberColor := color.New(color.FgGreen, color.Bold)
	quoteColor := color.New(color.FgWhite)
	authorColor := color.New(color.FgYellow, color.Bold)
	
	for i, quote := range quotes {
		fmt.Println()
		numberColor.Printf("[%d] ", i+1)
		quoteColor.Println(wrapText(quote.Text, 70))
		fmt.Print("    ")
		authorColor.Println(quote.Author)
	}
	fmt.Println()
}

func displayWithASCII(quote Quote) {
	ascii := GetNavalASCII()
	asciiLines := strings.Split(ascii, "\n")
	quoteText := wrapText(quote.Text, 50)
	quoteLines := strings.Split(quoteText, "\n")
	
	w := tabwriter.NewWriter(os.Stdout, 0, 0, 2, ' ', 0)
	
	maxLines := len(asciiLines)
	if len(quoteLines)+2 > maxLines {
		maxLines = len(quoteLines) + 2
	}
	
	quoteStartLine := (maxLines - len(quoteLines)) / 2
	
	cyan := color.New(color.FgCyan)
	yellow := color.New(color.FgYellow, color.Bold)
	white := color.New(color.FgWhite)
	
	for i := 0; i < maxLines; i++ {
		var asciiLine string
		if i < len(asciiLines) {
			asciiLine = cyan.Sprint(asciiLines[i])
		}
		
		var quoteLine string
		quoteIndex := i - quoteStartLine
		if quoteIndex >= 0 && quoteIndex < len(quoteLines) {
			quoteLine = white.Sprint(quoteLines[quoteIndex])
		} else if quoteIndex == len(quoteLines)+1 {
			quoteLine = yellow.Sprint(quote.Author)
		}
		
		fmt.Fprintf(w, "%s\t%s\n", asciiLine, quoteLine)
	}
	
	w.Flush()
}

func displayQuoteOnly(quote Quote) {
	fmt.Println()
	color.White(wrapText(quote.Text, 70))
	fmt.Println()
	color.New(color.FgYellow, color.Bold).Println(quote.Author)
	fmt.Println()
}

func wrapText(text string, width int) string {
	words := strings.Fields(text)
	var lines []string
	var currentLine string
	
	for _, word := range words {
		if len(currentLine)+len(word)+1 > width {
			if currentLine != "" {
				lines = append(lines, currentLine)
				currentLine = word
			} else {
				lines = append(lines, word)
			}
		} else {
			if currentLine == "" {
				currentLine = word
			} else {
				currentLine += " " + word
			}
		}
	}
	
	if currentLine != "" {
		lines = append(lines, currentLine)
	}
	
	return strings.Join(lines, "\n")
}

func printHelp() {
	fmt.Println("naval-cli - Display Naval Ravikant's wisdom")
	fmt.Println("\nUsage:")
	fmt.Println("  naval-cli [flags]")
	fmt.Println("\nFlags:")
	fmt.Println("  --no-ascii      Display quote without ASCII art")
	fmt.Println("  --no-color      Disable colored output")
	fmt.Println("  --count n       Display n quotes (default: 1)")
	fmt.Println("  --version       Show version information")
	fmt.Println("  --help          Show this help message")
	fmt.Println("\nExamples:")
	fmt.Println("  naval-cli                      # Display random quote with ASCII art")
	fmt.Println("  naval-cli --no-ascii           # Display quote without ASCII art")
	fmt.Println("  naval-cli --count 3            # Display 3 random quotes")
	fmt.Println("  naval-cli --no-color           # Display without colors")
}
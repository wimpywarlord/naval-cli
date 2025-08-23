package main

import (
	"flag"
	"fmt"
	"os"

	"github.com/fatih/color"
	"github.com/wimpywarlord/naval-cli/internal/display"
	"github.com/wimpywarlord/naval-cli/internal/quotes"
	"github.com/wimpywarlord/naval-cli/internal/version"
)

func main() {
	var (
		noASCII   = flag.Bool("no-ascii", false, "Display quote without ASCII art")
		count     = flag.Int("count", 1, "Number of quotes to display")
		noColor   = flag.Bool("no-color", false, "Disable colored output")
		help      = flag.Bool("help", false, "Show help message")
		versionFlag   = flag.Bool("version", false, "Show version information")
	)

	flag.Parse()

	if *noColor {
		color.NoColor = true
	}

	if *help {
		printHelp()
		os.Exit(0)
	}

	if *versionFlag {
		fmt.Println(version.Info())
		fmt.Println("A CLI tool for Naval Ravikant's wisdom")
		os.Exit(0)
	}

	if *count < 1 {
		*count = 1
	}

	// Initialize services
	quotesService := quotes.New()
	presenter := display.New(*noColor)

	// Display quotes
	if *count == 1 {
		quote := quotesService.GetRandom()
		presenter.Single(quote, *noASCII)
	} else {
		quotes := quotesService.GetMultiple(*count)
		presenter.Multiple(quotes)
	}
}

func printHelp() {
	fmt.Println(`naval-cli - Display Naval Ravikant's wisdom in your terminal

USAGE:
    naval-cli [OPTIONS]

OPTIONS:
    --no-ascii      Display quote without ASCII art
    --count <n>     Number of quotes to display (default: 1)
    --no-color      Disable colored output
    --help          Show this help message
    --version       Show version information

EXAMPLES:
    naval-cli                    # Display a random quote with ASCII art
    naval-cli --no-ascii         # Display quote without ASCII art
    naval-cli --count 5          # Display 5 random quotes
    naval-cli --no-color         # Display without colors

For more information, visit: https://github.com/wimpywarlord/naval-cli`)
}
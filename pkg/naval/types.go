// Package naval provides core types and interfaces for the Naval CLI application.
// This package contains public API types that could be reused by other applications.
package naval

// Quote represents a Naval Ravikant quote with its text and attribution.
type Quote struct {
	Text   string
	Author string
}

// Config holds configuration options for the CLI application.
type Config struct {
	NoASCII  bool
	NoColor  bool
	Count    int
	ShowHelp bool
}
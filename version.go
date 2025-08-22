package main

// Version information - can be overridden at build time using ldflags
// Example: go build -ldflags "-X main.Version=1.0.1 -X main.BuildDate=2024-01-01"
var (
	Version   = "1.0.0"
	BuildDate = "dev"
	GitCommit = "unknown"
)

// GetVersionInfo returns formatted version information
func GetVersionInfo() string {
	if BuildDate == "dev" {
		return "naval-cli v" + Version + " (development build)"
	}
	return "naval-cli v" + Version + " (built: " + BuildDate + ", commit: " + GitCommit + ")"
}
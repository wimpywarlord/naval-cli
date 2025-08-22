// Package version manages application version information and build metadata.
package version

// Build-time variables that can be overridden using ldflags.
// Example: go build -ldflags "-X github.com/wimpywarlord/naval-cli/internal/version.Version=1.0.1"
var (
	Version   = "1.0.0"
	BuildDate = "dev"
	GitCommit = "unknown"
)

// Info returns formatted version information including build metadata.
func Info() string {
	if BuildDate == "dev" {
		return "naval-cli v" + Version + " (development build)"
	}
	return "naval-cli v" + Version + " (built: " + BuildDate + ", commit: " + GitCommit + ")"
}

// Short returns just the version number.
func Short() string {
	return Version
}
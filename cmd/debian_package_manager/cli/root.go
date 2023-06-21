// Copyright 2022 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package cli

import (
	"fmt"
	"os"

	"github.com/spf13/cobra"
)

var (
	versionsFile    = "versions.bzl"
	packagesOutFile = "packages.bzl"
	snapshotsFile   = "snapshots.yaml"
	packagesFile    = "packages.yaml"

	rootCmd = &cobra.Command{
		Use:   "debian_package_manager",
		Short: "A debian package index parser with bazel config generation",
		Run: func(cmd *cobra.Command, args []string) {
			_ = cmd.Help()
		},
		CompletionOptions: cobra.CompletionOptions{
			HiddenDefaultCmd: true,
		},
	}
)

// Execute executes the root command.
func Execute() {
	rootCmd.PersistentFlags().StringVar(
		&versionsFile,
		"versions-out",
		versionsFile,
		"location to generate BAZEL debian versions configs",
	)
	rootCmd.PersistentFlags().StringVar(
		&packagesOutFile,
		"packages-out",
		packagesOutFile,
		"location to generate BAZEL deb archive repository config",
	)
	rootCmd.PersistentFlags().StringVar(
		&snapshotsFile,
		"snapshots",
		snapshotsFile,
		"location of snapshots YAML config file (might be overwritten)",
	)
	rootCmd.PersistentFlags().StringVar(
		&packagesFile,
		"packages",
		packagesFile,
		"location of packages YAML config file",
	)
	rootCmd.AddCommand(
		updateCMD,
		generateCMD,
	)

	if err := rootCmd.Execute(); err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}
}

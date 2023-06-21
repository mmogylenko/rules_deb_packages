package config

import (
	"fmt"
	"os"
	"testing"
)

var tmpfile *os.File

func TestMain(m *testing.M) {
	var err error

	tmpfile, err = os.CreateTemp("", "packages.*.yaml")
	if err != nil {
		panic(err)
	}

	content := []byte(`debian_packages:
  distros: ["debian12"]
  archs: ["amd64", "arm64"]
  packages:
    - "ca-certificates"
    - "curl"
other_stuff:
  bazel:
    sha256:
      arm64: 16e41fe8fb791ffb9835643435e4828384a1890b0f916fd84b750fa01f783807
    url: https://github.com/bazelbuild/bazel/releases/download/0.0.1/bazel-0.0.1-linux-arm64
    version: 0.0.1`)

	if _, err = tmpfile.Write(content); err != nil {
		fmt.Printf("Cannot write to temp file: %v\n", err)
		os.Exit(1)
	}

	os.Exit(m.Run())
}

func TestLoadPackages(t *testing.T) {
	_, err := LoadPackages(tmpfile.Name())
	if err != nil {
		t.Fatalf("expected no error, got %v", err)
	}
}

func TestPackagesGet(t *testing.T) {
	packages, err := LoadPackages(tmpfile.Name())
	if err != nil {
		t.Fatalf("expected no error, got %v", err)
	}

	testCases := []struct {
		archStr    string
		distroStr  string
		wantErr    bool
		wantPkg    string
		wantPkgVal bool
	}{
		{"amd64", "debian12", false, "curl", true},
		{"amd64", "debian12", false, "ca-certificates", true},
		{"amd64", "debian11", true, "", false},
	}

	for _, tc := range testCases {
		arch, err := ArchFromString(tc.archStr)
		if err != nil {
			t.Errorf("invalid arch: %v", err)
			continue
		}

		distro, err := DistroFromString(tc.distroStr)
		if err != nil {
			t.Errorf("invalid distro: %v", err)
			continue
		}

		pkgMap, err := packages.Get(arch, distro)
		if tc.wantErr && err == nil {
			t.Errorf("expected error, got nil")
		} else if !tc.wantErr && err != nil {
			t.Errorf("unexpected error: %v", err)
		}

		if pkgVal, ok := pkgMap[tc.wantPkg]; ok {
			if pkgVal != tc.wantPkgVal {
				t.Errorf("unexpected package value for %s: got %v, want %v", tc.wantPkg, pkgVal, tc.wantPkgVal)
			}
		} else if tc.wantPkgVal {
			t.Errorf("expected package %s to be present, but it was not", tc.wantPkg)
		}
	}
}

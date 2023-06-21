# Examples

## Build a Debian-based OCI Container image

1. Define required DEB Packages in `packages.yaml` file. Example:

```yaml
---
debian_packages:
  distros: ["debian12"]
  archs: ["amd64", "arm64"]
  packages:
    - "base-files"
    - "bash"
    - "debianutils"
    - "ca-certificates"
    - "coreutils"
    - "libc6"
    - "libpcre2-8-0"
    - "libselinux1"
    - "libtinfo6"
```

2. Write Packages to a source tree:

```bash
~ bazel run save_packages
INFO: Analyzed target //:save_packages (24 packages loaded, 92 targets configured).
INFO: Found 1 target...
INFO: From Updating debian packages...:
URL: https://snapshot.debian.org/archive/debian/?year=2023&month=6, Status: 200 OK
URL: https://snapshot.debian.org/archive/debian-security/?year=2023&month=6, Status: 200 OK
No snapshot file found at "bazel-out/darwin_arm64-fastbuild/bin/debian_output/snapshots.yaml", using latest from debian
Updating Config
Processing packages at debian(20230618T090734Z), security (20230620T221511Z)...
URL: https://snapshot.debian.org/archive/debian/20230618T090734Z/dists/bookworm/main/binary-arm64/Packages.xz, Status: 200 OK
URL: https://snapshot.debian.org/archive/debian/20230618T090734Z/dists/bookworm/main/binary-amd64/Packages.xz, Status: 200 OK
URL: https://snapshot.debian.org/archive/debian/20230618T090734Z/dists/bookworm-updates/main/binary-amd64/Packages.xz, Status: 200 OK
URL: https://snapshot.debian.org/archive/debian/20230618T090734Z/dists/bookworm-updates/main/binary-arm64/Packages.xz, Status: 200 OK
URL: https://snapshot.debian.org/archive/debian-security/20230620T221511Z/dists/bookworm-security/main/binary-amd64/Packages.xz, Status: 200 OK
URL: https://snapshot.debian.org/archive/debian-security/20230620T221511Z/dists/bookworm-security/main/binary-arm64/Packages.xz, Status: 200 OK
debian12 amd64 [main updates security]
debian12 arm64 [main updates security]
Writing bazel file: "bazel-out/darwin_arm64-fastbuild/bin/debian_output/packages.bzl"
Writing BUILD file...
Writing version file: "bazel-out/darwin_arm64-fastbuild/bin/debian_output/versions.bzl"
Writing snapshots file: "bazel-out/darwin_arm64-fastbuild/bin/debian_output/snapshots.yaml"
Target //:save_packages up-to-date:
  bazel-bin/save_packages_update.sh
INFO: Elapsed time: 28.067s, Critical Path: 23.90s
INFO: 6 processes: 5 internal, 1 darwin-sandbox.
INFO: Build completed successfully, 6 total actions
INFO: Running command line: bazel-bin/save_packages_update.sh
Copying directory /private/var/tmp/_bazel_user/2b9818d5afe87609e67f7c8837d72ec4/execroot/_main/bazel-out/darwin_arm64-fastbuild/bin/save_packages_update.sh.runfiles/_main/debian_output to packages in rules_deb_packages/examples
```

3. Build and Test Container Image:

```bash
bazel run //containers/base:test
INFO: Analyzed target //containers/base:test (55 packages loaded, 995 targets configured).
INFO: Found 1 target...
Target //containers/base:test up-to-date:
  bazel-bin/containers/base/test.sh
INFO: Elapsed time: 2.999s, Critical Path: 1.03s
INFO: 3 processes: 2 internal, 1 darwin-sandbox.
INFO: Build completed successfully, 3 total actions
INFO: Running command line: external/bazel_tools/tools/test/test-setup.sh containers/base/test.sh
exec ${PAGER:-/usr/bin/less} "$0" || exit 1
Executing tests from //containers/base:test
-----------------------------------------------------------------------------

===================================
====== Test file: tests.yaml ======
===================================
=== RUN: File Content Test: Debian Distro Check
--- PASS
duration: 0s
=== RUN: File Existence Test: Root
--- PASS
duration: 0s
=== RUN: File Existence Test: ca-certificates
--- PASS
duration: 0s
=== RUN: Metadata Test
--- PASS
duration: 0s

===================================
============= RESULTS =============
===================================
Passes:      4
Failures:    0
Duration:    0s
Total tests: 4

PASS
```

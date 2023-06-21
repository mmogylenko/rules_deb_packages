"""Installs Go dependencies for the dpkg_status."""

load("@bazel_gazelle//:deps.bzl", "go_repository")

def dpkg_status_deps():
    """Installs Go dependencies for the dpkg_status."""
    pass
    go_repository(
        name = "com_github_ulikunitz_xz",
        build_file_proto_mode = "disable_global",
        importpath = "github.com/ulikunitz/xz",
        sum = "h1:kpFauv27b6ynzBNT/Xy+1k+fK4WswhN/6PN5WhFAGw8=",
        version = "v0.5.11",
    )

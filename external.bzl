"""Our "development" dependencies

Users should *not* need to install these. If users see a load()
statement from these, that's a bug in our distribution.
"""

load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies")
load("@buildifier_prebuilt//:defs.bzl", "buildifier_prebuilt_register_toolchains")
load("@buildifier_prebuilt//:deps.bzl", "buildifier_prebuilt_deps")
load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")
load("@rules_pkg//:deps.bzl", "rules_pkg_dependencies")
load("//cmd/debian_package_manager:deps.bzl", "debian_package_manager_deps")
load("//cmd/debian_spdx:deps.bzl", "debian_spdx_deps")

def _gazelle_ignore(**_kwargs):
    """Dummy macro which causes gazelle to see a repository as already defined."""

def _rule_dependencies():
    """Rule dependencies."""
    go_rules_dependencies()
    go_register_toolchains(version = "1.19.3")
    gazelle_dependencies()
    buildifier_prebuilt_deps()
    buildifier_prebuilt_register_toolchains()

    rules_pkg_dependencies()

def _go_dependencies():
    """Go dependencies."""

    _gazelle_ignore(
        name = "com_github_bazelbuild_rules_go",
        actual = "io_bazel_rules_go",
        importpath = "github.com/bazelbuild/rules_go",
    )

    debian_package_manager_deps()
    debian_spdx_deps()

def rules_deb_external_deps():
    _rule_dependencies()
    _go_dependencies()

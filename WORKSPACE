workspace(name = "rules_deb_packages")

load(":repositories.bzl", "rules_deb_repositories")

# gazelle:repo bazel_gazelle
rules_deb_repositories()

load(":external.bzl", "rules_deb_external_deps")

# gazelle:repository_macro cmd/debian_spdx/deps.bzl%debian_spdx_deps
# gazelle:repository_macro cmd/debian_package_manager/deps.bzl%debian_package_manager_deps
rules_deb_external_deps()

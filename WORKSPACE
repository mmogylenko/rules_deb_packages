workspace(name = "rules_deb_packages")

load("//:repositories.bzl", "rules_deb_repositories")

# gazelle:repo bazel_gazelle
rules_deb_repositories()

load("//:internal_deps.bzl", "rules_deb_internal_deps")

# gazelle:repository_macro cmd/debian_package_manager/deps.bzl%debian_package_manager_deps
# gazelle:repository_macro cmd/debian_spdx/deps.bzl%debian_spdx_deps
# gazelle:repository_macro cmd/dpkg_status/deps.bzl%dpkg_status_deps
# gazelle:repository_macro cmd/oci_image_spdx/deps.bzl%oci_image_spdx_deps
rules_deb_internal_deps()

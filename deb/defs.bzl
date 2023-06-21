"# DEB Rules"

# buildifier: disable=bzl-visibility
load("//deb/private/rules:debian_package.bzl", _debian_package = "debian_package")

# buildifier: disable=bzl-visibility
load("//deb/private/rules:update_packages.bzl", _update_debian_packages = "update_debian_packages")

# buildifier: disable=bzl-visibility
load("//deb/private/rules/pkg:oci_image_spdx.bzl", _oci_image_spdx = "oci_image_spdx")

debian_package = _debian_package
oci_image_spdx = _oci_image_spdx
update_debian_packages = _update_debian_packages

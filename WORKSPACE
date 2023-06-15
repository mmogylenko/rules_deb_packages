workspace(name = "rules_deb_packages")

load(":internal_deps.bzl", "rules_deb_internal_deps")

rules_deb_internal_deps()

#load("//deb:repositories.bzl", "deb_register_toolchains", "rules_deb_dependencies")

#rules_deb_dependencies()

#deb_register_toolchains(
#    name = "deb_register_toolchains",
#    deb_version = "0.0.1",
#)

load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies")
load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")
load("//cmd/debian_package_manager:deps.bzl", "go_dependencies")

# gazelle:repository_macro cmd/debian_package_manager/deps.bzl%go_dependencies
go_dependencies()

go_rules_dependencies()

go_register_toolchains(version = "1.19.3")

gazelle_dependencies()

load("@buildifier_prebuilt//:deps.bzl", "buildifier_prebuilt_deps")

buildifier_prebuilt_deps()

load("@buildifier_prebuilt//:defs.bzl", "buildifier_prebuilt_register_toolchains")

buildifier_prebuilt_register_toolchains()

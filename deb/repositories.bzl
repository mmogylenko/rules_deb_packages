"""
Provides functions to pull all external package dependencies of this repository.
"""

load("@bazel_gazelle//:deps.bzl", "go_repository")
load("//deb/private:toolchains_repo.bzl", "PLATFORMS", "toolchains_repo")

def rules_deb_dependencies():
    """Pull in external Go packages needed by Go binaries in this repo. """

    # maybe(
    #     http_archive,
    #     name = "rules_pkg",
    #     urls = [
    #         "https://mirror.bazel.build/github.com/bazelbuild/rules_pkg/releases/download/0.9.1/rules_pkg-0.9.1.tar.gz",
    #         "https://github.com/bazelbuild/rules_pkg/releases/download/0.9.1/rules_pkg-0.9.1.tar.gz",
    #     ],
    #     sha256 = "8f9ee2dc10c1ae514ee599a8b42ed99fa262b757058f65ad3c384289ff70c4b8",
    # )

    go_repository(
        name = "com_github_ulikunitz_xz",
        importpath = "github.com/ulikunitz/xz",
        sum = "h1:kpFauv27b6ynzBNT/Xy+1k+fK4WswhN/6PN5WhFAGw8=",
        version = "v0.5.11",
    )

    go_repository(
        name = "com_github_spdx_tools_golang",
        importpath = "github.com/spdx/tools-golang",
        sum = "h1:9B623Cfs+mclYK6dsae7gLSwuIBHvlgmEup87qpqsAQ=",
        version = "v0.3.1-0.20230104082527-d6f58551be3f",
    )

_DOC = "TODO"
_ATTRS = {
    "deb_version": attr.string(mandatory = True),
    "platform": attr.string(mandatory = True, values = PLATFORMS.keys()),
}

def _deb_repo_impl(repository_ctx):
    repository_ctx.report_progress("Downloading DEB releases info")
    repository_ctx.download(
        url = ["https://api.github.com/repos/mmogylenko/rules_deb_packages/releases"],
        output = "versions.json",
    )
    versions = repository_ctx.read("versions.json")
    version_found = False
    for v in json.decode(versions):
        version = v["tag_name"].lstrip("v")
        if version == repository_ctx.attr.deb_version:
            version_found = True
    if not version_found:
        fail("did not find {} version in https://api.github.com/repos/mmogylenko/rules_deb_packages/releases".format(repository_ctx.attr.yq_version))

    file_url = "https://github.com/mmogylenko/rules_deb_packages/releases/download/v{}/debian_package_manager_{}".format(repository_ctx.attr.yq_version, repository_ctx.attr.platform)

    repository_ctx.report_progress("Downloading and extracting YQ toolchain")
    repository_ctx.download(
        url = file_url,
        output = "debian_package_manager",
        executable = True,
    )

    build_content = """#Generated by deb/repositories.bzl
load("@rules_deb_packages//deb:toolchain.bzl", "deb_toolchain")
deb_toolchain(name = "deb_toolchain", target_tool = "debian_package_manager")
)
"""

    # Base BUILD file for this repository
    repository_ctx.file("BUILD.bazel", build_content)

deb_repositories = repository_rule(
    _deb_repo_impl,
    doc = _DOC,
    attrs = _ATTRS,
)

# Wrapper macro around everything above, this is the primary API
def deb_register_toolchains(name, **kwargs):
    """Convenience macro for users which does typical setup.

    - create a repository for each built-in platform like "yq_linux_amd64" -
      this repository is lazily fetched when yq is needed for that platform.
    - TODO: create a convenience repository for the host platform like "yq_host"
    - create a repository exposing toolchains for each platform like "yq_platforms"
    - register a toolchain pointing at each platform
    Users can avoid this macro and do these steps themselves, if they want more control.

    Args:
        name: base name for all created repos, like "yq0_6_1"
        **kwargs: passed to each yq_repositories call
    """
    for platform in PLATFORMS.keys():
        deb_repositories(
            name = name + "_" + platform,
            platform = platform,
            **kwargs
        )
        native.register_toolchains("@%s_toolchains//:%s_toolchain" % (name, platform))

    toolchains_repo(
        name = name + "_toolchains",
        user_repository_name = name,
    )

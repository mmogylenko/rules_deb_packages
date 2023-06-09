"""
Provides functions to pull all external package dependencies of this repository.
"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

BINARY = dict({
    "0.0.1": {
        "darwin_amd64": "8e0f74e5745a41eeaa4ad3c5db1faec08defa0bf5067ca4e66e263c600d4ce9f",
        "darwin_arm64": "745404c6b9260591113eeca22c44f1b461a3fd98892eddc6f41e634c69a3edce",
        "linux_amd64": "2d5114699bdb5326daecf4e46518efbadf1adace6474c5bb844e98e3dd063116",
        "linux_arm64": "7dbe65065712c9bb9c4b81b04b3c66d2af40d42aa8031bc66b37d69aa991c7bb",
    },
})

LATEST_VERSION = BINARY.keys()[0]

def deb_packages_dependencies():
    """Pull in external Go packages needed by Go binaries in this repo. """

    # buildifier: disable=no-effect
    [
        maybe(
            http_file,
            name = "update_deb_packages_{}".format(platform),
            sha256 = BINARY[LATEST_VERSION][platform],
            urls = [
                #"https://github.com/mmogylenko/rules_deb_packages/releases/download/v{}/update_deb_packages_{}".format(version, platform),
                "http://localhost:8080/update_deb_packages_{}".format(platform),
            ],
            build_file_content = "exports_files(['update_deb_packages'])",
        )
        for platform in BINARY[LATEST_VERSION].keys()
    ]

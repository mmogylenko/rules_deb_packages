"""
Provides functions to pull all external package dependencies of this repository.
"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

BINARY = dict({
    "0.0.1": {
        "darwin_arm64": "950439759ece902157cf915b209b8d694e6f675eaab5099fb7894f30eeaee9a2",
    },
})

def deb_packages_dependencies():
    """Pull in external Go packages needed by Go binaries in this repo. """

    # buildifier: disable=no-effect
    [
        maybe(
            http_file,
            name = "update_deb_packages_{}".format(platform),
            sha256 = HELM[version][platform],
            urls = [
                #"https://github.com/mmogylenko/rules_deb_packages/releases/download/v{}/update_deb_packages_{}".format(version, platform),
                "http://localhost:8080/update_deb_packages_{}".format(platform),
            ],
            build_file_content = "exports_files(['update_deb_packages'])",
        )
        for version in BINARY.keys()
        for platform in BINARY[version].keys()
    ]

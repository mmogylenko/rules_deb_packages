"""This module defines Ubuntu Jammy dependencies."""

load("@rules_deb_packages//:deb_packages.bzl", "deb_packages")

def ubuntu_jammy_amd64():
    deb_packages(
        name = "ubuntu_jammy_amd64",
        arch = "amd64",
        packages = {
            "ca-certificates": "pool/main/c/ca-certificates/ca-certificates_20230311ubuntu0.22.04.1_all.deb",
            "curl": "pool/main/c/curl/curl_7.81.0-1ubuntu1.10_amd64.deb",
        },
        packages_sha256 = {
            "ca-certificates": "8ddd3b5d72fa144e53974d6a5782d25a0a9e1eec006118ecf2b76d53a7530f6a",
            "curl": "aaaa7e1d0b6fb68e89803b3007af804a3e167e39c4910fdbbfbf35e451c5a71b",
        },
        sources = [
            "http://us.archive.ubuntu.com/ubuntu jammy main",
            "http://us.archive.ubuntu.com/ubuntu jammy-updates main",
            "http://us.archive.ubuntu.com/ubuntu jammy-backports main",
            "http://security.ubuntu.com/ubuntu jammy-security main universe",
        ],
        urls = [
            "http://us.archive.ubuntu.com/ubuntu/$(package_path)",
            "http://security.ubuntu.com/ubuntu/$(package_path)",
            # Needed in case of superseded archive no more available on the mirrors
            "https://launchpad.net/ubuntu/+archive/primary/+files/$(package_file)",
        ],
    )

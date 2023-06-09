"""This module defines Ubuntu Jammy dependencies."""

load("@rules_deb_packages//:deb_packages.bzl", "deb_packages")

def ubuntu_jammy_arm64():
    deb_packages(
        name = "ubuntu_jammy_arm64",
        arch = "arm64",
        packages = {
            "ca-certificates": "pool/main/c/ca-certificates/ca-certificates_20230311ubuntu0.22.04.1_all.deb",
            "curl": "pool/main/c/curl/curl_7.81.0-1ubuntu1.10_arm64.deb",
        },
        packages_sha256 = {
            "ca-certificates": "8ddd3b5d72fa144e53974d6a5782d25a0a9e1eec006118ecf2b76d53a7530f6a",
            "curl": "f3f39952d7fbfacff1e52a19f0efe4ff0f053f0417190861e6aa134184bf20d2",
        },
        sources = [
            "http://ports.ubuntu.com/ubuntu-ports jammy main universe",
            "http://ports.ubuntu.com/ubuntu-ports jammy-updates main universe",
            "http://ports.ubuntu.com/ubuntu-ports jammy-backports main universe",
            "http://ports.ubuntu.com/ubuntu-ports jammy-security main universe",
        ],
        urls = [
            "http://ports.ubuntu.com/ubuntu-ports/$(package_path)",
            "http://ports.ubuntu.com/ubuntu-ports/$(package_path)",
            # Needed in case of superseded archive no more available on the mirrors
            "https://launchpad.net/ubuntu/+archive/primary/+files/$(package_file)",
        ],
    )

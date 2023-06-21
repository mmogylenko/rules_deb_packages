"""Debian packages. AUTO GENERATED"""

load("@rules_deb_packages//deb:defs.bzl", "debian_package")

def repositories():
    """Debian packages"""
    debian_package(
        name = "amd64_debian12_base-files",
        package_name = "base-files",
        sha256 = "7c64eea475f1ab59a7d44439ae55eb4f1a8b76d6f9d1de2773fd1ec2ba2b070b",
        urls = ["https://snapshot.debian.org/archive/debian/20230619T040601Z/pool/main/b/base-files/base-files_12.4_amd64.deb"],
    )
    debian_package(
        name = "amd64_debian12_bash",
        package_name = "bash",
        sha256 = "5325e63acaecb37f6636990328370774995bd9b3dce10abd0366c8a06877bd0d",
        urls = ["https://snapshot.debian.org/archive/debian/20230619T040601Z/pool/main/b/bash/bash_5.2.15-2+b2_amd64.deb"],
    )
    debian_package(
        name = "amd64_debian12_ca-certificates",
        package_name = "ca-certificates",
        sha256 = "5308b9bd88eebe2a48be3168cb3d87677aaec5da9c63ad0cf561a29b8219115c",
        urls = ["https://snapshot.debian.org/archive/debian/20230619T040601Z/pool/main/c/ca-certificates/ca-certificates_20230311_all.deb"],
    )
    debian_package(
        name = "amd64_debian12_coreutils",
        package_name = "coreutils",
        sha256 = "61038f857e346e8500adf53a2a0a20859f4d3a3b51570cc876b153a2d51a3091",
        urls = ["https://snapshot.debian.org/archive/debian/20230619T040601Z/pool/main/c/coreutils/coreutils_9.1-1_amd64.deb"],
    )
    debian_package(
        name = "amd64_debian12_debianutils",
        package_name = "debianutils",
        sha256 = "d98df4f21fc17d8436e230acb36acc8a53a74e3cbcfb13a96a9f823c32fda695",
        urls = ["https://snapshot.debian.org/archive/debian/20230619T040601Z/pool/main/d/debianutils/debianutils_5.7-0.4_amd64.deb"],
    )
    debian_package(
        name = "amd64_debian12_libc6",
        package_name = "libc6",
        sha256 = "b10216d317590ecbbb52569206bacaf4dbf5e252bc358ade5cdb45fb1cace45e",
        urls = ["https://snapshot.debian.org/archive/debian/20230619T040601Z/pool/main/g/glibc/libc6_2.36-9_amd64.deb"],
    )
    debian_package(
        name = "amd64_debian12_libpcre2-8-0",
        package_name = "libpcre2-8-0",
        sha256 = "030db54f4d76cdfe2bf0e8eb5f9efea0233ab3c7aa942d672c7b63b52dbaf935",
        urls = ["https://snapshot.debian.org/archive/debian/20230619T040601Z/pool/main/p/pcre2/libpcre2-8-0_10.42-1_amd64.deb"],
    )
    debian_package(
        name = "amd64_debian12_libselinux1",
        package_name = "libselinux1",
        sha256 = "2b07f5287b9105f40158b56e4d70cc1652dac56a408f3507b4ab3d061eed425f",
        urls = ["https://snapshot.debian.org/archive/debian/20230619T040601Z/pool/main/libs/libselinux/libselinux1_3.4-1+b6_amd64.deb"],
    )
    debian_package(
        name = "amd64_debian12_libtinfo6",
        package_name = "libtinfo6",
        sha256 = "072d908f38f51090ca28ca5afa3b46b2957dc61fe35094c0b851426859a49a51",
        urls = ["https://snapshot.debian.org/archive/debian/20230619T040601Z/pool/main/n/ncurses/libtinfo6_6.4-4_amd64.deb"],
    )
    debian_package(
        name = "arm64_debian12_base-files",
        package_name = "base-files",
        sha256 = "b63edb81b2a98f344eb64e4d6944df4291b5a8a9b665fff234d2f911f05fe329",
        urls = ["https://snapshot.debian.org/archive/debian/20230619T040601Z/pool/main/b/base-files/base-files_12.4_arm64.deb"],
    )
    debian_package(
        name = "arm64_debian12_bash",
        package_name = "bash",
        sha256 = "13c4e70030a059aeec6b745e4ce2949ce67405246bb38521e6c8f4d21c133543",
        urls = ["https://snapshot.debian.org/archive/debian/20230619T040601Z/pool/main/b/bash/bash_5.2.15-2+b2_arm64.deb"],
    )
    debian_package(
        name = "arm64_debian12_ca-certificates",
        package_name = "ca-certificates",
        sha256 = "5308b9bd88eebe2a48be3168cb3d87677aaec5da9c63ad0cf561a29b8219115c",
        urls = ["https://snapshot.debian.org/archive/debian/20230619T040601Z/pool/main/c/ca-certificates/ca-certificates_20230311_all.deb"],
    )
    debian_package(
        name = "arm64_debian12_coreutils",
        package_name = "coreutils",
        sha256 = "ec8f090a14c684879dce251254d8d9ed0876d4480f750d5807ef04e5435e1c4d",
        urls = ["https://snapshot.debian.org/archive/debian/20230619T040601Z/pool/main/c/coreutils/coreutils_9.1-1_arm64.deb"],
    )
    debian_package(
        name = "arm64_debian12_debianutils",
        package_name = "debianutils",
        sha256 = "2cdb5a5809edcec34549fcccc452deb56c966369e23675d6c507d4744c476f6f",
        urls = ["https://snapshot.debian.org/archive/debian/20230619T040601Z/pool/main/d/debianutils/debianutils_5.7-0.4_arm64.deb"],
    )
    debian_package(
        name = "arm64_debian12_libc6",
        package_name = "libc6",
        sha256 = "728a76108e2fefb151b92919115cbd0e753f7cb8def797fe09386d423c02fccf",
        urls = ["https://snapshot.debian.org/archive/debian/20230619T040601Z/pool/main/g/glibc/libc6_2.36-9_arm64.deb"],
    )
    debian_package(
        name = "arm64_debian12_libpcre2-8-0",
        package_name = "libpcre2-8-0",
        sha256 = "b2448d0a8a3db7fbeac231e7ef93811346c1fb5f96ccf6f631701d8a4eb39206",
        urls = ["https://snapshot.debian.org/archive/debian/20230619T040601Z/pool/main/p/pcre2/libpcre2-8-0_10.42-1_arm64.deb"],
    )
    debian_package(
        name = "arm64_debian12_libselinux1",
        package_name = "libselinux1",
        sha256 = "29201edf23ebae40844d6c289afdb9bba52f927d55096ed1b1cd37e040135edc",
        urls = ["https://snapshot.debian.org/archive/debian/20230619T040601Z/pool/main/libs/libselinux/libselinux1_3.4-1+b6_arm64.deb"],
    )
    debian_package(
        name = "arm64_debian12_libtinfo6",
        package_name = "libtinfo6",
        sha256 = "baef0f6776f84c7eed4f1146d6e5774689567dad43216894d41da02e6608e4b3",
        urls = ["https://snapshot.debian.org/archive/debian/20230619T040601Z/pool/main/n/ncurses/libtinfo6_6.4-4_arm64.deb"],
    )

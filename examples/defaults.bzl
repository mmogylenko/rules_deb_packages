"""
Container image rule that allows for multiple platforms to be specified.
"""

def deb_pkg(arch, distro, package):
    return "@{arch}_{distro}_{package}".format(arch = arch, distro = distro, package = package)

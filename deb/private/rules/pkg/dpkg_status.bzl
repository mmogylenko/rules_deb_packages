"""Dpkg status file generator"""

def _impl(ctx):
    output = ctx.actions.declare_file("%s.tar" % ctx.label.name)

    args = ctx.actions.args()
    args.add(ctx.file.control.path, format = "--control=%s")
    args.add(ctx.attr.package_name, format = "--package-name=%s")
    args.add("--output", output.path)

    toolchain = ctx.toolchains["@rules_deb_packages//deb:toolchain_type"]
    dpkg_status = toolchain.target_tool_paths.get("dpkg_status", None)

    ctx.actions.run(
        inputs = [ctx.file.control] + toolchain.tool_files,
        outputs = [output],
        executable = dpkg_status,
        arguments = [args],
    )

    return DefaultInfo(files = depset([output]))

dpkg_status = rule(
    implementation = _impl,
    attrs = {
        "control": attr.label(allow_single_file = [".tar", ".tar.xz", "tar.gz"]),
        "package_name": attr.string(mandatory = True),
    },
    toolchains = ["@rules_deb_packages//deb:toolchain_type"],
)

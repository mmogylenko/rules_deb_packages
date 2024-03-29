"""Debian SPDX generator"""
SPDX_CMD = """\
tmp="$(mktemp -d)"

tar -xf "$1" -C "$tmp" "./control" || tar -xf "$1" -C "$tmp" "control"

if  tar -xf "$2" -C "$tmp" "usr/share/doc/$3/copyright" >/dev/null 2>&1; then
    COPYRIGHT="$tmp/usr/share/doc/$3/copyright"
fi

if  tar -xf "$2" -C "$tmp" "./usr/share/doc/$3/copyright" >/dev/null 2>&1; then
    COPYRIGHT="$tmp/usr/share/doc/$3/copyright"
fi
shift
shift
shift
{generator} --control="$tmp/control" --copyright=$COPYRIGHT $@
"""

def _impl(ctx):
    output = ctx.actions.declare_file("%s.spdx.json" % ctx.label.name)

    args = ctx.actions.args()
    args.add(ctx.file.control.path)
    args.add(ctx.file.data.path)
    args.add(ctx.attr.package_name)
    args.add(ctx.attr.spdx_id, format = "--id=%s")
    args.add(output.path, format = "--output=%s")
    args.add(ctx.label, format = "--generates=%s")

    # TODO: multiple urls. it is not required at the moment since .deb are fetched without a fallback mirror.
    args.add(ctx.attr.urls[0], format = "--url=%s")
    args.add(ctx.attr.sha256, format = "--sha256=%s")

    toolchain = ctx.toolchains["@rules_deb_packages//deb:toolchain_type"]

    debian_spdx = toolchain.tools.get("debian_spdx", None)

    ctx.actions.run_shell(
        inputs = [ctx.file.control, ctx.file.data] + debian_spdx.files.to_list(),
        outputs = [output],
        command = SPDX_CMD.format(generator = debian_spdx.files.to_list()[0].path),
        #command = "$(location @deb_packages_darwin_arm64//:debian_spdx_darwin_arm64) > $@",
        tools = debian_spdx.files,
        toolchain = "@rules_deb_packages//deb:toolchain_type",
        arguments = [args],
    )

    return OutputGroupInfo(
        spdx = depset([output]),
    )

debian_spdx = rule(
    implementation = _impl,
    attrs = {
        "control": attr.label(mandatory = True, allow_single_file = [".tar", ".tar.xz", "tar.gz"]),
        "data": attr.label(mandatory = True, allow_single_file = [".tar", ".tar.xz", "tar.gz"]),
        "package_name": attr.string(mandatory = True),
        "sha256": attr.string(mandatory = True),
        "spdx_id": attr.string(mandatory = True),
        "urls": attr.string_list(mandatory = True),
    },
    toolchains = ["@rules_deb_packages//deb:toolchain_type"],
)

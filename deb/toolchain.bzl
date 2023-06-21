"""This module implements the language-specific toolchain rule.
"""

# buildifier: disable=bzl-visibility
load("//deb/private:toolchains_repo.bzl", "TOOLS")

# Avoid using non-normalized paths (workspace/../other_workspace/path)
def _to_manifest_path(ctx, file):
    if file.short_path.startswith("../"):
        return "external/" + file.short_path[3:]
    else:
        return ctx.workspace_name + "/" + file.short_path

def _deb_toolchain_impl(ctx):
    #tools = ["debian_package_manager", "debian_spdx", "dpkg_status", "oci_image_spdx"]
    tool_paths = {}
    tool_files_dict = {}

    for tool in TOOLS:
        attr = getattr(ctx.attr, tool, None)
        if attr:
            tool_file = attr.files.to_list()[0] if attr.files.to_list() else None
            if tool_file:
                tool_paths[tool] = _to_manifest_path(ctx, tool_file)
                tool_files_dict[tool] = tool_file

    tool_infos = {
        tool_name: struct(
            files = depset([tool_file]),
            runfiles = ctx.runfiles(files = [tool_file]),
        )
        for tool_name, tool_file in tool_files_dict.items()
    }

    template_variables = platform_common.TemplateVariableInfo({
        tool: path
        for tool, path in tool_paths.items()
    })

    toolchain_info = platform_common.ToolchainInfo(
        target_tool_paths = tool_paths,
        tool_files = list(tool_files_dict.values()),
        tools = tool_infos,
        template_variables = template_variables,
    )

    return [
        toolchain_info,
        template_variables,
    ]

deb_packages_toolchain = rule(
    implementation = _deb_toolchain_impl,
    attrs = {
        "debian_package_manager": attr.label(
            doc = "Hermetically downloaded debian_package_manager executable for the target platform.",
            mandatory = False,
            allow_files = True,
        ),
        "debian_spdx": attr.label(
            doc = "Hermetically downloaded debian_spdx executable for the target platform.",
            mandatory = False,
            allow_files = True,
        ),
        "dpkg_status": attr.label(
            doc = "Hermetically downloaded dpkg_status executable for the target platform.",
            mandatory = False,
            allow_files = True,
        ),
        "oci_image_spdx": attr.label(
            doc = "Hermetically downloaded oci_image_spdx executable for the target platform.",
            mandatory = False,
            allow_files = True,
        ),
    },
    doc = """Defines a deb compiler/runtime toolchain.

For usage see https://docs.bazel.build/versions/main/toolchains.html#defining-toolchains.
""",
)

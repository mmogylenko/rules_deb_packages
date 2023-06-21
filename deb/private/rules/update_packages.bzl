"""Update the debian packages."""

def _update_debian_packages(ctx):
    """Update the debian packages."""

    # Create a directory to store the output files
    output_dir = ctx.actions.declare_directory("debian_output")

    # Define the output file paths within the directory
    outs = [
        output_dir.path + "/" + f
        for f in [
            ctx.attr.packages_out,
            ctx.attr.snapshots,
            ctx.attr.versions_out,
        ]
    ]

    toolchain = ctx.toolchains["@rules_deb_packages//deb:toolchain_type"]
    debian_package_manager = toolchain.target_tool_paths.get("debian_package_manager", None)

    # Generate the output files within the directory
    ctx.actions.run(
        inputs =
            [ctx.file.packages] + toolchain.tool_files,
        executable = debian_package_manager,
        outputs = [output_dir],
        progress_message = "Updating debian packages...",
        arguments = [
            "--packages",
            ctx.file.packages.path,
            "--packages-out",
            outs[0],
            "--snapshots",
            outs[1],
            "--versions-out",
            outs[2],
            "update",
        ],
    )

    # Declare the BUILD.bazel file as a File object
    #build_file_path = output_dir.path + "/BUILD.packages.bazel"

    #build_file = ctx.actions.declare_file(build_file_path)
    #build_file = ctx.actions.declare_file("debian_output/BUILD.packages.bazel")
    #build_file = ctx.actions.declare_file(output_dir.path + "/BUILD.packages.bazel")
    #build_file = ctx.actions.declare_file("BUILD.packages.bazel")

    # Write the content to the BUILD.bazel file
    #     build_file_content = """
    # # Auto Generated BUILD.bazel file
    # # Define your targets here

    # exports_files(glob(["*"]))
    # """
    #     ctx.actions.write(
    #         output = build_file,
    #         content = build_file_content,
    #         is_executable = False,
    #     )

    # Return the directory as a DefaultInfo
    #return [DefaultInfo(files = depset([output_dir]))]
    return [DefaultInfo(files = depset([output_dir]))]

update_debian_packages = rule(
    implementation = _update_debian_packages,
    attrs = {
        "packages": attr.label(
            allow_single_file = True,
        ),
        "packages_out": attr.string(),
        "snapshots": attr.string(),
        "versions_out": attr.string(),
    },
    toolchains = ["@rules_deb_packages//deb:toolchain_type"],
)

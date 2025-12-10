return {
    live_mode_toggle = "enable",
    display = {
        "VirtualLine",
    },
    selected_interpreters = {
        "Generic",
    },
    
    interpreter_options = {
        Generic = {
            error_truncate = "long",

            NuShell = {
                supported_filetypes = { "nu" },
                extension = ".nu",
                interpreter = "nu",
            },
        },
    },
}

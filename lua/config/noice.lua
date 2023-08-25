local options = {
    popupmenu = {
        backend = "nui",
    },
    hover = {
        enabled = false,
    },
    signature = {
        enabled = false,
    },
    lsp = {
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            -- ["cmp.entry.get_documentation"] = true,
        },
    },
    presets = {
        bottom_search = true,
    },
    routes = {
        {
            filter = {
                event = "msg_show",
                any = {
                    { find = "%d+L, %d+B" },
                    { find = "; after #%d+" },
                    { find = "; before #%d+" },
                },
            },
            view = "mini",
        },
        {
            view = "cmdline_output",
            filter = { cmdline = "^:!" },
            opts = { stop = true },
        },
        {
            view = "popup",
            filter = { event = "msg_show", min_height = 20 },
            opts = { stop = true },
        },
        {
            view = "notify",
            filter = { event = "msg_show" },
        },
    },
}

return options

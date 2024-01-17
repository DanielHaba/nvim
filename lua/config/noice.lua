local options = {
    cmdline = {
        enabled = true,
        backend = "cmdline_popup"
    },
    popupmenu = {
        enabled = true,
        backend = "nui",
    },
    hover = {
        enabled = false,
    },
    signature = {
        enabled = false,
    },
    notify = {
        merge = true,
    },
    lsp = {
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            -- ["cmp.entry.get_documentation"] = true,
        },
    },
    presets = {
        bottom_search = false,
        command_palette = true,
    },
    views = {
        cmdline_popup = {
            border = {
                style = "none",
                padding = { 1, 1 },
            },
            filter_options = {},
            win_options = {
                winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorderFlat",
            },
        },
    },
    routes = {
        {
            view = "mini",
            filter = {
                event = "msg_show",
                kind = "",
                find = "written",
            },
            opts = { stop = true },
        },
        {
            filter = {
                event = "msg_show",
                kind = "search_count",
            },
            opts = { skip = true },
        },
        {
            filter = {
                event = "notify",
                find = "not support",
            },
            opts = { skip = true },
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

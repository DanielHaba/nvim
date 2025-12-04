return {
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
        enabled = true,
        merge = true,
        view = "notify",
    },
    lsp = {
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = false,
            ["vim.lsp.util.stylize_markdown"] = false,
            ["cmp.entry.get_documentation"] = false,
        },
        hover = {
            enabled = false,
        },
        signature = {
            enabled = false,
        },
    },
    presets = {
        bottom_search = false,
        command_palette = true,
    },
    views = {
        cmdline_popup = {
            filter_options = {},
            win_options = {
                -- winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorderFlat",
            },
        },
        popup = {
            size = {
                width = "80%",
                height = "60%",
            },
        },
        popupmenu = {
            size = {
                width = "80%",
                height = "60%",
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


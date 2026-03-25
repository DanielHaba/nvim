return {
    enabled = true,
    render_modes = true,
    -- render_modes = { "n", "c", "t" },
    completions = {
        lsp = {
            enabled = true,
        },
    },
    file_types = {
        "markdown", -- "vimwiki",
        "AgenticChat",
    },
    anti_conceal = {
        enabled = true,
        disabled_modes = false,
        above = 0,
        below = 0,
        ignore = {
            code_background = true,
            indent = true,
            sign = true,
            virtual_lines = true,
        },
    },
    code = {
        left_pad = 2,
        right_pad = 10,
        min_width = 60,
        width = "block",
        position = "right",
    },
    indent = {
        enabled = true,
        skip_level = 0,
        skip_heading = true,
    },
    heading = {
        border = true,
        border_virtual = true,
    },
    quote = {
        enabled = true,
        repeat_linebreak = true,
        highlight = {
            "RenderMarkdownQuote1",
            "RenderMarkdownQuote2",
            "RenderMarkdownQuote3",
            "RenderMarkdownQuote4",
            "RenderMarkdownQuote5",
            "RenderMarkdownQuote6",
        },
    },
    pipe_table = {
        preset = "round",
        min_width = 12,
        cell = "trimmed",
    },
    sign = {
        enabled = true,
        priority = nil,
        highlight = "RenderMarkdownSign",
    },
    win_options = {
        showbreak = {
            default = "",
            rendered = "  ",
        },
        breakindent = {
            default = false,
            rendered = true,
        },
        breakindentopt = {
            default = "",
            rendered = "",
        },
    },
    overrides = {
        filetype = {
            AgenticChat = {
                code = {
                    style = "normal",
                    width = "full",
                    position = "left",
                    border = "thick",
                    left_pad = 0,
                },
                indent = { enabled = false },
            },
        },
    },
}

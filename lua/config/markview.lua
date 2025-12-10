return {

    markdown = {
        enabled = true,
        block_quotes = { wrap = false },
        headings = { org_indent_wrap = false },
        list_items = { wrap = false },
        tables = { wrap = false },
    },
    preview = { 
        enable = true,
        enable_hybrid_mode = true,
        icon_provider = "mini",
        map_gx = true,
        filetypes = { "markdown", "quarto", "rmd", "typst", "org" },

    },
    html = { enabled = true },
    latex = { enabled = true },
    markdown_inline = { enabled = true },
    typst = { enabled = true },
    yaml = { enabled = true },
    experimental = {
        prefer_nvim = true,
        file_open_command = "tabnew",
    },
}

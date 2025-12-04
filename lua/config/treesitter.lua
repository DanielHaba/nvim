return {
    ensure_installed = {
        -- general
        "vim",
        "vimdoc",
        "markdown",
        "markdown_inline",
        "query",
        "regex",
        "latex",
        "typst",
        "sql",
        "graphql",
        "dockerfile",
        "proto",
        "nu",
        "comment",

        -- git
        "diff",
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",

        -- configs
        "yaml",
        "toml",
        "json",
        "jsonc",
        "terraform",

        -- c
        "cmake",
        "make",
        "c",
        "cpp",
        "c_sharp",

        -- rust
        "rust",

        -- lua
        "lua",

        -- go
        "go",
        "gomod",
        "gosum",
        "gowork",
        "gotmpl",

        -- python
        "python",

        -- web
        "http",
        "html",
        "css",
        "scss",
        "javascript",
        "typescript",
        "tsx",
        "jsdoc",

    },
    textobjects = {
        selectors = {
            f = "@function",
            t = "@class",
            d = "@condition",
            l = "@loop",
            c = "@comment",
            p = "@parameter",
            e = "@block",
            m = "@call",
            r = "@return",
            s = "@statement",
            P = "@pipeline",
        },
    },
}

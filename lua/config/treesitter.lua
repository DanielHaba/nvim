local parsers = require("nvim-treesitter.parsers").get_parser_configs()
parsers.nu = {
    install_info = {
        url = "https://github.com/nushell/tree-sitter-nu",
        files = { "src/parser.c" },
        branch = "main",
    },
    filetype = "nu",
}


local options = {
    ensure_installed = {
        -- general
        "vim",
        "markdown",
        "markdown_inline",
        "query",
        "regex",
        "sql",
        "graphql",
        "dockerfile",
        "nu",

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

        -- web
        "html",
        "css",
        "scss",
        "javascript",
        "typescript",
        "tsx",
        "jsdoc",

    },
    indent = {
        enable = true,
    },
    highlight = {
        enable = true,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<C-Space>",
            node_incremental = "<C-Space>",
            node_decremental = "<C-BS>",
            scope_incremental = false,
        },
    },
    textobjects = {
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {},
            goto_next_end = {},
            goto_previous_start = {},
            goto_previous_end = {},
        },
        select = {
            enable = true,
            lookahead = true,
            keymaps = {},
        },
    },
    textsubjects = {
        enable = true,
        prev_selection = "<C-BS>",
        keymaps = {
            ["<C-Space>"] = "textsubjects-smart",
        },
    },
    playground = {
        enable = true,
    },
}

local selectors = {
    ["af"] = "@function.outer",
    ["if"] = "@function.inner",
    ["at"] = "@class.outer",
    ["it"] = "@class.inner",
    ["ad"] = "@condition.outer",
    ["id"] = "@condition.inner",
    ["al"] = "@loop.outer",
    ["il"] = "@loop.inner",
    ["ac"] = "@comment.outer",
    ["ic"] = "@comment.inner",
    ["ap"] = "@parameter.outer",
    ["ip"] = "@parameter.inner",
    ["ae"] = "@block.outer",
    ["ie"] = "@block.inner",
    ["am"] = "@call.outer",
    ["im"] = "@call.inner",
    ["ar"] = "@return.outer",
    ["ir"] = "@return.inner",
    ["s"] = "@statement.outer",
}

for head, selector in pairs(selectors) do
    local move = options.textobjects.move
    local select = options.textobjects.select.keymaps
    local tail = head:gsub("%l$", string.upper)

    move.goto_next_start["]" .. head] = selector
    move.goto_next_end["]" .. tail] = selector
    move.goto_previous_start["[" .. head] = selector
    move.goto_previous_end["[" .. tail] = selector
    select[head] = selector
end

return options

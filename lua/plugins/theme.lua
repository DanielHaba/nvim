return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000,
        opts = function()
            return {
                flavour = "latte",
                auto_integrations = true,
                -- transparent_background = true,
                float = {
                    solid = false,
                    transparent = false,
                },
                dim_inactive = {
                    enabled = false,
                },
                highlight_overrides = require("utils.highlights"),
            }
        end,
        config = function(_, opts)
            require("catppuccin").setup(opts)
            vim.cmd.colorscheme "catppuccin"
        end,
    },
    {
        "mikesmithgh/borderline.nvim",
        event = "VeryLazy",
        opts = function()
            return {
                enabled = true,
                border = require("borderline.borders").solid,
                -- border = require("borderline.borders").block,
            }
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = function()
            return require("config.lualine")
        end,
    },
    {
        "OXY2DEV/helpview.nvim",
        lazy = false,
        dependencies = {
            { "catppuccin/nvim" },
            { "folke/noice.nvim" },
        },
        opts = {
            preview = { icon_provider = "mini" },
        },
    },
    {
        "OXY2DEV/markview.nvim",
        dependencies = {
            { "catppuccin/nvim" },
            { "folke/noice.nvim" },
            { "neovim/nvim-lspconfig" },
            { "saghen/blink.cmp" },
        },
        lazy = false,
        init = function()
            vim.g.markview_blink_loaded = true
        end,
        opts = {
            preview = { enable = true, icon_provider = "mini" },
            html = { enabled = true },
            latex = { enabled = true },
            markdown = { enabled = true },
            markdown_inline = { enabled = true },
            typst = { enabled = true },
            yaml = { enabled = true },
            experimental = {
                date_formats = {
                    "^%d%d%d%d%-%d%d%-%d%d$",      --- YYYY-MM-DD
                    "^%d%d%-%d%d%-%d%d%d%d$",      --- DD-MM-YYYY, MM-DD-YYYY
                    "^%d%d%-%d%d%-%d%d$",          --- DD-MM-YY, MM-DD-YY, YY-MM-DD

                    "^%d%d%d%d%/%d%d%/%d%d$",      --- YYYY/MM/DD
                    "^%d%d%/%d%d%/%d%d%d%d$",      --- DD/MM/YYYY, MM/DD/YYYY

                    "^%d%d%d%d%.%d%d%.%d%d$",      --- YYYY.MM.DD
                    "^%d%d%.%d%d%.%d%d%d%d$",      --- DD.MM.YYYY, MM.DD.YYYY

                    "^%d%d %a+ %d%d%d%d$",         --- DD Month YYYY
                    "^%a+ %d%d %d%d%d%d$",         --- Month DD, YYYY
                    "^%d%d%d%d %a+ %d%d$",         --- YYYY Month DD

                    "^%a+%, %a+ %d%d%, %d%d%d%d$", --- Day, Month DD, YYYY
                },
                date_time_formats = {
                    "^%a%a%a %a%a%a %d%d %d%d%:%d%d%:%d%d ... %d%d%d%d$", --- UNIX date time
                    "^%d%d%d%d%-%d%d%-%d%dT%d%d%:%d%d%:%d%dZ$",           --- ISO 8601
                },
                prefer_nvim = true,
                file_open_command = "tabnew",
            },
        },
        config = function(_, opts)
            require("markview").setup(opts)
            require("utils.lsp_hover").setup()
        end,
    },
    {
        "stevearc/dressing.nvim",
        lazy = true,
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        opts = function ()
            return require("config.dressing")
        end
    },
    -- {
    --     "xiyaowong/transparent.nvim",
    --     lazy = false,
    --     opts = {},
    -- },
    { "rasulomaroff/reactive.nvim" },
    { "rktjmp/lush.nvim" },
}

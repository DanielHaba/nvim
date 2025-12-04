return {
    {
        "OXY2DEV/helpview.nvim",
        event = "VeryLazy",
        dependencies = {
            { "theme" },
            { "folke/noice.nvim" },
        },
        opts = {
            preview = { icon_provider = "mini" },
        },
    },
    {
        "OXY2DEV/markview.nvim",
        event = "VeryLazy",
        dependencies = {
            { "theme" },
            { "folke/noice.nvim" },
            { "neovim/nvim-lspconfig" },
            { "saghen/blink.cmp" },
        },
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
        "nvim-orgmode/orgmode",
        event = "VeryLazy",
        ft = { "org" },
        dependencies = {
            { "theme" },
            { "michaelb/sniprun" },
            { "nvim-orgmode/telescope-orgmode.nvim" },
            { "akinsho/org-bullets.nvim" },
        },
        opts = function()
            return require("config.orgmode")
        end,
    },
    {
        "michaelb/sniprun",
        build = "sh install.sh",
        cmd = { 
            "SnipRun",
            "SnipLive",
            "SnipInfo",
            "SnipReset",
            "SnipReplMemoryClean",
            "SnipClose",

        },
    },
    {
        "nvim-orgmode/telescope-orgmode.nvim",
        dependencies = {
            { 
                "nvim-telescope/telescope.nvim",
                opts = { load_extensions = { "orgmode" } },
            },
        },
    },
}

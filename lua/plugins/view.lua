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
        opts = function ()
            return require("config.markview")
        end,
        config = function(_, opts)
            require("markview").setup(opts)
            require("utils.lsp_hover").setup()
        end,
    },
}

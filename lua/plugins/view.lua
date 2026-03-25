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
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-mini/mini.nvim",
            "3rd/image.nvim",
        },
        cmd = { "RenderMarkdown" },
        ft = { "markdown", "AgenticChat" },
        opts = function ()
            return require("config.markdown")
        end,
    },

    -- {
    --     "markview.nvim",
    --     dev = true,
    --     init = function()
    --         vim.g.markview_blink_loaded = true
    --     end,
    --     opts = function ()
    --         return require("config.markview")
    --     end,
    --     config = function(_, opts)
    --         require("markview").setup(opts)
    --         require("utils.lsp_hover").setup()
    --     end,
    -- },
    -- {
    --     "OXY2DEV/markview.nvim",
    --     event = "VeryLazy",
    --     dependencies = {
    --         { "theme" },
    --         { "folke/noice.nvim" },
    --         { "neovim/nvim-lspconfig" },
    --         { "saghen/blink.cmp" },
    --     },
    --     init = function()
    --         vim.g.markview_blink_loaded = true
    --     end,
    --     opts = function ()
    --         return require("config.markview")
    --     end,
    --     config = function(_, opts)
    --         require("markview").setup(opts)
    --         require("utils.lsp_hover").setup()
    --     end,
    -- },
}

return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                "ckolkey/ts-node-action",
                dependencies = {
                    "nvim-treesitter",
                },
                opts = {},
            },
            { "folke/lazydev.nvim" },
        },
        opts = function()
            return require("config.lsp")
        end,
        config = function(_, opts)
            vim.diagnostic.config({
                signs = {
                    active = true,
                    text = {
                        [vim.diagnostic.severity.ERROR] = "󰅙",
                        [vim.diagnostic.severity.WARN] = "",
                        [vim.diagnostic.severity.INFO] = "󰋼",
                        [vim.diagnostic.severity.HINT] = "󰌵",
                    }
                },

            })
            for lang, config in pairs(opts) do
                vim.lsp.config(lang, config)
            end
        end,
    },
    {
        "nvimtools/none-ls.nvim",
        dependencies = {
            { "neovim/nvim-lspconfig" },
            { "nvimtools/none-ls-extras.nvim" },
        },
        opts = function ()
            return require("config.none_ls")
        end,
    },
    {
        'VidocqH/lsp-lens.nvim',
        event = "VeryLazy",
        dependencies = {
            { "neovim/nvim-lspconfig" },
        },
        cmd = { "LspLensOn", "LspLensOff", "LspLensToggle" },
        opts = { enable = true },
    },
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                "lazy.nvim",
            },
        },
    },
    {
        "folke/trouble.nvim",
        cmd = "Trouble",
        opts = {},
    },
}

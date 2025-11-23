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
            "neovim/nvim-lspconfig",
        },
        opts = {},
    },

}

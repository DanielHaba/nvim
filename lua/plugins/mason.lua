return {
    {
        "williamboman/mason.nvim",
        cmd = {
            "Mason",
            "MasonUpdate",
            "MasonInstall",
            "MasonUninstall",
            "MasonUninstallAll",
            "MasonLog",
        },
        build = ":MasonUpdate",
        opts = {
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        },
    },
    {
        "jay-babu/mason-null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "nvimtools/none-ls.nvim",
        },
        opts = function()
            return {
                automatic_installation = true,
                ensure_installed = require("config.mason").null_ls,
            }
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        event = { "BufReadPre", "BufNewFile" },
        cmd = {
            "LspInstall",
            "LspUninstall",
        },
        dependencies = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",
            "nvimtools/none-ls.nvim",
        },
        opts = function()
            return {
                automatic_installation = true,
                automatic_enable = true,
                ensure_installed = require("config.mason").lsp,
            }
        end,
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        event = { "BufReadPre", "BufNewFile" },
        cmd = {
            "DapInstall",
            "DapUninstall",
            "DapContinue",
            "DapStepOver",
            "DapStepInto",
            "DapStepOut",
            "DapToggleBreakpoint",
        },
        dependencies = {
            "williamboman/mason.nvim",
            "mfussenegger/nvim-dap",
        },
        opts = function()
            local Optional = require('mason-core.optional')
            return {
                -- handlers = {
                --     function(config)
                --         local dap = require('dap')
                --
                --         Optional.of_nilable(config.adapters):map(function(adapter_config)
                --             dap.adapters[config.name] = adapter_config
                --         end)
                --         return config
                --     end,
                -- },
                handlers = {},
                automatic_installation = true,
                ensure_installed = require("config.mason").dap,
            }
        end,
    },
}

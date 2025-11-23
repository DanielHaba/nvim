return {
    {
        enabled = false,
        "hrsh7th/nvim-cmp",
        event = {"InsertEnter"},
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp", depencencies = { "neovim/nvim-lspconfig" } },
            { "hrsh7th/cmp-cmdline" },
            { "hrsh7th/cmp-nvim-lsp-signature-help" },
        },
        init = function()
            vim.lsp.config("*", {
                capabilities = require('cmp_nvim_lsp').default_capabilities(),
            })
        end,
        opts = function()
            return require("config.cmp")
        end,
    },
}

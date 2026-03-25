return {
    {
        "saghen/blink.cmp",
        version = "1.*",
        event = {"InsertEnter"},
        dependencies = {
            { "neovim/nvim-lspconfig" },
            { "onsails/lspkind.nvim" },
            { "xzbdmw/colorful-menu.nvim" },
            { "folke/noice.nvim" },
            -- { "Kaiser-Yang/blink-cmp-avante" },
        },
        opts = function()
            return require("config.blink")
        end,
    },
}

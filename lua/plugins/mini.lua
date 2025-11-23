return {
    {
        "nvim-mini/mini.nvim",
        version = "*",
        lazy = false,

        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        opts = function()
            return require("config.mini")
        end,
        config = function(_, opts)
            for plugin, config in pairs(opts) do
                require("mini." .. plugin).setup(config)
            end
            local MiniIcons = require("mini.icons")
            MiniIcons.tweak_lsp_kind("replace")
        end,
    },
    {
        "nvim-tree/nvim-web-devicons",
        dependencies = {
            "nvim-mini/mini.nvim",
        },
        config = function()
            require("mini.icons").mock_nvim_web_devicons()
        end,

    },
}

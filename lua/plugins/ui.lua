return {
    -- {
    --     "mikesmithgh/borderline.nvim",
    --     event = "VeryLazy",
    --     opts = function()
    --         return {
    --             enabled = true,
    --             border = require("utils.border").block_inner,
    --         }
    --     end,
    -- },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { 
            { "theme" },
        },
        event = "VeryLazy",
        opts = function()
            return require("config.lualine")
        end,
    },
    {
        "stevearc/dressing.nvim",
        event = "VimEnter",
        dependencies = {
            { "nvim-telescope/telescope.nvim" },
            { "folke/noice.nvim" },
            { "MunifTanjim/nui.nvim" },
        },
        opts = function()
            return require("config.dressing")
        end,
        config = function()

        end,
    },
    { 
        enabled = false,
        "rasulomaroff/reactive.nvim",
        event = "VeryLazy",
        dependencies = {
            { "theme" },
        },
        opts = {},
    },
    { 
        "rktjmp/lush.nvim",
        branch = "main",
        dependencies = {
            { 
                "rktjmp/shipwright.nvim",
                cmd = { "Shipwright" },
            },
        },
        cmd = {
            "Lushify",
            "LushRunTutorial",
        },
    },

    {
        "chrisgrieser/nvim-origami",
        event = "VeryLazy",
        opts = {},
    },
    {
        "ziontee113/icon-picker.nvim",
        dependencies = {
            { "stevearc/dressing.nvim" },
        },
        cmd = {
            "IconPickerNormal",
            "IconPickerYank",
            "IconPickerInsert",
        },
        opts = { disable_legacy_commands = true },
    },
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
    {
        "folke/snacks.nvim",
        lazy = false,
        priority = 1000,
        opts = function ()
            return require("config.snacks")
        end
    },
}

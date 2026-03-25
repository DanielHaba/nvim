return {
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
        config = function(_, opts)
            require("harpoon"):setup(opts)
        end,
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        lazy = true,  -- Ładuj tylko na żądanie
        cmd = {"Neotree"},
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        opts = function()
            return require("config.neotree")
        end,
        config = function(_, opts)
            local dap = require("dap")
            dap.listeners.after.event_initialized.neotree_config = function()
                vim.cmd.Neotree("close")
            end
            require("neo-tree").setup(opts)
        end
    },
    {
        "aserowy/tmux.nvim",
        cond = function() return vim.env.TMUX ~= nil end,
        event = "VeryLazy",
        opts = {
            copy_sync = { enable = true },
            navigation = { enable_default_keybindings = true },
            resize = { enable_default_keybindings = true },
            swap = { enable_default_keybindings = true },
        },
    },
}

return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        lazy = false,
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
}

return {
    {
        enabled = true,
        -- version = "*",
        branch = "main",
        "folke/noice.nvim",
        lazy = false,
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-treesitter/nvim-treesitter",
            "rcarriga/nvim-notify",
        },
        opts = function()
            return vim.tbl_deep_extend("force", require("config.noice"), {
                views = {
                    popupmenu = {
                        -- border = { style = vim.g.winborder },
                        buf_options = { filetype = "NoicePopupMenu" },
                        -- zindex = 50,
                    },
                    popup = {
                        -- border = { style = vim.g.winborder },
                        buf_options = { filetype = "NoicePopup" },
                        -- zindex = 150,
                    },
                    cmdline = {
                        -- border = { style = vim.g.winborder },
                        buf_options = { filetype = "NoiceCmdline" },
                        -- zindex = 150,
                    },
                    cmdline_popupmenu = {
                        -- border = { style = vim.g.winborder },
                        buf_options = { filetype = "NoiceCmdlinePopupMenu" },
                        -- zindex = 150,
                    },
                    cmdline_input = {
                        -- border = { style = vim.g.winborder },
                        buf_options = { filetype = "NoiceCmdlineInput" },
                        -- zindex = 150,
                    },
                    cmdline_output = {
                        -- border = { style = vim.g.winborder },
                        buf_options = { filetype = "NoiceCmdlineOutput" },
                        -- zindex = 150,
                    },
                    cmdline_popup = {
                        -- border = { style = vim.g.winborder },
                        buf_options = { filetype = "NoiceCmdlinePopup" },
                        -- zindex = 150,
                    },
                    split = {
                        -- border = { style = vim.g.winborder },
                        buf_options = { filetype = "NoiceSplit" },
                        -- zindex = 50,
                    },
                    vsplit = {
                        -- border = { style = vim.g.winborder },
                        buf_options = { filetype = "NoiceVSplit" },
                        -- zindex = 50,
                    },
                    messages = {
                        -- border = { style = vim.g.winborder },
                        buf_options = { filetype = "NoiceMessages" },
                        -- zindex = 50,
                    },
                    notify = {
                        -- border = { style = vim.g.winborder },
                        buf_options = { filetype = "NoiceNotify" },
                        -- zindex = 50,
                    },
                    confirm = {
                        -- border = { style = vim.g.winborder },
                        buf_options = { filetype = "NoiceConfirm" },
                        -- zindex = 50,
                    },
                    mini = {
                        -- border = { style = vim.g.winborder },
                        buf_options = { filetype = "NoiceMini" },
                        zindex = 1,
                    },
                    hover = {
                        -- border = { style = vim.g.winborder },
                        buf_options = { filetype = "NoiceHover" },
                        -- zindex = 50,
                    },
                },
            })
        end,
        config = function(_, opts)
            local noice = require("noice")
            noice.setup(opts)
            vim.notify = noice.notify
        end,
    },
    {
        "rcarriga/nvim-notify",
        dependencies = {
            {
                "nvim-telescope/telescope.nvim",
                opts = {
                    load_extensions = {
                        notify = true,
                    },
                },
            },
        },
        opts = function ()
            return require("config.notify")
        end,
    },
}

return {
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",
            "nvim-telescope/telescope.nvim",
        },
        cmd = "Neogit",
        opts = function()
            return require("config.neogit")
        end,
    },
    {
        "sindrets/diffview.nvim",
        cmd = {
            "DiffviewClose",
            "DiffviewFlieHistory",
            "DiffviewFocusFiles",
            "DiffviewLog",
            "DiffviewOpen",
            "DiffviewRefresh",
            "DiffviewToggleFiles",
        },
        opts = function()
            return require("config.diffview")
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        opts = {
            attach_to_untracked = true,
            current_line_blame = true,
            signs = {
                add = { text = "▒" },
                change = { text = "▒" },
            },
            signs_staged = {
                add = { text = "▒" },
                change = { text = "▒" },
            },
        },
    },
}

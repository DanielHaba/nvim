local options = {
    input = {
        enabled = true,
        border = { "▛", "▀", "▜", "▐", "▟", "▄", "▙", "▌" },
        win_options = {
            winblend = 0,
        },
        mappings = {
            n = {
                ["<Esc>"] = "Close",
                ["<C-c>"] = "Close",
                ["q"] = "Close",
                ["<CR>"] = "Confirm",
            },
            i = {
                ["<C-c>"] = "Close",
                ["<CR>"] = "Confirm",
            },
        },
    },
    select = {
        enabled = true,
        backend = "telescope",
        telescope = require("telescope.themes").get_dropdown({
            layout_strategy = "vertical",
        }),
    },
}

return options

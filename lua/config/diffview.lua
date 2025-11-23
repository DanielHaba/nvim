local actions = require("diffview.actions")
return {
    keymaps = {
        view = {
            { "n", "<C-q>", "<Cmd>tabclose<CR>", { desc = "Close diff." } },
            { "n", "<C-n>", actions.toggle_files, { desc = "Toggle files panel." } },
        },
        file_panel = {
            { "n", "<C-q>", "<Cmd>tabclose<CR>", { desc = "Close diff." } },
            { "n", "<C-n>", actions.toggle_files, { desc = "Toggle files panel." } },
        },
        file_history_panel = {
            { "n", "<C-q>", "<Cmd>tabclose<CR>", { desc = "Close diff." } },
            { "n", "<C-n>", actions.toggle_files, { desc = "Toggle files panel." } },
        },
        option_panel = {
            { "n", "<C-q>", "<Cmd>tabclose<CR>", { desc = "Close diff." } },
            { "n", "<C-n>", actions.toggle_files, { desc = "Toggle files panel." } },
        },
        help_panel = {
            { "n", "<C-q>", "<Cmd>tabclose<CR>", { desc = "Close diff." } },
            { "n", "<C-n>", actions.toggle_files, { desc = "Toggle files panel." } },
        },
    },
}

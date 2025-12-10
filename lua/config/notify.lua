return {
    render = "wrapped-compact",
    on_open = function (win)
        -- vim.api.nvim_set_option_value("winblend", 30, {
        --     scope = "local",
        --     win = win,
        -- })
        -- vim.api.nvim_win_set_config(win, {
        --     zindex = 10000,
        --     border = require("utils.border").block_inner,
        -- })
    end,
}


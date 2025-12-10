local M = {}

M.ignored = {}


---@type integer|nil
local last_win = nil

---@param win integer
local on_switch = vim.schedule_wrap(function (win)
    if win == last_win or not vim.api.nvim_win_is_valid(win) then
        return
    end
    local opts = vim.api.nvim_win_get_config(win)
    if opts.relative ~= "" then
        last_win = win
        return
    end
    local a_win = win
    local a_zindex = opts.zindex or 0

    for _, c_win in ipairs(vim.api.nvim_list_wins()) do
        local c_opts = vim.api.nvim_win_get_config(c_win)
        local c_zindex = c_opts.zindex or 0
        local c_buf = vim.api.nvim_win_get_buf(c_win)

        local is_valid = (
            c_opts.relative ~= ""
            and c_opts.focusable
            and not vim.tbl_contains(M.ignored, vim.bo[c_buf].filetype)
        )
        if is_valid and c_zindex > a_zindex then
            a_win = c_win
            a_zindex = c_zindex
        end
    end
    if a_win ~= win then
        last_win = a_win
        vim.api.nvim_set_current_win(a_win)
    end
end)

function M.setup(opts)
    local opts = opts or {} 
    local group = vim.api.nvim_create_augroup("focus", {})

    M.ignored = opts.ignored or {}
    vim.api.nvim_create_autocmd(
        { "WinEnter" },
        {
            group = group,
            callback = function ()
                local win = vim.api.nvim_get_current_win()
                on_switch(win)
            end
        }
    )
end

return M

local M = {}

function M.setup()
    local group = vim.api.nvim_create_augroup("theme", {})
    vim.api.nvim_create_autocmd("TextYankPost", {
        group = group,
        callback = function()
            vim.highlight.on_yank()
        end,
    })

    vim.cmd.colorscheme(vim.g.colorscheme)
end

return M

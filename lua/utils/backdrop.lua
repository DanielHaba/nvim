local M = {}


M.create = function(ftype, opts)
    -- if true then
    --     return
    -- end
    opts = opts or {}
    local blend = opts.blend or 50
    local z_index = opts.z_index or 50
    local count = 0

    vim.api.nvim_create_autocmd("FileType", {
        pattern = ftype,
        callback = function(ctx)
            local backdrop_name = ctx.file .. "Backdrop"
            local main_bufnr = ctx.buf
            local backdrop_bufnr = 0
            local winnr = 0

            if count == 0 then
                backdrop_bufnr = vim.api.nvim_create_buf(false, true)
                winnr = vim.api.nvim_open_win(backdrop_bufnr, false, {
                    relative = "editor",
                    border = "none",
                    row = 0,
                    col = 0,
                    width = vim.o.columns,
                    height = vim.o.lines,
                    focusable = false,
                    style = "minimal",
                    zindex = z_index - 1, -- ensure it's below the reference window
                })

                vim.api.nvim_set_hl(0, backdrop_name, { bg = "#000000", default = true })
                vim.wo[winnr].winhighlight = "Normal:" .. backdrop_name
                vim.wo[winnr].winblend = blend
                vim.bo[backdrop_bufnr].buftype = "nofile"
            end
            count = count + 1

            -- close backdrop when the reference buffer is closed
            -- BufLeave
            vim.api.nvim_create_autocmd({ "WinClosed" }, {
                once = true,
                buffer = main_bufnr,
                callback = function()
                    count = count - 1
                    if count < 0 then count = 0 end

                    if count == 0 and winnr ~= 0 then
                        if vim.api.nvim_win_is_valid(winnr) then vim.api.nvim_win_close(winnr, true) end
                        if vim.api.nvim_buf_is_valid(backdrop_bufnr) then
                            vim.api.nvim_buf_delete(backdrop_bufnr, { force = true })
                        end
                    else
                    end
                end,
            })
        end,
    })
end


return M

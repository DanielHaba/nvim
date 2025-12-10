local M = {}

function M.apply(section, opts)
    for sec_name, keymap in ipairs(section) do
        local mode = keymap.mode or "n"
        local o = vim.tbl_extend("force", keymap.opts or {}, {
            desc = keymap.desc
        })
        if opts then
            o = vim.tbl_extend("force", o, opts)
        end
        if keymap[2] == nil then
            vim.print(sec_name, keymap)
        end
        vim.keymap.set(mode, keymap[1], keymap[2], o)
    end
end

function M.setup(keymaps)
    local group = vim.api.nvim_create_augroup("keybinds", {})

    for _, section in pairs(keymaps) do
        if section.filetypes then
            vim.api.nvim_create_autocmd("FileType", {
                group = group,
                pattern = section.filetypes,
                callback = function(ctx)
                    M.apply(section, { buffer = ctx.buf })
                end,
            })
        else
            M.apply(section, {})
        end
    end
end

return M

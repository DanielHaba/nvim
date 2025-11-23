require("config.vim")
local keymaps = require("config.keymaps")


for _, section in pairs(keymaps) do
    for _, keymap in ipairs(section) do
        local mode = keymap.mode or "n"
        local o = vim.tbl_extend("force", keymap.opts or {}, {
            desc = keymap.desc
        })
        vim.keymap.set(mode, keymap[1], keymap[2], o)

    end
end

return {}

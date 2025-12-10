local utf8 = require("utils.utf8")
local M = {}

---@param str string
---@return string[]
function M.make(str)
    -- local chars = vim.split(str:gsub("%s", ""), "")

    local chars = {}
    for _, char in utf8.codes(str:gsub("%s", "")) do
        table.insert(chars, char)
    end
    return {
        chars[1],
        chars[2],
        chars[3],
        chars[5],
        chars[8],
        chars[7],
        chars[6],
        chars[4],
    }
end


M.block_inner = M.make[[
    ▗▄▖
    ▐ ▌
    ▝▀▘
]]

M.block_outer = M.make[[
    ▛▀▜
    ▌ ▐
    ▙▄▟
]]

return M

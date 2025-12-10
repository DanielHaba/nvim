---@alias orgsuite.telescope.Type "files"|"headlines"|"all"

local M = {}


M.type = {}




---@type orgsuite.telescope.Type
local type = "all"

---@param value orgsuite.telescope.Type
function M.type.set(value)
    type = value
end

---@return orgsuite.telescope.Type
function M.type.get()
    return type
end

---@return string
function M.type.title()
    if type == "files" then
        return "Files"
    elseif type == "headlines" then
        return "Headlines"
    else
        return "All"
    end
end

return M



---@class orgsuite.Action
local Action = {}
Action.__index = Action


---@class orgsuite.ActionConfig
---@field handlers table<string, fun(node: TSNode)|string>
---@field default? fun(node: TSNode)|string

---@type orgsuite.ActionConfig
local config = {
    handlers = {
        timestamp = "org_mappings.change_date",
        headline = "org_mappings.todo_next_state",
        listitem = "org_mappings.toggle_checkbox",
        list = "org_mappings.toggle_checkbox",
    },
}


function Action:__call()
    local node = require("nvim-treesitter.ts_utils").get_node_at_cursor()
    if node == nil then
        return
    end
    ---@type TSNode?
    local it = node
    while it ~= nil do
        local action = config.handlers[it:type()]

        if type(action) == "function" then
            return action(it)
        elseif type(action) == "string" then
            return require("orgmode").action(action)
        end
        it = it:parent()
    end
    local action = config.default
    if type(action) == "function" then
        return action(node)
    elseif type(action) == "string" then
        return require("orgmode").action(action)
    end
end

---@param opts orgsuite.ActionConfig
function Action:setup(opts)
    config = vim.tbl_deep_extend("force", config, opts)
end

return setmetatable({}, Action) --[[@as orgsuite.Action]]

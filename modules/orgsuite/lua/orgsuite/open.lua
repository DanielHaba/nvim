---@class orgsuite.Open
local Open = {}
Open.__index = Open

---@param loc? TSNode|string
function Open:__call(loc)
    if loc == nil then
        loc = require("nvim-treesitter.ts_utils").get_node_at_cursor()
    end

    local url = type(loc) == "userdata"
        and vim.treesitter.get_node_text(loc, 0)
        or loc --[[@as string]]

    -- require("orgsuite.debug").popup({
    --     url = url,
    -- })

    require("gx").open(vim.api.nvim_get_mode().mode, url)
end

function Open:org()
    local link = require("orgmode.org.hyperlinks").get_link_under_cursor()

    if link == nil then
        return
    end
    if link.url:is_external_url() then
        return self(link.url:to_string())
    end

    return require("orgmode").links:follow(link.url:to_string())
end

function Open:markdown()
    local node = require("nvim-treesitter.ts_utils").get_node_at_cursor()

    while node ~= nil do
        vim.notify("Visiting " .. node:type(), vim.log.levels.INFO)
        for child in node:iter_children() do
            if child:type() == "link_destination" then
                return self(child)
            end
        end
        node = node:parent()
    end
end

return setmetatable({}, Open) --[[@as orgsuite.Open]]

local strings = require("plenary.strings")
local telescope_state = require("telescope.state")
local highlights = require("orgmode.colors.highlights")
local state = require("orgsuite.telescope.state")



local M = {}


-- M.icons = {
--     file = "🔷",
--     headlines = { "🔴", "🟠", "🟡", "🟢", "🔵", "🟣" },
--
-- }

M.icons = {
    file = "",
    headlines = {
        fallback = "",
    },
}


---@class orgsuite.telescope.RenderItem
---@field text string|number|nil
---@field hl? string
---@field width? integer
---@field justify? "left"|"right"



---@param items orgsuite.telescope.RenderItem[]
---@return { text: string, hl?: string }[], number
function M.section(items)
    local groups = {}
    local width = 0

    for i, item in ipairs(items) do
        local text = item.text ~= nil and tostring(item.text) or ""
        local hl = item.hl
        if #text == 0 then
            goto continue
        end
        if i > 1 then
            table.insert(groups, {
                text = " ",
            })
            width = width + 1
        end
        if item.width then
            text = strings.align_str(
                strings.truncate(text, item.width),
                item.width,
                item.justify == "right"
            )
        else

        end
        table.insert(groups, {
            text = text,
            hl = hl,
        })
        width = width + #text
        ::continue::
    end

    return groups, width
end

---@param opts {
---     left?: orgsuite.telescope.RenderItem[],
---     center: orgsuite.telescope.RenderItem[],
---     right?: orgsuite.telescope.RenderItem[],
---}
---@return string, table
function M.render(opts)
    local left, left_width = M.section(opts.left or {})
    local center, center_width = M.section(opts.center)
    local right, right_width = M.section(opts.right or {})

    if left_width > 0 then
        table.insert(left, {
            text = " ",
        })
        left_width = left_width + 1
    end

    if right_width > 0 then
        local state = telescope_state.get_status(vim.api.nvim_get_current_buf())
        local width = vim.api.nvim_win_get_width(state.layout.results.winid) - #state.picker.selection_caret

        local pad = width - (left_width + center_width)
        if pad > 0 then
            table.insert(center, {
                text = string.rep(" ", pad),
            })
            center_width = center_width + pad
        end
    end

    local text = ""
    local highlights = {}
    local i = 0

    for _, group in ipairs({ left, center, right }) do
        for _, item in ipairs(group) do
            local l = #item.text
            text = text .. item.text
            if item.hl then
                table.insert(highlights, { { i, i + l }, item.hl })
            end
            i = i + l
        end
    end

    return text, highlights
end

---@param entry orgsuite.telescope.FileEntry
---@return string, table
function M.file(entry)
    return M.render({
        left = {
            { text = M.icons.file },
        },
        center = {
            { text = entry.title },
        },
    })
end

---@param entry orgsuite.telescope.HeadlineEntry
---@return string, table
function M.headline(entry)
    local todo, _, todo_type = entry.item:get_todo()
    local level = entry.item:get_level()

    return M.render({
        left = {
            { 
                text = M.icons.headlines[level] or M.icons.headlines.fallback,
                width = state.type.get() == "headlines" and 1 or 4,
                justify = "right",
                hl = M.get_header_highlight(level)
            },
        },
        center = {
            { text = todo, hl = M.get_todo_highlight(todo_type, todo) },
            { text = entry.title },
        },
    })
end

---@param type string|nil
---@param value string|nil
---@return string|nil
function M.get_todo_highlight(type, value)
    if not value then
        return nil
    end
    local hl_map = highlights.get_agenda_hl_map()
    return hl_map[value] or (type == "DONE" and "@org.keyword.done") or "@org.keyword.todo"
end


---@param level number
---@return string
function M.get_header_highlight(level)
    return "@org.headline.level" .. level
end

return M

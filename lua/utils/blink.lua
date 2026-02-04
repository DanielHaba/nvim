--- @module "blink.cmp.config.completion.documentation"

local split_lines = require("blink.cmp.lib.window.docs").split_lines
local buffer = nil

local M = {
    menu_components = {
        label = {},
        kind_icon = {},
    },
}

-- vim.api.nvim_create_autocmd("WinResized", {
--     callback = function(ctx)
--         local renderer = markview.strict_render
--         if ctx.buf == buffer then
--             renderer:clear(buffer)
--             renderer:render(buffer)
--         end
--     end,
-- })

---@param opts blink.cmp.CompletionDocumentationDrawOpts
function M.draw_documentation(opts)
    local markview = require("markview")
    -- vim.print(opts)
    local renderer = markview.strict_render
    local item = opts.item
    buffer = opts.window:get_buf()


    opts.window.config.filetype = "markdown"
    local lines = {}
    -- local details = type(item.detail) == "string" and { item.detail } or item.detail
    --
    -- if details then
    --     table.insert(lines, "```" .. vim.bo.filetype)
    --     for _, v in ipairs(details) do
    --         vim.list_extend(lines, split_lines(v))
    --     end
    --     table.insert(lines, "```")
    -- end


    if item.documentation then
        -- table.insert(lines, "---")
        local doc = item.documentation
        if type(item.documentation) == 'string' then doc = { kind = 'plaintext', value = opts.documentation } end
        vim.lsp.util.convert_input_to_markdown_lines(doc, lines)
        -- table.insert(lines, item.documentation.value)
    else
        opts.window:close()
        return
    end

    vim.api.nvim_buf_set_lines(buffer, 0, -1, false, lines)
    renderer:clear(buffer)
    renderer:render(buffer)
end

function M.menu_components.label.text(ctx)
    return require("colorful-menu").blink_components_text(ctx)
end

function M.menu_components.label.highlight(ctx)
    return require("colorful-menu").blink_components_highlight(ctx)
end

function M.menu_components.kind_icon.text(ctx)
    local icon = require("lspkind").symbolic(ctx.kind, { mode = "symbol" })
    return " " .. icon .. " "
end

function M.menu_components.kind_icon.highlight(ctx)
    return {{ group = "BlinkCmpKind" .. ctx.kind, priority = 20000 }}
end



return M

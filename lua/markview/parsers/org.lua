local orgmode = {}

---@type string[]
orgmode.content = {}

---@type any[]
orgmode.sorted = {}

---@alias range markview.parsed.range

---Insert orgmode data
---@param data any
function orgmode.insert(data)
    table.insert(orgmode.content, data)
    if not orgmode.sorted[data.class] then
        orgmode.sorted[data.class] = {}
    end
    table.insert(orgmode.sorted[data.class], vim.tbl_extend("error", data, {
        id = #orgmode.content
    }))
end

---Parse headline
---@param buffer integer
---@param ts_node TSNode
---@param text string[]
---@param range range
function orgmode.headline(buffer, ts_node, text, range)
    local marker = ts_node:named_child(0)
    ---@type integer[]
    local levels = {}

    local current_selection = ts_node:parent()
    local parent_selection = ts_node:parent():parent()

    while parent_selection and current_selection do
        ---@type integer
        local passed = 1

        for direct_child in parent_selection:iter_children() do
            if direct_child:equal(current_selection) then
                table.insert(levels, 1, passed)
            elseif direct_child:type() == "section" then
                passed = passed + 1
            end
        end

        parent_selection = parent_selection:parent()
        current_selection = current_selection:parent()
    end

    local markers = vim.treesitter.get_node_text(marker, buffer):gsub("%s", "")
    while #levels < #markers do
        table.insert(levels, 1, 0)
    end

    orgmode.insert({
        class = "markdown_atx_heading",
        levels = levels,
        marker = markers,
        text = text,
        range = range,
    })
end

---Parse checkbox
---@param _ integer
---@param _ TSNode
---@param text string[]
---@param range range
function orgmode.checkbox(_, _, text, range)
    -- TODO: check if working
    orgmode.insert({
        class = "markdown_checkbox",
        state = text[1]:match("^S[(.)%]"),
        text = text,
        range = range,
    })
end

---Parse code block
---@param buffer integer
---@param ts_node TSNode
---@param _ string[]
---@param range markview.parsed.markdown.code_blocks.range
function orgmode.code_block(buffer, ts_node, _, range)
    -- Parser is unreliable.
    -- Use buffer lines instead.
    local text = vim.api.nvim_buf_get_lines(buffer, range.row_start, range.row_end, false)

    -- Fix range when leading whitespace(s)
    -- are present.
    if text[1]:sub(range.col_start + 1):match("^%s+") then
        range.col_start = range.col_start + text[1]:sub(range.col_start + 1):match("^%s+"):len();
    end

    -- Modify the text so that only the text
    -- inside the node's range is visible.
    for l, line in ipairs(text) do
        text[l] = line:sub(range.col_start + 1);
    end

    ---@type string?
    local language
    ---@type string?
    local info_string

    ---@type TSNode?
    local name_node
    ---@type TSNode?
    local start_node
    ---@type TSNode?
    local end_node
    ---@type TSNode?
    local param_node
    ---@type string
    local start_delim = ""
    ---@type string
    local end_delim = ""


    for node, name in ts_node:iter_children() do
        if name == "name" then
            name_node = node
            start_node = node
        elseif name == "parameter" then
            if param_node == nil then 
                param_node = node
            end
            start_node = node
        elseif name == "end_name" then
            end_node = node
        end
    end
    
    if param_node then
        language = vim.treesitter.get_node_text(param_node, buffer)
        range.language = { param_node:range() }
        info_string = language:gsub("^^%s+", "")
        range.info_string = { param_node:range() }
    end
    if name_node then
        local name = vim.treesitter.get_node_text(name_node, buffer)
        if name:lower() == "latex" then
            language = "latex"
        end
    end

    if start_node then
        range.start_delim = { start_node:range() }
        start_delim = vim.api.nvim_buf_get_lines(buffer, range.start_delim[1], range.start_delim[1] + 1, false)[1]
        range.start_delim[2] = range.col_start
        range.start_delim[4] = #start_delim
    end
    if end_node then
        range.end_delim = { end_node:range() }
        end_delim = vim.api.nvim_buf_get_lines(buffer, range.end_delim[1], range.end_delim[1] + 1, false)[1]
        range.end_delim[2] = range.col_start
        range.end_delim[4] = #end_delim
    end

    orgmode.insert({
        class = "markdown_code_block",
        language = language,
        info_string = info_string,
        delimiters = { start_delim, end_delim },
        text = text,
        range = range,
    })
end

---Parse list_item
---@param buffer integer
---@param ts_node TSNode
---@param _ string[]
---@param range range
function orgmode.list_item(buffer, ts_node, _, range)
    local text = vim.api.nvim_buf_get_lines(buffer, range.row_start, range.row_end, false)
    local marker, checkbox;

    if text[1]:match("^[%>%s]*([%-%+%*])%s?") then
        marker = text[1]:match("^[%>%s]*([%-%+%*])%s?")
        checkbox = text[1]:match("^[%>%s]*[%-%+%*]%s+%[(.)%]")
    elseif text[1]:match("^[%>%s]*(%d+[%.%)])%s?") then
        marker = text[1]:match("^[%>%s]*(%d+[%.%)])%s?");
        checkbox = text[1]:match("^[%>%s]*%d+[%.%)]%s+%[(.)%]")
    end

    if not marker then
        return
    end

    local nested = false
    local parent = ts_node:parent()
    while parent do
        if parent:type() == "list_item" then
            nested = true
            break
        end
        parent = parent:parent()
    end

    local n = 1;
    local sibling = ts_node:prev_sibling()
    while sibling do
        n = n + 1
        sibling = sibling:prev_sibling()
    end

    orgmode.insert({
        class = "markdown_list_item",
        __nested = nested,
        n = n,
        candidates = {},
        marker = marker,
        checkbox = checkbox,
        indent = 0,
        text = text,
        range = range,
    })
end

---Parse table
---@param buffer integer
---@param ts_node TSNode
---@param text string[]
---@param range range
function orgmode.table(buffer, ts_node, text, range)
    ---@param pattern string
    ---@param line string
    ---@return markview.parsed.markdown.tables.cell[]
    local parse_line = function(pattern, line)
        ---@type markview.parsed.markdown.tables.cell[]
        local items = {}
        local x = 0
        for sep, cell in line:gmatch(pattern) do
            table.insert(items, {
                class = "separator",
                text = sep,
                col_start = x,
                col_end = x + #sep,
            })
            x = x + #sep
            if #cell > 0 then
                table.insert(items, {
                    class = "column",
                    text = cell,
                    col_start = x,
                    col_end = x + #cell,
                })
                x = x + #cell
            end
        end
        return items
    end

    ---@param line string
    ---@return markview.parsed.markdown.tables.cell[]
    local parse_row = function(line)
        return parse_line("(|)([^|]*)", line)
    end

    ---@param line string
    ---@return markview.parsed.markdown.tables.cell[]
    local parse_separator = function(line)
        return parse_line("([^-])(%-*)", line)
    end


    ---@type range
    local rows_range = {
        row_start = 0,
        col_start = 0,
        row_end = 0,
        col_end = 0,
    }

    local header = {}
    local separator = {}
    local rows = {}
    local first_row = true

    for child in ts_node:iter_children() do
        local line = vim.treesitter.get_node_text(child, buffer)

        if child:type() == "row" then
            local row = parse_row(line)
            if first_row then
                first_row = false
                rows_range.row_start, rows_range.col_start, _, _ = child:range()
                header = row
            else
                _, _, rows_range.row_end, rows_range.col_end = child:range()
                table.insert(rows, row)
            end
        elseif child:type() == "hr" or child:type() == "paragraph" then
            separator = parse_separator(line)
        end
    end

    orgmode.insert({
        class = "markdown_table",
        top_border = true,
        bottom_border = true,
        border_overlap = false,
        alignments = {},
        has_alignment_markers = false,
        header = header,
        separator = separator,
        rows = rows,
        text = text,
        range = rows_range,
    })
end

---Org mode parser into markdown structure
---@param buffer integer
---@param ts_tree TSTree
---@param from integer?
---@param to integer?
orgmode.parse = function(buffer, ts_tree, from, to)
    orgmode.content = {}
    orgmode.sorted = {}

    local query = vim.treesitter.query.parse("org", [[
        ((section
            (headline) @orgmode.headline)
        )
        ((table) @orgmode.table)
        ((checkbox) @orgmode.checkbox)
        ; ((property_drawer) @orgmode.properties)
        ((listitem) @orgmode.list_item)
        ((block) @orgmode.code_block)
    ]])

    for id, node, _, _ in query:iter_captures(ts_tree:root(), buffer, from, to) do
        local name = query.captures[id]

        if not name:match("^orgmode%.") then
            goto continue
        end
        local text = vim.treesitter.get_node_text(node, buffer);
        local r_start, c_start, r_end, c_end = node:range();

        if text == nil then
            goto continue
        end
        if not text:match("\n$") then
            text = text .. "\n"
        end

        local lines = {}
        for line in text:gmatch("(.-)\n") do
            table.insert(lines, line);
        end

        ---@type boolean, string
        local success, err = pcall(
            orgmode[name:gsub("^orgmode%.", "")],
            buffer,
            node,
            lines,
            {
                row_start = r_start,
                col_start = c_start,
                row_end = r_end,
                col_end = c_end,
            }
        )
        -- vim.print(orgmode.content)
        if not success then
            -- return
            -- TODO: report issue
        end
        ::continue::
    end
    return orgmode.content, orgmode.sorted
end



return orgmode

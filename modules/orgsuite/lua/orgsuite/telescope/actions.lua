local Promise = require("orgmode.utils.promise")
local org = require("orgmode")
local org_api = require("orgmode.api")
local roam = require("org-roam")
local api = require("orgsuite.telescope.api")
local state = require("orgsuite.telescope.state")

local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local M = {}


---@param opts? {
---     create?: boolean,
---     source: OrgApiHeadline,
---     origin?: OrgPromise<org-roam.core.database.Id|false>|org-roam.core.database.Id|false,
---     templates?: table<string, OrgCaptureTemplateOpts>,
---     on_done?: fun (),
---}
---@return fun(buf: integer): boolean
function M.refile(opts)
    opts = opts or {}

    return function(buf)
        ---@type orgsuite.telescope.Entry
        local entry = action_state.get_selected_entry()
        local title = action_state.get_current_line()
        actions.close(buf)


        ---@type OrgPromise<OrgFile|OrgHeadline>
        local target = (opts.create or entry == nil)
            and api.create_node({
                title = title,
                immediate = true,
                origin = opts.origin,
                templates = opts.templates,
            })
            or Promise.resolve(entry.item)


        ---@param target OrgFile|OrgHeadline
        target:next(function(target)
            return org_api.refile({
                destination = api.get_api(target),
                source = opts.source,
            })
        end):next(function ()
            if opts.on_done then
                opts.on_done()
            end
        end)

        return true
    end
end

---@param opts? {
---     immediate?: boolean,
---     close?: boolean,
---     origin?: OrgPromise<org-roam.core.database.Id|false>|org-roam.core.database.Id|false,
---     templates?: table<string, OrgCaptureTemplateOpts>,
---}
---@return fun(buf: integer): boolean
function M.capture(opts)
    opts = opts or {}

    local close = true
    if opts.immediate then
        close = opts.close
    end

    return function(buf)
        vim.print("Options", opts)
        local title = action_state.get_current_line()

        if close then
            vim.notify("Closing telescope", vim.log.levels.DEBUG)
            actions.close(buf)
        end

        api.create_node({
            title = title,
            origin = opts.origin,
            immediate = opts.immediate,
            templates = opts.templates,
        }):next(function (file)
            if file == nil then
                vim.notify("Failed to capture " .. title, vim.log.levels.ERROR)
            else
                vim.notify("Captured " .. title .. " into " .. file.filename)
            end 
        end)

        if not close then
            ---@type Picker
            local picker = action_state.get_current_picker(buf)
            picker:refresh(nil, { reset_prompt = true })
        end

        return true
    end
end

---@param opts? {
---     create?: boolean,
---     immediate?: boolean,
---     origin?: OrgPromise<org-roam.core.database.Id|false>|org-roam.core.database.Id|false,
---     templates?: table<string, OrgCaptureTemplateOpts>,
---}
---@return fun(buf: integer): boolean
function M.insert_link(opts)
    opts = opts or {}

    return function(buf)
        ---@type orgsuite.telescope.Entry
        local entry = action_state.get_selected_entry()
        local title = action_state.get_current_line()
        actions.close(buf)

        ---@type OrgPromise<OrgFile|OrgHeadline>
        local target = (opts.create or entry == nil)
            and api.create_node({
                title = title,
                origin = opts.origin,
                immediate = opts.immediate,
                templates = opts.templates,
            })
            or Promise.resolve(entry.item)


        ---@param entry OrgFile|OrgHeadline|nil
        target:next(function(entry)
            if entry ~= nil then
                local link = api.get_link(entry)
                org.links:insert_link(link.location, link.description)
            end
        end)

        return true
    end
end

---@param opts? {
---     mode: orgsuite.telescope.Type,
---}
---@return fun(buf: integer): boolean
function M.show(opts)
    opts = opts or {}
    return function(buf)
        ---@type Picker
        local picker = action_state.get_current_picker(buf)

        state.type.set(opts.mode or "all")
        picker.layout.results.border:change_title(state.type.title())
        picker:refresh(nil, {})
    end
end

return M

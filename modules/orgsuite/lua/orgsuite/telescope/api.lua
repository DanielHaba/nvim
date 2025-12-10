local Promise = require("orgmode.utils.promise")
local org = require("orgmode")
local org_api = require("orgmode.api")
local roam = require("org-roam")
local M = {}

local OrgApiFile = require('orgmode.api.file')
local OrgApiHeadline = require('orgmode.api.headline')
local OrgFile = require("orgmode.files.file")
local OrgHeadline = require("orgmode.files.headline")


---@param item OrgFile|OrgHeadline
---@return {
---     location: string,
---     description: string,
---}
function M.get_link(item)
    local location = ""
    local mt = getmetatable(item)

    if mt == OrgFile then
        ---@cast item OrgFile
        location = org.links:get_link_to_file(item)
    elseif mt == OrgHeadline then
        ---@cast item OrgHeadline
        location = org.links:get_link_to_headline(item)
    end
    return {
        location = location,
        description = item:get_title(),
    }
end

---@async
---@return OrgPromise<org-roam.core.file.Node|nil>
function M.get_current_node()
    return Promise.new(function(resolve, reject)
        roam.utils.node_under_cursor(resolve)
    end)
end

---@async
---@return OrgPromise<org-roam.core.database.Id|nil>
function M.get_current_node_id()
    ---@param node org-roam.core.file.Node|nil
    return M.get_current_node():next(function(node)
        if node == nil then
            return nil
        end
        return node.id
    end)
end


---@return OrgApiHeadline|nil
function M.get_current_headline()
    return org_api.current():get_closest_headline()
end

---@async
---@param opts? {
---     immediate?: boolean,
---     origin?: OrgPromise<org-roam.core.database.Id|false>|org-roam.core.database.Id|false,
---     title?: string,
---     templates?: table<string,OrgCaptureTemplateOpts>,
--- }
---@return OrgPromise<OrgFile|nil>
function M.create_node(opts)
    opts = opts or {}
    vim.print("Create node", opts)

    local origin = (opts.origin ~= nil)
        and Promise.resolve(opts.origin)
        or M.get_current_node_id()


    ---@param origin org-roam.core.database.Id|false
    return origin:next(function(origin)
        vim.print("create node", {
            origin = origin,
            title = opts.title,
            immediate = opts.immediate,
            templates = opts.templates,
        })
        return roam.api.capture_node({
                origin = origin,
                title = opts.title,
                immediate = opts.immediate,
                templates = opts.templates,
            })
            ---@param id org-roam.core.database.Id|nil
            :next(function(id)
                if id == nil then
                    vim.notify("Cannot capture node", vim.log.levels.ERROR)
                    return nil
                end
                return roam.database:get(id)
            end)
            ---@param node org-roam.core.file.Node|nil
            :next(function(node)
                if node == nil then
                    vim.notify("Cannot get captured node", vim.log.levels.ERROR)
                    return nil
                end
                return org.files:load_file(node.file)
            end)
    end)
end

---@param item OrgApiFile|OrgApiHeadline|OrgFile|OrgHeadline
---@return OrgApiFile|OrgApiHeadline
function M.get_api(item)
    local mt = getmetatable(item)
    if mt == OrgApiFile then
        ---@cast item OrgApiFile
        return item
    elseif mt == OrgApiHeadline then
        ---@cast item OrgApiHeadline
        return item
    elseif mt == OrgFile then
        ---@cast item OrgFile
        return org_api.load(item.filename)
    elseif mt == OrgHeadline then
        ---@cast item OrgHeadline
        local file = org_api.load(item.file.filename)
        local headline = file:get_headline_on_line(item:get_range().start_line)
        if headline == nil then
            error("unexpected nil")
        end
        return headline
    else
        error("invalid type")
    end
end

-- ---@param file OrgApiFile|OrgFile
-- ---@return OrgApiFile
-- function M.into_api_file(file)
--     if getmetatable(file) == OrgApiFile then
--         ---@cast file OrgApiFile
--         return file
--     end
--     ---@cast file OrgFile
--     return org_api.load(file.filename)
-- end
--
-- ---@param headline OrgApiHeadline|OrgHeadline
-- ---@return OrgApiHeadline
-- function M.into_api_headline(headline)
--     if getmetatable(headline) == OrgApiHeadline then
--         ---@cast headline OrgApiHeadline
--         return headline
--     end
--     ---@cast headline OrgHeadline
--     local file = org_api.load(headline.file.filename)
--
--     local headline = file:get_headline_on_line(headline:get_range().start_line)
--     if headline == nil then
--         error("unexpected nil")
--     end
--     return headline
-- end
--
-- ---@param file OrgApiFile|OrgFile
-- ---@return OrgFile
-- function M.into_file(file)
--     if getmetatable(file) == OrgFile then
--         ---@cast file -OrgApiFile
--         return file
--     end
--     ---@cast file -OrgFile
--     ---@type OrgFile|nil
--     ---@diagnostic disable-next-line: invisible
--     local cached = file._file
--     if cached ~= nil then
--         return cached
--     end
--     local file = org.files:load_file_sync(file.filename)
--     if file == false then
--         error("file is false")
--     end
--     return file
-- end
--
-- ---@param headline OrgApiHeadline|OrgHeadline
-- ---@return OrgHeadline
-- function M.into_headline(headline)
--     if getmetatable(headline) == OrgHeadline then
--         ---@cast headline -OrgApiHeadline
--         return headline
--     end
--     ---@cast headline -OrgHeadline
--     local file = M.into_file(headline.file)
--     local headline = file:get_closest_headline_or_nil(headline.node():range())
--     if headline == nil then
--         error("headline is nil")
--     end
--     return headline
-- end

return M

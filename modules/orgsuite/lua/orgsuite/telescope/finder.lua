---@module "orgmode"
---@module "telescope.finders"
local scheduler = require("plenary.async").util.scheduler
local api = require("orgsuite.telescope.api")
local display = require("orgsuite.telescope.display")
local state = require("orgsuite.telescope.state")

local OrgApiFile = require('orgmode.api.file')
local OrgApiHeadline = require('orgmode.api.headline')
local OrgFile = require("orgmode.files.file")
local OrgHeadline = require("orgmode.files.headline")


---@class orgsuite.telescope.FileEntry
---@field kind "file"
---@field item OrgFile
---@field title string
---@field ordinal string
---@field path string

---@class orgsuite.telescope.HeadlineEntry
---@field kind "headline"
---@field item OrgHeadline
---@field title string
---@field ordinal string
---@field path string
---@field lnum integer

---@alias orgsuite.telescope.Entry orgsuite.telescope.FileEntry|orgsuite.telescope.HeadlineEntry
---@alias orgsuite.telescope.FinderSource OrgFile|OrgHeadline|nil|false

local Promise = require("orgmode.utils.promise")
local org = require("orgmode")
local org_api = require("orgmode.api")
local roam = require("org-roam")

---@class orgsuite.telescope.Finder: finder
---@field results orgsuite.telescope.Entry[]
---@field private loader fun (): OrgPromise<orgsuite.telescope.FinderSource[]>
local Finder = {}
Finder.__index = Finder


---@return orgsuite.telescope.Finder
function Finder.new()
    return setmetatable({
        loader = function()
            return {}
        end,
    }, Finder)
end

function Finder:org()
    self.loader = function()
        return Promise.new(function(resolve, _)
            local result = {}
            for _, file in ipairs(org.files:all()) do
                table.insert(result, file)
                for _, headline in ipairs(file:get_headlines()) do
                    table.insert(result, headline)
                end
            end
            resolve(result)
        end)
    end
    return self
end

---@return orgsuite.telescope.Finder
function Finder:roam()
    self.loader = function()
        ---@param files OrgFiles
        return roam.database:files():next(function(files)
            local result = {}
            for _, file in ipairs(files:all()) do
                table.insert(result, file)
                for _, headline in ipairs(file:get_headlines()) do
                    table.insert(result, headline)
                end
            end
            return result
        end)
    end
    return self
end

---@param id? org-roam.core.database.Id
---@return orgsuite.telescope.Finder
function Finder:children(id)
    local id = id and Promise.resolve(id) or api.get_current_node_id()

    self.loader = function()
        return id
            :next(function(id)
                return roam.database:find_nodes_by_origin(id)
            end)
            :next(function(nodes)
                return self:resolve_nodes(nodes)
            end)
    end
    return self
end

---@param mode "forward"|"backward"
---@param id? org-roam.core.database.Id
---@return orgsuite.telescope.Finder
function Finder:links(mode, id)
    local id = id and Promise.resolve(id) or api.get_current_node_id()

    self.loader = function()
        return id
            :next(function(id)
                vim.print("Node id", id)
                return mode == "forward"
                    and roam.database:get_links(id)
                    or roam.database:get_backlinks(id)
            end)
            :next(function(links)
                vim.print("Links", links)
                return self:resolve_nodes(vim.tbl_keys(links))
            end)
    end
    return self
end

---@private
---@param _ string
---@param next fun (entry: orgsuite.telescope.Entry): boolean
---@param done fun ()
function Finder:__call(_, next, done)

    self.results = nil
    ---@param data orgsuite.telescope.FinderSource[]
    local process = function (data)
        local type = state.type.get()
        local allow_files = type == "all" or type == "files"
        local allow_headlines = type == "all" or type == "headlines"


        self.results = {}
        for i, item in ipairs(data) do
            local mt = getmetatable(item)
            ---@type orgsuite.telescope.Entry
            local entry

            if mt == OrgFile and allow_files then
                ---@cast item OrgFile
                entry = self:file_entry(item)
            elseif mt == OrgHeadline and allow_headlines then
                ---@cast item OrgHeadline
                entry = self:headline_entry(item)
            end
            if entry and next(entry) then
                break
            end

            if i % 1000 == 0 then
                scheduler()
            end
        end
        done() 
    end


    self.loader():next(process)


end

---@private
function Finder:close()

end

---@private
---@param data OrgPromise<(org-roam.core.file.Node|org-roam.core.database.Id)[]>
---@return OrgPromise<(OrgApiFile|OrgApiHeadline|nil)[]>
function Finder:resolve_nodes(data)
    ---@param node org-roam.core.file.Node
    ---@return OrgFile
    local file = function(node)
        vim.notify("Node file " .. node.file, vim.log.levels.INFO)
        return org.files:get(node.file)
    end

    ---@param node org-roam.core.file.Node
    ---@return OrgHeadline|nil
    local headline = function(node)
        local file = org.files:get(node.file)
        return file:get_closest_headline_or_nil({
            node.range.start.row, node.range.start.column,
            node.range.end_.row, node.range.end_.column,
        })
    end

    ---@param item org-roam.core.database.Id|org-roam.core.file.Node
    ---@return OrgPromise<OrgApiFile|OrgApiHeadline|nil>
    local process = function(item)
        local node = type(item) == "string"
            and roam.database:get(item)
            or Promise.resolve(item)

        ---@param node org-roam.core.file.Node|nil
        return node:next(function(node)
            resolved = node
            if node == nil then
                return nil
            elseif node.level == 0 then
                return file(node)
            else
                return headline(node)
            end
        end)
    end

    return Promise.all(vim.tbl_map(process, data))
end

---@private
---@param file OrgFile
---@return orgsuite.telescope.FileEntry
function Finder:file_entry(file)
    local path = file.filename
    local basepath = vim.fn.fnamemodify(path, ":t")
    local title = file:get_title() or basepath
    local lnum = 1

    return {
        kind = "file",
        item = file,
        title = title,
        path = path,
        lnum = lnum,
        ordinal = table.concat({
            path,
            title,
        }, " "),
        display = display.file,
    }
end

---@private
---@param headline OrgHeadline
---@return orgsuite.telescope.HeadlineEntry
function Finder:headline_entry(headline)
    local path = headline.file.filename
    local lnum = headline:get_range().start_line
    local title = headline:get_title()

    return {
        kind = "headline",
        item = headline,
        title = title,
        path = path,
        lnum = lnum,
        ordinal = table.concat({
            string.format("%s:%i", path, lnum),
            title,
        }, " "),
        display = display.headline,
    }
end

return Finder

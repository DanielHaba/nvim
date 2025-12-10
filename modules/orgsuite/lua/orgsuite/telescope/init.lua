local picker = require("telescope.pickers")
local previewers = require("orgsuite.telescope.previewer")
local conf = require("telescope.config").values
local finder = require("orgsuite.telescope.finder")
local action_set = require("telescope.actions.set")
local actions = require("orgsuite.telescope.actions")
local state = require("orgsuite.telescope.state")
local api = require("orgsuite.telescope.api")

local M = {}





---@class orgsuite.telescope.Action
---@field opts? table
---@field [number] fun (opts: table): (fun (buf: integer): boolean)

---@class orgsuite.telescope.KeyAction: orgsuite.telescope.Action
---@field mode string[]|string
---@field desc? string

---@class orgsuite.telescope.Bindings
---@field select? orgsuite.telescope.Action
---@field [string] orgsuite.telescope.KeyAction



---@type table<string, orgsuite.telescope.Bindings>
local bindings = {
    search = {
        ["<C-Enter>"] = {
            mode = { "i", "n" },
            desc = "Capture prompt",
            opts = {},
            actions.capture,
        },
        ["<S-Enter>"] = {
            mode = { "i", "n" },
            desc = "Create prompt immediate",
            opts = { immediate = true },
            actions.capture,
        },
    },

    insert_link = {
        select = {
            opts = {},
            actions.insert_link,
        },
        ["<C-Enter>"] = {
            mode = { "i", "n" },
            desc = "Capture prompt & insert link",
            opts = { create = true },
            actions.insert_link,
        },
        ["<S-Enter>"] = {
            mode = { "i", "n" },
            desc = "Create prompt & insert link",
            opts = { create = true, immediate = true },
            actions.insert_link,
        },
    },

    refile = {
        select = {
            opts = {},
            actions.refile,
        },
        ["<C-Enter>"] = {
            mode = { "i", "n" },
            desc = "Capture prompt & refile",
            opts = { create = true },
            actions.refile,
        },
    },


    general = {
        ["<C-h>"] = {
            mode = { "i", "n" },
            desc = "Show headlines",
            opts = { mode = "headlines" },
            actions.show,
        },
        ["<C-f>"] = {
            mode = { "i", "n" },
            desc = "Show files",
            opts = { mode = "files" },
            actions.show,
        },
        ["<C-a>"] = {
            mode = { "i", "n" },
            desc = "Show all",
            opts = { mode = "all" },
            actions.show,
        },
    }
}


---@param opts table
---@param mappings orgsuite.telescope.Bindings[]
---@return function
local function map(opts, mappings)
    return function(_, map)
        for _, mapping in ipairs(mappings) do
            for key, config in pairs(mapping) do
                ---@cast config orgsuite.telescope.Action
                local opts = vim.tbl_extend("force", config.opts or {}, opts)
                local action = config[1](opts)

                if key == "select" then
                    action_set.select:replace(action)
                else
                    ---@cast config orgsuite.telescope.KeyAction
                    map(config.mode, key, action, { desc = opts.desc })
                end
            end
        end
        return true
    end
end

---@param opts? table
function M.search(opts)
    opts = opts or {}

    if opts.origin == nil then
        opts.origin = api.get_current_node_id()
    end

    picker.new(opts, {
        results_title = state.type.title(),
        finder = finder.new():org(),
        sorter = conf.generic_sorter(opts),
        -- previewer = conf.grep_previewer(opts),
        previewer = previewers.new(opts),
        attach_mappings = map(opts, { bindings.search, bindings.general }),
    }):find()
end

---@param opts? table
function M.insert_link(opts)
    opts = opts or {}

    if opts.origin == nil then
        opts.origin = api.get_current_node_id()
    end

    picker.new(opts, {
        results_title = state.type.title(),
        finder = finder.new():org(),
        sorter = conf.generic_sorter(opts),
        -- previewer = conf.grep_previewer(opts),
        previewer = previewers.new(opts),
        attach_mappings = map(opts, { bindings.insert_link, bindings.general }),
    }):find()
end

---@param opts? table
function M.refile(opts)
    opts = opts or {}


    if opts.source == nil then
        opts.source = api.get_current_headline()
    end
    if opts.source == nil then
        vim.notify("Cannot determine headline", vim.log.levels.ERROR)
        return
    end

    if opts.origin == nil then
        opts.origin = api.get_current_node_id()
    end


    picker.new(opts, {
        results_title = state.type.title(),
        finder = finder.new():org(),
        sorter = conf.generic_sorter(opts),
        -- previewer = conf.grep_previewer(opts),
        previewer = previewers.new(opts),
        attach_mappings = map(opts, { bindings.refile, bindings.general }),
    }):find()
end

---@param opts? table
function M.forward_links(opts)
    opts = opts or {}

    picker.new(opts, {
        results_title = state.type.title(),
        finder = finder.new():links("forward"),
        sorter = conf.generic_sorter(opts),
        -- previewer = conf.grep_previewer(opts),
        previewer = previewers.new(opts),
        attach_mappings = map(opts, { bindings.general }),
    }):find()
end

---@param opts? table
function M.backward_links(opts)
    opts = opts or {}

    picker.new(opts, {
        results_title = state.type.title(),
        finder = finder.new():links("backward"),
        sorter = conf.generic_sorter(opts),
        -- previewer = conf.grep_previewer(opts),
        previewer = previewers.new(opts),
        attach_mappings = map(opts, { bindings.general }),
    }):find()
end

---@param opts? table
function M.children(opts)
    opts = opts or {}


    picker.new(opts, {
        results_title = state.type.title(),
        finder = finder.new():children(),
        sorter = conf.generic_sorter(opts),
        -- previewer = conf.grep_previewer(opts),
        previewer = previewers.new(opts),
        attach_mappings = map(opts, { bindings.general }),
    }):find()
end

return M

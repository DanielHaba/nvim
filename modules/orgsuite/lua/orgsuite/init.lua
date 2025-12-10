local M = {
    open = require("orgsuite.open"),
    action = require("orgsuite.action"),
}

local default_config = {
    patches = {
        superagenda_refile = true,
        telescope_markview = true,
    },
    action = {
        handlers = {
            timestamp = "org_mappings.change_date",
            headline = "org_mappings.todo_next_state",
            listitem = "org_mappings.toggle_checkbox",
            list = "org_mappings.toggle_checkbox",
        },
    },
}

function M.setup(opts)
    opts = vim.tbl_deep_extend("force", default_config, opts)


    require("orgsuite.patches").setup(opts)
    M.action:setup(opts.action)
end



return M



require("org-super-agenda.adapters.neovim.refile_telescope").start = function (params, on_done)

    local org_api = require("orgmode.api")

    local file = org_api.load(params.src_file)
    local source = file:get_headline_on_line(params.s)

    if source == nil then
        return vim.notify("Invalid refile request", vim.log.levels.ERROR)
    end
    
    require("orgsuite.telescope").refile({
        source = source,
        on_done = on_done,
    })
end



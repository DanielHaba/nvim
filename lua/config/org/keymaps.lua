return {
    org_general = {
        {
            desc = "Org search",
            mode = { "n" },
            opts = { silent = true },
            "<Leader>fo",
            "<Cmd>Telescope orgsuite search<CR>",
        },
        {
            desc = "Org agenda",
            mode = { "n" },
            opts = { silent = true },
            "<Leader>oa",
            "<Cmd>OrgSuperAgenda<CR>",
        },
    },
    org = {
        filetypes = "org",
        {
            desc = "Reformat",
            mode = { "n" },
            opts = { silent = true },
            "<Leader>rf",
            "gggqG'0",
        },
        {
            desc = "Insert link",
            mode = { "n", "i" },
            opts = { silent = true },
            "<C-l>",
            "<Cmd>Telescope orgsuite insert_link<CR>",
        },
        {
            desc = "Org refile",
            mode = { "n" },
            opts = { silent = true },
            "<Leader>rr",
            "<Cmd>Telescope orgsuite refile<CR>",
        },
        {
            desc = "Org search children",
            mode = { "n" },
            opts = { silent = true },
            "gc",
            "<Cmd>Telescope orgsuite children<CR>",
        },
        {
            desc = "Org search links",
            mode = { "n" },
            opts = { silent = true },
            "gl",
            "<Cmd>Telescope orgsuite links<CR>",
        },
        {
            desc = "Org search backlinks",
            mode = { "n" },
            opts = { silent = true },
            "gL",
            "<Cmd>Telescope orgsuite backlinks<CR>",
        },
        {
            desc = "Jump to",
            mode = { "n" },
            opts = { silent = true },
            "gd",
            function ()
                require("orgsuite").open:org()
            end,
        },
        {
            desc = "Context action",
            mode = { "n" },
            opts = { silent = true },
            "<CR>",
            function ()
                require("orgsuite").action()
            end,
        },
        {
            desc = "Meta return",
            mode = { "n", "i" },
            opts = { silent = true },
            "<S-CR>",
            function ()
                require("orgmode").action("org_mappings.meta_return")
            end,
        },
    },
    agenda = {
        filetypes = "orgagenda",
    },
    markdown = {
        filetypes = "markdown",
        {
            desc = "Jump to",
            mode = { "n" },
            opts = { silent = true },
            "gd",
            function ()
                require("orgsuite").open:markdown()
            end,
        },
    },
}

return {
    {
        "nvim-orgmode/orgmode",
        event = "VeryLazy",
        ft = { "org" },
        dependencies = {
            { "theme" },
            { "michaelb/sniprun" },
            { "OXY2DEV/markview.nvim" },
        },
        opts = function()
            return require("config.org.orgmode")
        end,
    },
    {
        "chipsenkbeil/org-roam.nvim",
        event = "VeryLazy",
        ft = { "org" },
        dependencies = {
            { "nvim-orgmode/orgmode" },
        },
        cmd = {
            "RoamAddAlias",
            "RoamAddOrigin",
            "RoamRemoveAlias",
            "RoamRemoveOrigin",
            "RoamReset",
            "RoamSave",
            "RoamUpdate",
        },
        opts = function ()
            return require("config.org.orgroam")
        end,
    },
    {
        "hamidi-dev/org-super-agenda.nvim",
        dependencies = {
            "nvim-orgmode/orgmode",
        },
        cmd = { "OrgSuperAgenda" },
        opts = function ()
            return require("config.org.superagenda")
        end,
    },
    {
        "michaelb/sniprun",
        build = "sh install.sh",
        cmd = { 
            "SnipRun",
            "SnipLive",
            "SnipInfo",
            "SnipReset",
            "SnipReplMemoryClean",
            "SnipClose",
        },
        opts = function ()
            return require("config.sniprun")
        end
    },
    -- {
    --     "lukas-reineke/headlines.nvim",
    --     dependencies = {
    --         { "nvim-treesitter/nvim-treesitter" },
    --     },
    --     opts = function ()
    --         return require("config.org.headlines")
    --     end
    -- },
    {
        "orgsuite",
        dev = true,
        dependencies = {
            { "nvim-treesitter/nvim-treesitter" },
            { "nvim-orgmode/orgmode" },
            { "chipsenkbeil/org-roam.nvim" },
            { "hamidi-dev/org-super-agenda.nvim" },
            {
                "nvim-telescope/telescope.nvim",
                opts = { load_extensions = { "orgsuite" } },
            },
            {
                "keymaps",
                opts = require("config.org.keymaps"),
            },
        },
        opts = {},
    },
}

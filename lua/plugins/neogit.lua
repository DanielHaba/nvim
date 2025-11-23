return {
    {

        "NeogitOrg/neogit",
        lazy = true,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",
            "nvim-telescope/telescope.nvim",
        },
        cmd = "Neogit",
        init = function()
            require("utils.backdrop").create("NeogitStatus")
            require("utils.backdrop").create("NeogitPopup")
        end,
        opts = function()
            return require("config.neogit")
        end
    },
    {
        "sindrets/diffview.nvim",
        opts = function ()
            return require("config.diffview") 
        end,
    },
}

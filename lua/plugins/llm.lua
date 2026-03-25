return {
    -- {
    --     "nickjvandyke/opencode.nvim",
    --     dependencies = {
    --         { "folke/snacks.nvim", optional = true },
    --     },
    --     opts = function ()
    --         return require("config.opencode")
    --     end,
    --     config = function (_, opts)
    --         vim.o.autoread = true
    --         vim.g.opencode_opts = opts
    --     end,
    -- },

    -- {
    --     "yetone/avante.nvim",
    --     build = "make",
    --     version = false,
    --     dependencies = {
    --         { "nvim-lua/plenary.nvim" },
    --         { "MunifTanjim/nui.nvim" },
    --         { "nvim-telescope/telescope.nvim" },
    --         { "stevearc/dressing.nvim" },
    --         { "folke/snacks.nvim" },
    --         { "OXY2DEV/markview.nvim" },
    --         {
    --             "HakonHarnes/img-clip.nvim",
    --             opts = {
    --                 default = {
    --                     embed_image_as_base64 = false,
    --                     prompt_for_file_name = false,
    --                     drag_and_drop = {
    --                         insert_mode = true,
    --                     },
    --                 },
    --             },
    --         },
    --         {
    --             "MeanderingProgrammer/render-markdown.nvim",
    --             opts = {
    --                 file_types = { "Avante" },
    --             },
    --             ft = { "Avante" },
    --         },
    --     },
    --     cmd = {
    --         "AvanteAsk",
    --         "AvanteBuild",
    --         "AvanteChat",
    --         "AvanteChatNew",
    --         "AvanteHistory",
    --         "AvanteClear",
    --         "AvanteEdit",
    --         "AvanteFocus",
    --         "AvanteRefresh",
    --         "AvanteStop",
    --         "AvanteSwitchProvider",
    --         "AvanteShowRepoMap",
    --         "AvanteToggle",
    --         "AvanteModels",
    --         "AvanteSwitchSelectorProvider",
    --     },
    --     opts = function()
    --         return require("config.avante")
    --     end,
    -- },


    -- {
    --     "olimorris/codecompanion.nvim",
    --     dependencies = {
    --         { "nvim-lua/plenary.nvim" },
    --         { "nvim-treesitter/nvim-treesitter" },
    --         { "ravitemer/mcphub.nvim" },
    --         { "OXY2DEV/markview.nvim" },
    --         {
    --             "HakonHarnes/img-clip.nvim",
    --             opts = {
    --                 filetypes = {
    --                     codecompanion = {
    --                         prompt_for_file_name = false,
    --                         template = "[Image]($FILE_PATH)",
    --                         use_absolute_path = true,
    --                     },
    --                 },
    --             },
    --         },
    --     },
    --     cmd = {
    --         "CodeCompanionChat",
    --         "CodeCompanion",
    --         "CodeCompanionCmd",
    --     },
    --     opts = function ()
    --         return require("config.codecompanion")
    --     end,
    -- },

    {
        "carlos-algms/agentic.nvim",

        dependencies = {
            { "hakonharnes/img-clip.nvim", opts = {} },
            {
                "MeanderingProgrammer/render-markdown.nvim",
                opts = {
                    file_types = { "AgenticChat" },
                },
                ft = { "AgenticChat" },
            },
        },
        opts = function()
            return require("config.agentic")
        end,
    },
}

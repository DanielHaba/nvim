return {
    {
        "nvim-tree/nvim-web-devicons",
        opts = {},
    },
    {
        "nvim-treesitter/nvim-treesitter",
        event = "VeryLazy",
        cmd = {
            "TSInstall",
            "TSUpdate",
            "TSBufEnable",
            "TSBufDisable",
            "TSEnable",
            "TSDisable",
            "TSModuleInfo",
        },
        build = ":TSUpdate",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            "RRethy/nvim-treesitter-textsubjects",
            "nvim-treesitter/playground",
        },
        opts = function()
            return require("config.treesitter")
        end,
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)

            local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"

            -- vim way: ; goes to the direction you were moving.
            vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
            vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

            -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
            vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
            vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
            vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
            vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)
        end,
    },
    {
        "williamboman/mason.nvim",
        cmd = {
            "Mason",
            "MasonUpdate",
            "MasonInstall",
            "MasonUninstall",
            "MasonUninstallAll",
            "MasonLog",
        },
        build = ":MasonUpdate",
        opts = function()
            return require("config.mason")
        end,
    },
    {
        "neovim/nvim-lspconfig",
        event = "VeryLazy",
        dependencies = {
            {
                "williamboman/mason-lspconfig.nvim",
                cmd = {
                    "LspInstall",
                    "LspUninstall",
                },
                dependencies = {
                    "williamboman/mason.nvim",
                },
                opts = function()
                    return require("config.mason").lsp
                end,
            },
            { "jubnzv/virtual-types.nvim" },
        },
        config = function()
            require("config.lsp")
        end,
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        event = "VeryLazy",
        dependencies = {
            {
                "jay-babu/mason-null-ls.nvim",
                cmd = {
                    "NullLsInstall",
                    "NullLsUninstall",
                },
                dependencies = {
                    "williamboman/mason.nvim",
                },
                opts = function()
                    return require("config.mason").null_ls
                end,
            },
        },
        config = function()
            require("config.null_ls")
        end,
    },
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            {
                "jay-babu/mason-nvim-dap.nvim",
                cmd = {
                    "DapInstall",
                    "DapUninstall",
                },
                dependencies = {
                    "williamboman/mason.nvim",
                },
                opts = function()
                    return require("config.mason").dap
                end,
            },
            {
                "theHamsta/nvim-dap-virtual-text",
                dependencies = {
                    "nvim-treesitter/nvim-treesitter",
                },
            },
            { "rcarriga/nvim-dap-ui" },
        },
        config = function()
            require("config.dap")
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            {
                "windwp/nvim-autopairs",
                opts = {
                    fast_wrap = {},
                    disable_filetype = { "TelescopePrompt", "vim" },
                },
                config = function(_, opts)
                    require("nvim-autopairs").setup(opts)
                    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
                    require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
                end,
            },
            {
                "L3MON4D3/LuaSnip",
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-nvim-lsp-signature-help",
                "hrsh7th/cmp-nvim-lua",
            },
        },
        opts = function()
            return require("config.cmp")
        end,
    },
    -- {
    --     "andythigpen/nvim-coverage",
    --     dependencies = {
    --         "nvim-lua/plenary.nvim",
    --     },
    -- },
    -- {
    --     "klen/nvim-test",
    --
    -- },

    {
        "nvim-telescope/telescope.nvim",
        cmd = {
            "Telescope",
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        init = function()
            require("config.keymaps").setup("telescope")
        end,
        opts = function()
            return require("config.telescope")
        end,
        config = function(_, opts)
            local telescope = require("telescope")
            telescope.setup(opts)

            if opts.load_extensions then
                for name, enabled in pairs(opts.load_extensions) do
                    if enabled then
                        telescope.load_extension(name)
                    end
                end
            end
        end,
    },
    {
        "themercorp/themer.lua",
        event = "UIEnter",
        cmd = {
            "ThemerReload",
            "ThemerInstall",
            "ThemerUnInstall",
        },
        dependencies = {
            {
                "nvim-telescope/telescope.nvim",
                opts = {
                    load_extensions = {
                        themes = true,
                    },
                },
            },
        },
        opts = function()
            return require("config.themer")
        end,
    },
    {
        "olimorris/persisted.nvim",
        event = "VeryLazy",
        cmd = {
            "SessionToggle",
            "SessionStart",
            "SessionStop",
            "SessionSave",
            "SessionLoad",
            "SessionLoadLast",
            "SessionLoadFromFile",
            "SessionDelete",
        },
        opts = {
            options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" },
            autosave = true,
            autoload = true,
            use_git_branch = true,
        },
    },
    {
        "stevearc/dressing.nvim",
        event = "UIEnter",
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },
        opts = function()
            return require("config.dressing")
        end,
    },
    {
        "rcarriga/nvim-notify",
        event = "UIEnter",
        dependencies = {
            {

                "nvim-telescope/telescope.nvim",
                opts = {
                    load_extensions = {
                        notify = true,
                    },
                },
            },
        },
        opts = {},
        config = function(_, opts)
            local notify = require("notify")
            notify.setup(opts)
            vim.notify = notify
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = function()
            return require("config.lualine")
        end,
    },
    {
        "numToStr/Comment.nvim",
        keys = {
            { "gcc", mode = "n",          desc = "Comment toggle current line" },
            { "gc",  mode = { "n", "o" }, desc = "Comment toggle linewise" },
            { "gc",  mode = "x",          desc = "Comment toggle linewise (visual)" },
            { "gbc", mode = "n",          desc = "Comment toggle current block" },
            { "gb",  mode = { "n", "o" }, desc = "Comment toggle blockwise" },
            { "gb",  mode = "x",          desc = "Comment toggle blockwise (visual)" },
        },
        opts = {},
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            filetype_exclude = {
                "help",
                "alpha",
                "dashboard",
                "neo-tree",
                "Trouble",
                "lazy",
                "mason",
                "notify",
                "toggleterm",
                "lazyterm",
            },
            show_current_context = false,
            show_current_context_start = false,
        },
    },
    {
        "kylechui/nvim-surround",
        event = { "BufReadPre", "BufNewFile" },
        opts = {},
    },
    {
        "NvChad/nvim-colorizer.lua",
        event = { "BufReadPre", "BufNewFile" },
        cmd = {
            "ColorizerAttachToBuffer",
            "ColorizerDetachFromBuffer",
            "ColorizerReloadAllBuffers",
            "ColorizerToggle",
        },
        opts = {
            filetypes = { "*" },
        },
    },
    {
        "RRethy/vim-illuminate",
        event = { "BufReadPre", "BufNewFile" },
        cmd = {
            "IlluminatePause",
            "IlluminateResume",
            "IlluminateToggle",
            "IlluminatePauseBuf",
            "IlluminateResumeBuf",
            "IlluminateToggleBuf",
        },
        config = function()
            require("illuminate").configure()
        end,
    },


    { "b0o/schemastore.nvim" },
}

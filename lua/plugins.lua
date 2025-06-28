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
            "windwp/nvim-ts-autotag",
            "nvim-treesitter/playground",

            "nushell/tree-sitter-nu",
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
            {
                "ckolkey/ts-node-action",
                dependencies = {
                    "nvim-treesitter",
                },
                opts = {},
            },
            { "jubnzv/virtual-types.nvim" },
        },
        config = function()
            require("config.lsp")
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
                "rcarriga/nvim-dap-ui",
                dependencies = {
                    "nvim-neotest/nvim-nio",
                },
                opts = {},
            },
            {
                "theHamsta/nvim-dap-virtual-text",
                dependencies = {
                    "nvim-treesitter/nvim-treesitter",
                },
                opts = {},
            },
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
                "saadparwaiz1/cmp_luasnip",
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
        event = "VimEnter",
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
        opts = function()
            return require("config.notify")
        end,
        config = function(_, opts)
            local notify = require("notify")
            notify.setup(opts)
            -- vim.notify = notify
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
        tag = "v2.20.8",
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

    {
        "folke/trouble.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "neovim/nvim-lspconfig",
        },
        cmd = {
            "Trouble",
            "TroubleClose",
            "TroubleToggle",
            "TroubleRefresh",
        },
        init = function()
            require("config.keymaps").setup("trouble")
        end,
        opts = {
            use_diagnostic_signs = true,
            mode = "document_diagnostics",
        },
    },

    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
        cmd = {
            "Neotree",
        },
        init = function()
            require("config.keymaps").setup("neotree")
        end,
        opts = function()
            return require("config.neo-tree")
        end,
    },

    {
        "folke/noice.nvim",
        event = "VimEnter",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        init = function()
            require("config.keymaps").setup("noice")
        end,
        opts = function()
            return require("config.noice")
        end,
        config = function(_, opts)
            local noice = require("noice")
            noice.setup(opts)
            vim.notify = noice.notify
        end,
    },

    -- {
    --     "nathom/filetype.nvim",
    --     event = "VeryLazy",
    --     opts = function ()
    --         return require("config.filetype")
    --     end,
    -- },
    
    {
        "nvimtools/none-ls.nvim",
        event = "VeryLazy",
        dependencies = {

        },
        config = function ()
            return require("config.null_ls") 
        end,
    },
    {
        "jay-babu/mason-null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            {
                "nvimtools/none-ls.nvim",
                event = "VeryLazy",
                config = function()
                    require("config.null_ls")
                end,
            },
        },
        opts = function()
            return require("config.mason").null_ls
        end,
    },

    {
        enabled = true,
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {},
    },

    {
        "LhKipp/nvim-nu",
        event = "VeryLazy",
        build = ":TSInstall nu",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvimtools/none-ls.nvim",
        },
        opts = {
            use_lsp_features = true,
        },
    },

    {
        "mbbill/undotree",
        cmd = {
            "UndotreeToggle",
        },
    },

    {
        "mrcjkb/rustaceanvim",
        version = "^5",
        dependencies = {
            {
                "saecki/crates.nvim",
                tag = "stable",
                dependencies = { "nvim-lua/plenary.nvim" },
                config = function()
                    require("crates").setup()
                end,
            },
        },
    },
    {
        "ray-x/go.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
        },
        build = ':lua require("go.install").update_all_sync()'
    },

    { "Hoffs/omnisharp-extended-lsp.nvim" },
    { "mfussenegger/nvim-dap-python" },
    { "leoluz/nvim-dap-go" },
    { "b0o/schemastore.nvim" },
    { "lewis6991/gitsigns.nvim" },
}

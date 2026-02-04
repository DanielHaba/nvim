vim.api.nvim_create_autocmd("BufWinEnter", {
    pattern = {"*"},
    command = "normal zR",
})

local textobjects = function(opts)
    local config = {
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {},
            goto_next_end = {},
            goto_previous_start = {},
            goto_previous_end = {},
        },
        select = {
            enable = true,
            lookahead = true,
            keymaps = {},
        },
    }

    for symbol, type in pairs(opts.selectors) do
        local variants = {
            { symbol = symbol, selector = type },
        }
        if type ~= "@statement" then
            variants = {
                { symbol = "a" .. symbol, type = type .. ".outer" },
                { symbol = "i" .. symbol, type = type .. ".inner" },

            }
        end
        for _, selector in ipairs(variants) do
            local lowSymbol = selector.symbol:gsub("%l$", string.lower)
            local highSymbol = selector.symbol:gsub("%l$", string.upper)

            config.move.goto_next_start["]" .. lowSymbol] = selector.type
            config.move.goto_previous_start["[" .. lowSymbol] = selector.type
            config.move.goto_next_end["]" .. highSymbol] = selector.type
            config.move.goto_previous_end["[" .. highSymbol] = selector.type

            config.select.keymaps["a" .. selector.symbol] = selector.type
        end
    end


    return config
end

return {
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
            "windwp/nvim-ts-autotag",
            "nvim-treesitter/playground",
        },
        opts = function()
            return require("config.treesitter")
        end,
        config = function(_, opts)
            -- vim.wo.foldmethod = 'expr'
            -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

            require("nvim-treesitter.configs").setup({
                ensure_installed = opts.ensure_installed,
                indent = {
                    enable = true,
                },
                highlight = {
                    enable = true,
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<C-Space>",
                        node_incremental = "<C-Space>",
                        node_decremental = "<C-BS>",
                        scope_incremental = false,
                    },
                },
                textobjects = textobjects(opts.textobjects),
                autotag = {
                    enable = true,
                },
                playground = {
                    enable = true,
                }
            })

            local ts_repeat_move = require "nvim-treesitter-textobjects.repeatable_move"

            -- vim way: ; goes to the direction you were moving.
            vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move, { desc = "Repeat last move" })
            vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite, { desc = "Repeat last move opposite" })

            -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
            vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true, desc = "Jump to next" })
            vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true, desc = "Jump to previous" })
            vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true, desc = "Jump before next" })
            vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true, desc = "Jump before previous" })
        end,
    },
}

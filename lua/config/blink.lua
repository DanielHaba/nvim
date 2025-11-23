local draw = {
    components = {
        kind_icon = {
            text = function(ctx)
                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                    local mini_icon, _ = require("mini.icons").get_icon(ctx.item.data.type, ctx.label)
                    if mini_icon then return mini_icon .. ctx.icon_gap end
                end

                local icon = require("lspkind").symbolic(ctx.kind, { mode = "symbol" })
                return icon .. ctx.icon_gap
            end,

            -- Optionally, use the highlight groups from mini.icons
            -- You can also add the same function for `kind.highlight` if you want to
            -- keep the highlight groups in sync with the icons.
            highlight = function(ctx)
                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                    local mini_icon, mini_hl = require("mini.icons").get_icon(ctx.item.data.type, ctx.label)
                    if mini_icon then return mini_hl end
                end
                return ctx.kind_hl
            end,
        },
        kind = {
            -- Optional, use highlights from mini.icons
            highlight = function(ctx)
                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                    local mini_icon, mini_hl = require("mini.icons").get_icon(ctx.item.data.type, ctx.label)
                    if mini_icon then return mini_hl end
                end
                return ctx.kind_hl
            end,
        }
    }
}
return {
    keymap = {
        preset = "none",

        ["<C-Space>"] = { "select_and_accept", "show" },
        ["<C-Enter>"] = { "accept", "fallback" },
        ["<Tab>"] = { "select_and_accept", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },

        ["<C-n>"] = { "select_next", "show", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback" },
        ["<C-e>"] = { "hide", "fallback" },


        ["<C-k>"] = {
            function(cmp)
                if cmp.is_menu_visible() then
                    return (cmp.hide_documentation()
                        or cmp.show_documentation())
                else
                    return (cmp.hide_signature()
                        or cmp.show_signature())
                end
            end,
            "fallback",
        },
        ["<C-u>"] = {
            "scroll_signature_up",
            "scroll_documentation_up",
            "fallback",
        },
        ["<C-d>"] = {
            "scroll_signature_down",
            "scroll_documentation_down",
            "fallback",
        },
    },
    completion = {
        keyword = { range = "full" },
        trigger = {
            show_on_keyword = true,
        },
        accept = {
            auto_brackets = {
                enabled = true,
            },
        },
        ghost_text = {
            enabled = true,
        },
        menu = {
            draw = {
                padding = 0,
                gap = 1,
                columns = { { "kind_icon" }, { "label", gap = 1 } },
                components = require("utils.blink").menu_components,
            },
        },
        documentation = {
            auto_show = true,
            draw = require("utils.blink").draw_documentation,
            window = {
                border = "solid",
            },
        },
    },
    cmdline = {
        enabled = true,
        keymap = { preset = "inherit" },
        completion = {
            menu = {
                auto_show = false,
            },
            ghost_text = {
                enabled = true,
            },
        },
    },
    sources = {
        default = { "lsp", "snippets" },
    },
    snippets = {
        preset = "default",
    },
    signature = {
        enabled = true,
        window = {
            show_documentation = true,
            border = "single",
        },
    },
    fuzzy = {
        implementation = "prefer_rust_with_warning",
        sorts = {
            "exact",
            "score",
            "sort_text",
        },
    },
}

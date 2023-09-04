local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.code_actions.gitrebase,
        null_ls.builtins.code_actions.gitsigns,
        null_ls.builtins.code_actions.refactoring,
        null_ls.builtins.completion.tags,

        -- env
        null_ls.builtins.diagnostics.dotenv_linter,

        -- sh
        null_ls.builtins.code_actions.shellcheck,
        null_ls.builtins.diagnostics.shellcheck,
        null_ls.builtins.formatting.beautysh,
        null_ls.builtins.hover.printenv,

        -- treesitter
        null_ls.builtins.code_actions.ts_node_action,

        -- lua
        null_ls.builtins.diagnostics.luacheck,

        -- go
        null_ls.builtins.code_actions.gomodifytags,
        null_ls.builtins.code_actions.impl,

    },
})

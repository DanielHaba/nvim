local options = {
    lsp = {
        automatic_installation = true,
        ensure_installed = {
            "bashls",
            "clangd",
            -- "csharp_ls",
            "cmake",
            "cssls",
            "denols",
            "dockerls",
            "docker_compose_language_service",
            "golangci_lint_ls",
            "gopls",
            "graphql",
            "html",
            "jsonls",
            "ts_ls",
            "lua_ls",
            "rust_analyzer",
            "sqlls",
            "taplo",
            "lemminx",
            "yamlls",
            "pylsp",
            "terraformls",
            "buf_ls",
        },
    },
    null_ls = {
        automatic_installation = true,
        ensure_installed = {},
    },
    dap = {
        automatic_installation = true,
        ensure_installed = {
            "codelldb",
        },
    },
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
        },
    },
}

return options

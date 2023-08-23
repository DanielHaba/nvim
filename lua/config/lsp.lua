local lspconfig = require("lspconfig")
local capabilities = vim.lsp.protocol.make_client_capabilities()
local on_attach = function(client, bufnr)
    require("config.keymaps").setup("lsp", { buffer = bufnr })
    require("virtualtypes").on_attach(client, bufnr)
end

capabilities.textDocument.completion.completionItem = {
    documentationFormat = { "markdown", "plaintext" },
    snippetSupport = true,
    preselectSupport = true,
    insertReplaceSupport = true,
    labelDetailsSupport = true,
    deprecatedSupport = true,
    commitCharactersSupport = true,
    tagSupport = { valueSet = { 1 } },
    resolveSupport = {
        properties = {
            "documentation",
            "detail",
            "additionalTextEdits",
        },
    },
}

lspconfig.omnisharp.setup({
    on_attach = on_attach,
    capabilities = capabilities,

    handlers = {
        ["textDocument/definition"] = require('omnisharp_extended').handler,
    },
    enable_editorconfig_support = true,
    enable_roslyn_analyzers = true,
    organize_imports_on_format = true,
    enable_import_completion = true,
})

-- lspconfig.csharp_ls.setup({
--     on_attach = on_attach,
--     capabilites = capabilities,
-- })

lspconfig.lua_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,

    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = {
                    [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                    [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
                    [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
                },
                maxPreload = 100000,
                preloadFileSize = 10000,
            },
        },
    },
})

lspconfig.jsonls.setup({
    on_attach = on_attach,
    capabilities = capabilities,

    settings = {
        json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
        },
    },
})

lspconfig.yamlls.setup({
    on_attach = on_attach,
    capabilities = capabilities,

    settings = {
        yaml = {
            schemaStore = {
                enable = false,
            },
            schemas = require('schemastore').yaml.schemas(),
        },
    },
})

for _, server in ipairs({ "html", "cssls", "tsserver", "clangd" }) do
    lspconfig[server].setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })
end

require("rust-tools").setup({
    server = {
        on_attach = on_attach,
        capabilities = capabilities,
    },
})
require("rust-tools").inlay_hints.enable()


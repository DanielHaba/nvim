local mason_registry = require("mason-registry")
local lspconfig = require("lspconfig")
local capabilities = vim.lsp.protocol.make_client_capabilities()
local on_attach = function(client, bufnr)

    if type(vim.g.lsp_disable) == "table" then
        for _, disabled in ipairs(vim.g.lsp_disable) do
            if disabled == client.name then
                client.stop()
                return
            end
        end
    end

    require("config.keymaps").setup("lsp", { buffer = bufnr })
    require("virtualtypes").on_attach(client, bufnr)
end

capabilities.textDocument.completion.completionItem = {
    documentationFormat = { "markdown", "plaintext" },
    snippetSupport = false,
    preselectSupport = false,
    insertReplaceSupport = false,
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

local codelldb = mason_registry.get_package("codelldb")
local codelldb_path = codelldb:get_install_path() .. "/extension/adapter/codelldb"
local liblldb_path = codelldb:get_install_path() .. "/extension/lldb/lib/liblldb.so"

require("rust-tools").setup({
    server = {
        on_attach = on_attach,
        capabilities = capabilities,
    },
    tools = {
        on_initialized = function ()
            vim.lsp.codelens.refresh()
        end,
    },
    dap = {
        adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
    },
})
require("rust-tools").inlay_hints.enable()

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

for _, server in ipairs({ "html", "cssls", "tsserver", "clangd", "lemminx" }) do
    lspconfig[server].setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })
end

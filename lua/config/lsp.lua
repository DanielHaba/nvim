-- local mason_registry = require("mason-registry")
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

-- local codelldb = mason_registry.get_package("codelldb")
-- local codelldb_path = codelldb:get_install_path() .. "/extension/adapter/codelldb"
-- local liblldb_path = codelldb:get_install_path() .. "/extension/lldb/lib/liblldb.so"

vim.g.rustaceanvim = {
    tools = {},
    server = {
        on_attach = on_attach,
        capabilities = capabilities,
    },
}

require("rustaceanvim")
-- require("rust-tools").setup({
--     server = {
--         on_attach = on_attach,
--         capabilities = capabilities,
--         settings = {
--             ["rust-analyzer"] = {
--                 -- rust-analyzer.completion.callable.snippets
--                 -- rust-analyzer.completion.fullFunctionSignatures.enable
--                 -- rust-analyzer.lens.references.adt.enable
--                 completion = {
--                     callable = {
--                         snippets = false,
--                     },
--                 },
--                 procMacro = {
--                     enable = true,
--                 },
--             },
--         },
--     },
--     tools = {
--         on_initialized = function ()
--             vim.lsp.codelens.refresh()
--         end,
--         float_win_config = {
--             borders = "none",
--         },
--     },
--     dap = {
--         adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
--     },
-- })

require("go").setup({
    lsp_on_attach = on_attach,
    lsp_cfg = {
        capabilities = capabilities,
        settings = {
            gopls =  {
                buildFlags = { "-tags=acceptance" },
            },
        },
    },
    lsp_keymaps = false,
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

lspconfig.pylsp.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    enabled = true,
                    ignore = { "E201", "E303", "E501" },
                    maxLineLength = 180,
                },
            },
        },
    },
})

lspconfig.clangd.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = {
        "clangd",
        "--clang-tidy",
        "--enable-config",
        "--background-index",
        "--log=verbose",
    },
    init_options = {
        fallbackFlags = {
            "-I/usr/avr/include",
        },
    },
    root_markers = {
        ".clangd",
        ".clang-tidy",
        ".clang-format",
        "compile_commands.json",
        "compile_flags.txt",
        "configure.ac", -- AutoTools
        ".git",
    },
})

for _, server in ipairs({ "html", "ts_ls", "lemminx", "terraformls", "buf_ls", "sqlls" }) do
    lspconfig[server].setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })
end

return {
    lua_ls = {
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
    },

    jsonls = {
    },

    yamlls = {
    },

    pylsp = {
        settings = {
            configurationSources = { "flake8" },
            pylsp = {
                plugins = {
                    pyflakes = {
                        enabled = true,
                    },
                    pycodestyle = {
                        enabled = true,
                        ignore = { "E201", "E303", "E501" },
                        maxLineLength = 180,
                    },
                },
            },
        },
    },

    clangd = {
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
    },
}

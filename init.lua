require("config.vim")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
        lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
    spec = {
        { import = "plugins" },
    },
    defaults = {
        lazy = true,
        version = false,
    },
    -- install = { colorscheme = { vim.g.colorscheme } },
    checker = { enabled = true },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})

local icons = require("config.icons")
for hl, icon in pairs({ Error = icons.diagnostics.error, Warn = icons.diagnostics.warning, Hint = icons.diagnostics.hint, Info = icons.diagnostics.information }) do
    hl = "DiagnosticSign" .. hl
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

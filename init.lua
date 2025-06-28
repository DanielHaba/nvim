require("config.vim")

vim.filetype.add({
    extension = {
        tf = "terraform",
        tfvars = "terraform",
    },
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "terraform",
	command = "setlocal shiftwidth=4 tabstop=4"
})

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
    install = { colorscheme = { vim.g.colorscheme } },
    checker = { enabled = true },
    performance = {
        rtp = {
            disabled_plugins = {
                "2html_plugin",
                "tohtml",
                "getscript",
                "getscriptPlugin",
                "gzip",
                "logipat",
                "netrw",
                "netrwPlugin",
                "netrwSettings",
                "netrwFileHandlers",
                "matchit",
                "tar",
                "tarPlugin",
                "rrhelper",
                "spellfile_plugin",
                "vimball",
                "vimballPlugin",
                "zip",
                "zipPlugin",
                "tutor",
                "rplugin",
                "syntax",
                "synmenu",
                "optwin",
                "compiler",
                "bugreport",
                -- "ftplugin",
            },
        },
    },
})

local icons = require("config.icons")
for hl, icon in pairs({ Error = icons.diagnostics.error, Warn = icons.diagnostics.warning, Hint = icons.diagnostics.hint, Info =
    icons.diagnostics.information }) do
    hl = "DiagnosticSign" .. hl
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
for hl, icon in pairs({ Breakpoint = icons.dap.breakpoint, Stopped = icons.dap.stopped }) do
    hl = "Dap" .. hl
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.api.nvim_create_autocmd("UIEnter", {
    callback = function()
        require("config.keymaps").init()
        -- require("config.hooks")
    end,
})

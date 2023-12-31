vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.colorscheme = "catppuccin_latte"
vim.g.shell = "/home/daniel/.cargo/bin/nu"

vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undo"
vim.opt.undofile = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
--vim.opt.scrolloff = 40
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.mouse=""

vim.opt.exrc = true
vim.opt.secure = true


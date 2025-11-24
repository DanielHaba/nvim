vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.colorscheme = "catppuccin-latte"
vim.g.shell = os.getenv("HOME") .. "/.cargo/bin/nu"
vim.g.foldlevelstart = 99
-- vim.g.winborder = "bold"
-- vim.g.winborder = "▛,▀,▜,▐,▟,▄,▙,▌"

-- vim.g.winborder = "▛,▀,▜,▐,▟,▄,▙,▌"

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

-- vim.opt.winborder = "▛,▀,▜,▐,▟,▄,▙,▌"
-- vim.opt.winborder = "solid"
-- vim.opt.winborder = "12345678"
-- vim.o.winborder='+,-,+,|,+,-,+,|'
vim.o.winborder = "none"
vim.g.catppuccin_debug = true

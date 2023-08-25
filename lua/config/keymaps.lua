local mappings = {}

mappings.common = {
    {
        desc = "Exit insert mode",
        mode = "t",
        opts = { silent = true },
        "<ESC>",
        "<C-\\><C-n>",
    },
    {
        desc = "Switch window",
        mode = { "n", "t" },
        opts = { silent = true, remap = false },
        "<C-Tab>",
        "<C-w>w",
    },
    {
        desc = "Switch window",
        mode = "t",
        opts = { silent = true, remap = false },
        "<C-w>w",
        "<C-\\><C-n><C-w>w",
    },
    {
        desc = "Open terminal",
        mode = "n",
        opts = { silent = true, remap = false },
        "<C-\\>",
        "<Cmd>terminal<CR>i",
    },
    {
        desc = "Scroll down",
        mode = "n",
        opts = { silent = true, remap = false },
        "<C-d>",
        "<Cmd>set so=999<CR><C-d><Cmd>set so=0<CR>",
    },
    {
        desc = "Scroll up",
        mode = "n",
        opts = { silent = true, remap = false },
        "<C-u>",
        "<Cmd>set so=999<CR><C-u><Cmd>set so=0<CR>",
    },
    {
        desc = "Save",
        mode = "n",
        opts = { silent = true },
        "<C-s>",
        "<Cmd>w<CR>",
    },
    {
        desc = "Close",
        mode = "n",
        opts = { silent = true },
        "<C-q>",
        "<Cmd>bd<CR>",
    },
    {
        desc = "Close",
        mode = "t",
        opts = { silent = true },
        "<C-q>",
        "<Cmd>bd!<CR>",
    },
    {
        desc = "Move to left window",
        mode = { "n", "t" },
        opts = { silent = true },
        "<C-h>",
        "<C-w>h",
    },
    {
        desc = "Split to left",
        mode = { "n", "t" },
        opts = { silent = true },
        "<Leader>sh",
        "<Cmd>set nosplitright<CR><Cmd>vsplit<CR>",
    },
    {
        desc = "Move to right window",
        mode = { "n", "t" },
        opts = { silent = true },
        "<C-l>",
        "<C-w>l",
    },
    {
        desc = "Split to right",
        mode = { "n", "t" },
        opts = { silent = true },
        "<Leader>sl",
        "<Cmd>set splitright<CR><Cmd>vsplit<CR>",
    },
    {
        desc = "Move to down window",
        mode = { "n", "t" },
        opts = { silent = true },
        "<C-j>",
        "<C-w>j",
    },
    {
        desc = "Split to down",
        mode = { "n", "t" },
        opts = { silent = true },
        "<Leader>sj",
        "<Cmd>set splitbelow<CR><Cmd>split<CR>",
    },
    {
        desc = "Move to up window",
        mode = { "n", "t" },
        opts = { silent = true },
        "<C-k>",
        "<C-w>k",
    },
    {
        desc = "Split to up",
        mode = { "n", "t" },
        opts = { silent = true },
        "<Leader>sk",
        "<Cmd>set nosplitbelow<CR><Cmd>split<CR>",
    },
}

mappings.lsp = {
    {
        desc = "Go to declaration",
        mode = "n",
        "gD",
        function() vim.lsp.buf.declaration() end,
    },
    {
        desc = "Go to definition",
        mode = "n",
        "gd",
        function() vim.lsp.buf.definition() end,
    },
    {
        desc = "Go to implementation",
        mode = "n",
        "gI",
        function() vim.lsp.buf.implementation() end,
    },
    {
        desc = "Go to references",
        mode = "n",
        "gr",
        function() vim.lsp.buf.references() end,
    },
    {
        desc = "Rename",
        mode = "n",
        "<Leader>rn",
        function() vim.lsp.buf.rename() end,
    },
    {
        desc = "Documentation",
        mode = "n",
        "K",
        function() vim.lsp.buf.hover() end,
    },
    {
        desc = "Reformat",
        mode = "n",
        "<Leader>rf",
        function() vim.lsp.buf.format({ async = true }) end,
    },
    {
        desc = "Code action",
        mode = { "n", "v" },
        "<Leader>ra",
        function() vim.lsp.buf.code_action() end,
    },
    {
        desc = "Next diagnostics",
        mode = "n",
        "]d",
        function() vim.diagnostic.goto_next() end,
    },
    {
        desc = "Previous diagnostics",
        mode = "n",
        "[d",
        function() vim.diagnostic.goto_prev() end,
    },
}

mappings.telescope = {
    {
        desc = "Find files",
        mode = "n",
        opts = { silent = true },
        "<Leader>ff",
        ":Telescope find_files<CR>",
    },
    {
        desc = "Grep files",
        mode = "n",
        opts = { silent = true },
        "<Leader>fg",
        ":Telescope live_grep<CR>",
    },
    {
        desc = "Buffers",
        mode = "n",
        opts = { silent = true },
        "<Leader>fb",
        ":Telescope buffers<CR>",
    },
}

mappings.trouble = {
    {
        desc = "Trouble toggle",
        mode = "n",
        opts = { silent = true },
        "<Leader>tt",
        ":TroubleToggle<CR>",
    },
}

mappings.noice = {
    {
        desc = "Redirect output",
        mode = "c",
        "<S-Enter>",
        function()
            require("noice").redirect(vim.fn.getcmdline())
        end,
    },
}

mappings.neotree = {
    {
        desc = "Toggle tree",
        mode = "n",
        opts = { silent = true },
        "<C-n>",
        "<Cmd>Neotree toggle<CR>",
    },
}

local M = {}

function M.setup(name, opts)
    opts = opts or {}
    local keymaps = mappings[name] or {}

    for _, keymap in ipairs(keymaps) do
        local mode = keymap.mode or "n"
        local o = vim.tbl_extend("force", keymap.opts or {}, opts)

        vim.keymap.set(mode, keymap[1], keymap[2], o)
    end
end

function M.init()
    M.setup("common")
end

return M

local mappings = {}

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
        function() vim.lsp.buf.diagnostics.goto_next() end,
    },
    {
        desc = "Previous diagnostics",
        mode = "n",
        "[d",
        function() vim.lsp.buf.diagnostics.goto_prev() end,
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

return M

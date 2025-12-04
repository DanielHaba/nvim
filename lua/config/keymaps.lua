return {
    general = {
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
            desc = "Undo tree",
            mode = { "n" },
            opts = { silent = true },
            "<Leader>u",
            "<Cmd>UndotreeToggle<CR>",
        },
        ----------------------------------------- FOCUS WINDOW -------------------------------------------
        {
            desc = "Focus left",
            mode = { "n", "t" },
            opts = { silent = true },
            "<C-h>",
            "<C-w>h",
        },
        {
            desc = "Focus right",
            mode = { "n", "t" },
            opts = { silent = true },
            "<C-l>",
            "<C-w>l",
        },
        {
            desc = "Focus down",
            mode = { "n", "t" },
            opts = { silent = true },
            "<C-j>",
            "<C-w>j",
        },
        {
            desc = "Focus up",
            mode = { "n", "t" },
            opts = { silent = true },
            "<C-k>",
            "<C-w>k",
        },
        ----------------------------------------- RESIZE WINDOW -------------------------------------------
        {
            desc = "Shrink horizontal",
            mode = { "n", "t" },
            opts = { silent = true, expr = true, replace_keycodes = false },
            "<C-Left>",
            '"<Cmd>vertical resize -" . v:count1 ."<CR>"',
        },
        {
            desc = "Grow horizontal",
            mode = { "n", "t" },
            opts = { silent = true, expr = true, replace_keycodes = false },
            "<C-Right>",
            '"<Cmd>vertical resize +" . v:count1 ."<CR>"',
        },
        {
            desc = "Shrink vertical",
            mode = { "n", "t" },
            opts = { silent = true, expr = true, replace_keycodes = false },
            "<C-Down>",
            '"<Cmd>resize -" . v:count1 ."<CR>"',
        },
        {
            desc = "Grow vertical",
            mode = { "n", "t" },
            opts = { silent = true, expr = true, replace_keycodes = false },
            "<C-Up>",
            '"<Cmd>resize +" . v:count1 ."<CR>"',
        },
        ----------------------------------------- SPLITS -------------------------------------------
        {
            desc = "Split to up",
            mode = { "n", "t" },
            opts = { silent = true },
            "<Leader>sk",
            "<Cmd>set nosplitbelow<CR><Cmd>split<CR>",
        },
        {
            desc = "Split to down",
            mode = { "n", "t" },
            opts = { silent = true },
            "<Leader>sj",
            "<Cmd>set splitbelow<CR><Cmd>split<CR>",
        },
        {
            desc = "Split to left",
            mode = { "n", "t" },
            opts = { silent = true },
            "<Leader>sh",
            "<Cmd>set nosplitright<CR><Cmd>vsplit<CR>",
        },
        {
            desc = "Split to right",
            mode = { "n", "t" },
            opts = { silent = true },
            "<Leader>sl",
            "<Cmd>set splitright<CR><Cmd>vsplit<CR>",
        },


    },

    lsp = {
        {
            desc = "Go to declaration",
            mode = "n",
            "gD",
            -- function() vim.lsp.buf.declaration() end,
            function() require("telescope.builtin").lsp_type_definitions() end,
        },
        {
            desc = "Go to definition",
            mode = "n",
            "gd",
            -- function() vim.lsp.buf.definition() end,
            function() require("telescope.builtin").lsp_definitions() end,
        },
        {
            desc = "Go to implementation",
            mode = "n",
            "gI",
            -- function() vim.lsp.buf.implementation() end,
            function() require("telescope.builtin").lsp_implementations() end,
        },
        {
            desc = "Go to references",
            mode = "n",
            "gr",
            -- function() vim.lsp.buf.references() end,
            function() require("telescope.builtin").lsp_references() end,
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
            desc = "Code lens run",
            mode = "n",
            "<Leader>rr",
            function() vim.lsp.codelens.run() end,
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
        {
            desc = "Toggle diagnostics",
            mode = "n",
            "<Leader>dd",
            function()
                if vim.diagnostic.config().virtual_lines then
                    vim.diagnostic.config({ virtual_lines = false })
                else
                    vim.diagnostic.config({ virtual_lines = { current_line = true } })
                end
            end,
        },
    },

    telescope = {
        {
            desc = "Find files",
            mode = "n",
            opts = { silent = true },
            "<Leader>ff",
            "<Cmd>Telescope find_files<CR>",
        },
        {
            desc = "Grep files",
            mode = "n",
            opts = { silent = true },
            "<Leader>fg",
            "<Cmd>Telescope live_grep<CR>",
        },
        {
            desc = "Buffers",
            mode = "n",
            opts = { silent = true },
            "<Leader>fb",
            "<Cmd>Telescope buffers<CR>",
        },
        {
            desc = "Resume",
            mode = "n",
            opts = { silent = true },
            "<Leader>fr",
            "<Cmd>Telescope resume<CR>",
        },
        {
            desc = "Noice",
            mode = "n",
            opts = { silent = true },
            "<Leader>fn",
            "<Cmd>Noice telescope<CR>",
        },
        {
            desc = "Search tags",
            mode = "n",
            opts = { silent = true },
            "<Leader>fot",
            "<Cmd>Noice orgmode search_tags",
        },
        {
            desc = "Search headings",
            mode = "n",
            opts = { silent = true },
            "<Leader>foh",
            "<Cmd>Noice orgmode search_headings",
        },
    },

    noice = {
        {
            desc = "Redirect output",
            mode = "c",
            "<S-Enter>",
            function()
                require("noice").redirect(vim.fn.getcmdline())
            end,
        },
    },

    neotree = {
        {
            desc = "Reveal tree",
            mode = "n",
            opts = { silent = true },
            "<C-n>",
            "<Cmd>Neotree toggle reveal<CR>",
        },
    },

    dap = {
        {
            desc = "Toggle breakpoint",
            mode = "n",
            "<Leader>b",
            function()
                require("dap").toggle_breakpoint()
            end,
        },
    },

    dap_session = {

        {
            desc = "Continue",
            mode = "n",
            "<F6>",
            function()
                require("dap").continue()
            end,
        },
        {
            desc = "Step over",
            mode = "n",
            "<F7>",
            function()
                require("dap").step_over()
            end,
        },
        {
            desc = "Step into",
            mode = "n",
            "<F8>",
            function()
                require("dap").step_into()
            end,
        },
        {
            desc = "Step out",
            mode = "n",
            "<F9>",
            function()
                require("dap").step_out()
            end,
        },
        {
            desc = "Terminate",
            mode = "n",
            "<F10>",
            function()
                require("dap").terminate()
            end,
        },
    },

    whichkey = {
        {
            desc = "Which key",
            mode = "n",
            "<Leader>?",
            function()
                require("which-key").show({ 
                    global = true, 
                    loop = true,
                })
            end,
        },
    },

    trouble = {

        {
            "<leader>xx",
            "<cmd>Trouble diagnostics toggle<cr>",
            desc = "Diagnostics (Trouble)",
        },
        {
            "<leader>xX",
            "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
            desc = "Buffer Diagnostics (Trouble)",
        },
        {
            "<leader>cs",
            "<cmd>Trouble symbols toggle focus=false<cr>",
            desc = "Symbols (Trouble)",
        },
        {
            "<leader>cl",
            "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
            desc = "LSP Definitions / references / ... (Trouble)",
        },
        {
            "<leader>xL",
            "<cmd>Trouble loclist toggle<cr>",
            desc = "Location List (Trouble)",
        },
        {
            "<leader>xQ",
            "<cmd>Trouble qflist toggle<cr>",
            desc = "Quickfix List (Trouble)",
        },
    },

    markview = {
        {
            mode = "n",
            desc = "Toggle `markview` previews",
            "<Leader>m",
            "<Cmd>Markview<CR>",
        },
    },

    neogit = {
        {
            mode = "n",
            desc = "Open NeoGit",
            "<Leader>gg",
            "<Cmd>Neogit<CR>",
        },
    },

    harpoon = {
        {
            mode = "n",
            desc = "Harpoon add",
            "<Leader>a",
            function() require("harpoon"):list():add() end,
        },
        {
            mode = "n",
            desc = "Harpoon quick menu",
            "<C-e>",
            function()
                local harpoon = require("harpoon")
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end,
        },
        {
            mode = "n",
            desc = "Harpoon next",
            "<C-[>",
            function() require("harpoon"):list():prev() end,
        },
        {
            mode = "n",
            desc = "Harpoon previous",
            "<C-]>",
            function() require("harpoon"):list():next() end,
        },

        {
            mode = "n",
            desc = "Harpoon jump 1",
            "<C-1>",
            function() require("harpoon"):list():select(1) end,
        },
        {
            mode = "n",
            desc = "Harpoon jump 2",
            "<C-2>",
            function() require("harpoon"):list():select(2) end,
        },
        {
            mode = "n",
            desc = "Harpoon jump 3",
            "<C-3>",
            function() require("harpoon"):list():select(3) end,
        },
        {
            mode = "n",
            desc = "Harpoon jump 4",
            "<C-4>",
            function() require("harpoon"):list():select(4) end,
        },
        {
            mode = "n",
            desc = "Harpoon jump 5",
            "<C-5>",
            function() require("harpoon"):list():select(5) end,
        },
        {
            mode = "n",
            desc = "Harpoon jump 6",
            "<C-6>",
            function() require("harpoon"):list():select(6) end,
        },
        {
            mode = "n",
            desc = "Harpoon jump 7",
            "<C-7>",
            function() require("harpoon"):list():select(7) end,
        },
        {
            mode = "n",
            desc = "Harpoon jump 8",
            "<C-8>",
            function() require("harpoon"):list():select(8) end,
        },
        {
            mode = "n",
            desc = "Harpoon jump 9",
            "<C-9>",
            function() require("harpoon"):list():select(9) end,
        },
        {
            mode = "n",
            desc = "Harpoon jump 10",
            "<C-0>",
            function() require("harpoon"):list():select(10) end,
        },
    },

    overseer = {
        {
            mode = "n",
            desc = "Overseer run",
            "<Leader>er",
            "<Cmd>OverseerRun<CR>",
        },
        {
            mode = "n",
            desc = "Overseer Toggle",
            "<Leader>eo",
            "<Cmd>OverseerToggle<CR>",
        },
        {
            mode = "n",
            desc = "Overseer Tasks",
            "<Leader>et",
            "<Cmd>OverseerTaskAction<CR>",
        },
    },

    orgmode = {
        filetypes = { "org" },
        {
            mode = "i",
            desc = "Meta return",
            opts = { silent = true },
            "<S-CR>",
            function()
                require("orgmode").action("org_mappings.meta_return")
            end,
        },
    },
}

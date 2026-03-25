return {
	image = { enabled = true },

	toggle = {
		enabled = true,
		map = vim.keymap.set,
		which_key = true,
		notify = true,
	},

	statuscolumn = {
		enabled = false,
		left = { "git" },
		right = { "sign" },
		folds = { open = false, git_hl = true },
		git = { patterns = { "GitSign" } },
	},

	-- input = { enabled = true },
	-- rename = { enabled = true },

	dashboard = {
		enabled = true,  -- To wystarczy - autocmd jest tworzony automatycznie
		preset = {
			keys = {
				{ icon = " ", key = "f", desc = "Find File", action = ":Telescope find_files" },
				{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
				{ icon = " ", key = "g", desc = "Find Text", action = ":Telescope live_grep" },
				{ icon = " ", key = "r", desc = "Recent Files", action = ":Telescope oldfiles" },
				{ icon = " ", key = "c", desc = "Config", action = ":lua require('telescope.builtin').find_files({ cwd = vim.fn.stdpath('config') })" },
				{ icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
				{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
			},
		},
	},
}

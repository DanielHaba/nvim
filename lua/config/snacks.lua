return {
	image = { eanbled = true },

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
}

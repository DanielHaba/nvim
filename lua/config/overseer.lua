return {
	task_list = {
		direction = "right",
        max_width = { 100, 0.2 },
        min_width = { 80, 0.1 },

		keymaps = {
			["?"] = "keymap.show_help",
			["g?"] = "keymap.show_help",
			["<CR>"] = "keymap.run_action",
			["dd"] = { "keymap.run_action", opts = { action = "dispose" }, desc = "Dispose task" },
			["<C-e>"] = { "keymap.run_action", opts = { action = "edit" }, desc = "Edit task" },
			["o"] = "keymap.open",
			["<C-v>"] = { "keymap.open", opts = { dir = "vsplit" }, desc = "Open task output in vsplit" },
			["<C-s>"] = { "keymap.open", opts = { dir = "split" }, desc = "Open task output in split" },
			["<C-t>"] = { "keymap.open", opts = { dir = "tab" }, desc = "Open task output in tab" },
			["<C-f>"] = { "keymap.open", opts = { dir = "float" }, desc = "Open task output in float" },
			["<C-r>"] = {
				"keymap.run_action",
				opts = { action = "open output in quickfix" },
				desc = "Open task output in the quickfix",
			},
			["p"] = "keymap.toggle_preview",
			["{"] = "keymap.prev_task",
			["}"] = "keymap.next_task",
			["<C-k>"] = "keymap.scroll_output_up",
			["<C-j>"] = "keymap.scroll_output_down",
			["g."] = "keymap.toggle_show_wrapped",
			["<C-q>"] = { "<CMD>close<CR>", desc = "Close task list" },
		},
	},
}

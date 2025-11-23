local miniclue = require("mini.clue")
local miniai = require('mini.ai')
local ministatusline = require("mini.statusline")



return {
    -- ai = {
    --     -- Table with textobject id as fields, textobject specification as values.
    --     -- Also use this to disable builtin textobjects. See |MiniAi.config|.
    --     custom_textobjects = {
    --         f = miniai.gen_spec.treesitter({
    --             a = "@function.outer",
    --             i = "@function.inner",
    --         }),
    --         t = miniai.gen_spec.treesitter({
    --             a = "@class.outer",
    --             i = "@class.inner",
    --         }),
    --         d = miniai.gen_spec.treesitter({
    --             a = "@condition.outer",
    --             i = "@condition.inner",
    --         }),
    --         l = miniai.gen_spec.treesitter({
    --             a = "@loop.outer",
    --             i = "@loop.inner",
    --         }),
    --         c = miniai.gen_spec.treesitter({
    --             a = "@comment.outer",
    --             i = "@comment.inner",
    --         }),
    --         p = miniai.gen_spec.treesitter({
    --             a = "@parameter.outer",
    --             i = "@parameter.inner",
    --         }),
    --         e = miniai.gen_spec.treesitter({
    --             a = "@block.outer",
    --             i = "@block.inner",
    --         }),
    --         m = miniai.gen_spec.treesitter({
    --             a = "@call.outer",
    --             i = "@call.inner",
    --         }),
    --         r = miniai.gen_spec.treesitter({
    --             a = "@return.outer",
    --             i = "@return.inner",
    --         }),
    --         P = miniai.gen_spec.treesitter({
    --             a = "@pipeline.outer",
    --             i = "@pipeline.inner",
    --         }),
    --     },
    --
    --     -- Module mappings. Use `""` (empty string) to disable one.
    --     mappings = {
    --         -- -- Main textobject prefixes
    --         -- around = "a",
    --         -- inside = "i",
    --         --
    --         -- -- Next/last variants
    --         -- -- NOTE: These override built-in LSP selection mappings on Neovim>=0.12
    --         -- -- Map LSP selection manually to use it (see `:h MiniAi.config`)
    --         -- around_next = "an",
    --         -- inside_next = "in",
    --         -- around_last = "al",
    --         -- inside_last = "il",
    --         --
    --         -- -- Move cursor to corresponding edge of `a` textobject
    --         -- goto_left = "g[",
    --         -- goto_right = "g]",
    --
    --         -- Main textobject prefixes
    --         around = "a",
    --         inside = "i",
    --
    --         -- Next/last variants
    --         -- NOTE: These override built-in LSP selection mappings on Neovim>=0.12
    --         -- Map LSP selection manually to use it (see `:h MiniAi.config`)
    --         around_next = "",
    --         inside_next = "",
    --         around_last = "",
    --         inside_last = "",
    --
    --         -- Move cursor to corresponding edge of `a` textobject
    --         goto_left = "g]",
    --         goto_right = "g[",
    --     },
    --
    --     -- Number of lines within which textobject is searched
    --     n_lines = 200,
    --
    --     -- How to search for object (first inside current line, then inside
    --     -- neighborhood). One of "cover", "cover_or_next", "cover_or_prev",
    --     -- "cover_or_nearest", "next", "previous", "nearest".
    --     search_method = "cover",
    --
    --     -- Whether to disable showing non-error feedback
    --     -- This also affects (purely informational) helper messages shown after
    --     -- idle time if user input is required.
    --     silent = false,
    -- },
    -- base16 = {
    --
    --     -- Table with names from `base00` to `base0F` and values being strings of
    --     -- HEX colors with format "#RRGGBB". NOTE: this should be explicitly
    --     -- supplied in `setup()`.
    --     palette = {
    --         base00 = "#eff1f5", -- base
    --         base01 = "#e6e9ef", -- mantle
    --         base02 = "#ccd0da", -- surface0
    --         base03 = "#bcc0cc", -- surface1
    --         base04 = "#acb0be", -- surface2
    --         base05 = "#4c4f69", -- text
    --         base06 = "#dc8a78", -- rosewater
    --         base07 = "#7287fd", -- lavender
    --         base08 = "#d20f39", -- red
    --         base09 = "#fe640b", -- peach
    --         base0A = "#df8e1d", -- yellow
    --         base0B = "#40a02b", -- green
    --         base0C = "#179299", -- teal
    --         base0D = "#1e66f5", -- blue
    --         base0E = "#8839ef", -- mauve
    --         base0F = "#dd7878", -- flamingo
    --     },
    --
    --
    --     -- Whether to support cterm colors. Can be boolean, `nil` (same as
    --     -- `false`), or table with cterm colors. See `setup()` documentation for
    --     -- more information.
    --     use_cterm = nil,
    --
    --     -- Plugin integrations. Use `default = false` to disable all integrations.
    --     -- Also can be set per plugin (see |MiniBase16.config|).
    --     plugins = { default = true },
    -- },
    basics = {
        -- Options. Set field to `false` to disable.
        options = {
            -- Basic options ("number", "ignorecase", and many more)
            basic = false,

            -- Extra UI features ("winblend", "listchars", "pumheight", ...)
            extra_ui = false,

            -- Presets for window borders ("single", "double", ...)
            -- Default "auto" infers from "winborder" option
            -- win_borders = style.window.border,
        },

        -- Mappings. Set field to `false` to disable.
        mappings = {
            -- Basic mappings (better "jk", save with Ctrl+S, ...)
            basic = true,

            -- Prefix for mappings that toggle common options ("wrap", "spell", ...).
            -- Supply empty string to not create these mappings.
            option_toggle_prefix = [[\]],

            -- Window navigation with <C-hjkl>, resize with <C-arrow>
            windows = true,

            -- Move cursor in Insert, Command, and Terminal mode with <M-hjkl>
            move_with_alt = false,
        },

        -- Autocommands. Set field to `false` to disable
        autocommands = {
            -- Basic autocommands (highlight on yank, start Insert in terminal, ...)
            basic = true,

            -- Set "relativenumber" only in linewise and blockwise Visual mode
            relnum_in_visual_mode = false,
        },

        -- Whether to disable showing non-error feedback
        silent = false,
    },
    -- clue = {
    --     -- Array of extra clues to show
    --     clues = {
    --         -- Enhance this by adding descriptions for <Leader> mapping groups
    --         -- miniclue.gen_clues.square_brackets(),
    --         miniclue.gen_clues.builtin_completion(),
    --         miniclue.gen_clues.g(),
    --         miniclue.gen_clues.marks(),
    --         miniclue.gen_clues.registers({ show_contents = true }),
    --         miniclue.gen_clues.windows(),
    --         miniclue.gen_clues.z(),
    --     },
    --
    --     -- Array of opt-in triggers which start custom key query process.
    --     -- **Needs to have something in order to show clues**.
    --     triggers = {
    --         -- Leader triggers
    --         { mode = "n", keys = "<Leader>" },
    --         { mode = "x", keys = "<Leader>" },
    --
    --         -- Square brackets
    --         { mode = "n", keys = "[" },
    --         { mode = "n", keys = "]" },
    --
    --         -- Selections
    --         { mode = "v", keys = "a" },
    --         { mode = "v", keys = "i" },
    --
    --         -- Built-in completion
    --         { mode = "i", keys = "<C-x>" },
    --
    --         -- `g` key
    --         { mode = "n", keys = "g" },
    --         { mode = "x", keys = "g" },
    --
    --         -- Marks
    --         { mode = "n", keys = "\"" },
    --         { mode = "n", keys = "`" },
    --         { mode = "x", keys = "\"" },
    --         { mode = "x", keys = "`" },
    --
    --         -- Registers
    --         { mode = "n", keys = "\"" },
    --         { mode = "x", keys = "\"" },
    --         { mode = "i", keys = "<C-r>" },
    --         { mode = "c", keys = "<C-r>" },
    --
    --         -- Window commands
    --         { mode = "n", keys = "<C-w>" },
    --
    --         -- `z` key
    --         { mode = "n", keys = "z" },
    --         { mode = "x", keys = "z" },
    --     },
    --
    --     -- Clue window settings
    --     window = {
    --         -- Floating window config
    --         config = {
    --             border = style.window.border,
    --         },
    --
    --         -- Delay before showing clue window
    --         delay = 1000,
    --
    --         -- Keys to scroll inside the clue window
    --         scroll_down = "<C-d>",
    --         scroll_up = "<C-u>",
    --     },
    -- },
    colors = {},
    comment = {
        -- Options which control module behavior
        options = {
            -- Function to compute custom "commentstring" (optional)
            custom_commentstring = nil,

            -- Whether to ignore blank lines when commenting
            ignore_blank_line = false,

            -- Whether to ignore blank lines in actions and textobject
            start_of_line = false,

            -- Whether to force single space inner padding for comment parts
            pad_comment_parts = true,
        },

        -- Module mappings. Use `""` (empty string) to disable one.
        mappings = {
            -- Toggle comment (like `gcip` - comment inner paragraph) for both
            -- Normal and Visual modes
            comment = "gc",

            -- Toggle comment on current line
            comment_line = "gcc",

            -- Toggle comment on visual selection
            comment_visual = "gc",

            -- Define "comment" textobject (like `dgc` - delete whole comment block)
            -- Works also in Visual mode if mapping differs from `comment_visual`
            textobject = "gc",
        },

        -- Hook functions to be executed at certain stage of commenting
        hooks = {
            -- Before successful commenting. Does nothing by default.
            pre = function() end,
            -- After successful commenting. Does nothing by default.
            post = function() end,
        },
    },
    -- completion = {
    --     -- Delay (debounce type, in ms) between certain Neovim event and action.
    --     -- This can be used to (virtually) disable certain automatic actions by
    --     -- setting very high delay time (like 10^7).
    --     delay = { completion = 100, info = 100, signature = 50 },
    --
    --     -- Configuration for action windows:
    --     -- - `height` and `width` are maximum dimensions.
    --     -- - `border` defines border (as in `nvim_open_win()`; default "single").
    --     window = {
    --         info = { height = 25, width = 80, border = style.window.border },
    --         signature = { height = 25, width = 80, border = style.window.border },
    --     },
    --
    --     -- Way of how module does LSP completion
    --     lsp_completion = {
    --         -- `source_func` should be one of "completefunc" or "omnifunc".
    --         source_func = "completefunc",
    --
    --         -- `auto_setup` should be boolean indicating if LSP completion is set up
    --         -- on every `BufEnter` event.
    --         auto_setup = true,
    --
    --         -- A function which takes LSP "textDocument/completion" response items
    --         -- (each with `client_id` field for item"s server) and word to complete.
    --         -- Output should be a table of the same nature as input. Common use case
    --         -- is custom filter/sort. Default: `default_process_items`
    --         process_items = nil,
    --
    --         -- A function which takes a snippet as string and inserts it at cursor.
    --         -- Default: `default_snippet_insert` which tries to use "mini.snippets"
    --         -- and falls back to `vim.snippet.expand` (on Neovim>=0.10).
    --         snippet_insert = nil,
    --     },
    --
    --     -- Fallback action as function/string. Executed in Insert mode.
    --     -- To use built-in completion (`:h ins-completion`), set its mapping as
    --     -- string. Example: set "<C-x><C-l>" for "whole lines" completion.
    --     fallback_action = "<C-n>",
    --
    --     -- Module mappings. Use `""` (empty string) to disable one. Some of them
    --     -- might conflict with system mappings.
    --     mappings = {
    --         -- Force two-step/fallback completions
    --         force_twostep = "<C-Space>",
    --         force_fallback = "<A-Space>",
    --
    --         -- Scroll info/signature window down/up. When overriding, check for
    --         -- conflicts with built-in keys for popup menu (like `<C-u>`/`<C-o>`
    --         -- for "completefunc"/"omnifunc" source function; or `<C-n>`/`<C-p>`).
    --         scroll_down = "<C-f>",
    --         scroll_up = "<C-b>",
    --     },
    -- },
    cursorword = {
        -- Delay (in ms) between when cursor moved and when highlighting appeared
        delay = 100,
    },
    diff = {
        -- Options for how hunks are visualized
        view = {
            -- Visualization style. Possible values are "sign" and "number".
            -- Default: "number" if line numbers are enabled, "sign" otherwise.
            style = vim.go.number and "number" or "sign",

            -- Signs used for hunks with "sign" view
            signs = { add = "▒", change = "▒", delete = "▒" },

            -- Priority of used visualization extmarks
            priority = 199,
        },

        -- Source(s) for how reference text is computed/updated/etc
        -- Uses content from Git index by default
        source = nil,

        -- Delays (in ms) defining asynchronous processes
        delay = {
            -- How much to wait before update following every text change
            text_change = 200,
        },

        -- Module mappings. Use `""` (empty string) to disable one.
        mappings = {
            -- Apply hunks inside a visual/operator region
            apply = "gh",

            -- Reset hunks inside a visual/operator region
            reset = "gH",

            -- Hunk range textobject to be used inside operator
            -- Works also in Visual mode if mapping differs from apply and reset
            textobject = "gh",

            -- Go to hunk range in corresponding direction
            goto_first = "[H",
            goto_prev = "[h",
            goto_next = "]h",
            goto_last = "]H",
        },

        -- Various options
        options = {
            -- Diff algorithm. See `:h vim.diff()`.
            algorithm = "histogram",

            -- Whether to use "indent heuristic". See `:h vim.diff()`.
            indent_heuristic = true,

            -- The amount of second-stage diff to align lines
            linematch = 60,

            -- Whether to wrap around edges during hunk navigation
            wrap_goto = false,
        },
    },
    git = {
        -- General CLI execution
        job = {
            -- Path to Git executable
            git_executable = "git",

            -- Timeout (in ms) for each job before force quit
            timeout = 30000,
        },

        -- Options for `:Git` command
        command = {
            -- Default split direction
            split = "auto",
        },
    },
    hipatterns = {
        -- Table with highlighters (see |MiniHipatterns.config| for more details).
        -- Nothing is defined by default. Add manually for visible effect.
        highlighters = {},

        -- Delays (in ms) defining asynchronous highlighting process
        delay = {
            -- How much to wait for update after every text change
            text_change = 200,

            -- How much to wait for update after window scroll
            scroll = 50,
        },

    },
    icons = {
        -- Icon style: "glyph" or "ascii"
        style              = "glyph",

        -- Customize per category. See `:h MiniIcons.config` for details.
        default            = {},
        directory          = {},
        extension          = {},
        file               = {},
        filetype           = {},
        lsp                = {},
        os                 = {},

        -- Control which extensions will be considered during "file" resolution
        use_file_extension = function(ext, file) return true end,
    },
    indentscope = {
        -- Draw options
        draw = {
            -- Delay (in ms) between event and start of drawing scope indicator
            delay = 100,

            -- Animation rule for scope"s first drawing. A function which, given
            -- next and total step numbers, returns wait time (in ms). See
            -- |MiniIndentscope.gen_animation| for builtin options. To disable
            -- animation, use `require("mini.indentscope").gen_animation.none()`.
            animation = require("mini.indentscope").gen_animation.none(),

            -- Whether to auto draw scope: return `true` to draw, `false` otherwise.
            -- Default draws only fully computed scope (see `options.n_lines`).
            predicate = function(scope) return not scope.body.is_incomplete end,

            -- Symbol priority. Increase to display on top of more symbols.
            priority = 2,
        },
        mappings = {
            -- Textobjects
            object_scope = "",
            object_scope_with_border = "",

            -- Motions (jump to respective border line; if not present - body line)
            goto_top = "",
            goto_bottom = "",
        },

        -- Options which control scope computation
        options = {
            -- Type of scope"s border: which line(s) with smaller indent to
            -- categorize as border. Can be one of: "both", "top", "bottom", "none".
            border = "both",

            -- Whether to use cursor column when computing reference indent.
            -- Useful to see incremental scopes with horizontal cursor movements.
            indent_at_cursor = true,

            -- Maximum number of lines above or below within which scope is computed
            n_lines = 10000,

            -- Whether to first check input line to be a border of adjacent scope.
            -- Use it if you want to place cursor on function header to get scope of
            -- its body.
            try_as_border = true,
        },

        -- Which character to use for drawing scope indicator
        symbol = "⸽",
    },
    -- jump = {
    --     -- Module mappings. Use `""` (empty string) to disable one.
    --     mappings = {
    --         forward = "f",
    --         backward = "F",
    --         forward_till = "t",
    --         backward_till = "T",
    --         repeat_jump = ";",
    --     },
    --
    --     -- Delay values (in ms) for different functionalities. Set any of them to
    --     -- a very big number (like 10^7) to virtually disable.
    --     delay = {
    --         -- Delay between jump and highlighting all possible jumps
    --         highlight = 250,
    --
    --         -- Delay between jump and automatic stop if idle (no jump is done)
    --         idle_stop = 10000000,
    --     },
    --
    --     -- Whether to disable showing non-error feedback
    --     -- This also affects (purely informational) helper messages shown after
    --     -- idle time if user input is required.
    --     silent = false,
    -- },
    move = {
        mappings = {
            -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
            left = "<A-h>",
            right = "<A-l>",
            down = "<A-j>",
            up = "<A-k>",

            -- Move current line in Normal mode
            line_left = "<A-h>",
            line_right = "<A-l>",
            line_down = "<A-j>",
            line_up = "<A-k>",
        },
    },
    -- notify = {
    --     -- Content management
    --     content = {
    --         -- Function which formats the notification message
    --         -- By default prepends message with notification time
    --         format = nil,
    --
    --         -- Function which orders notification array from most to least important
    --         -- By default orders first by level and then by update timestamp
    --         sort = nil,
    --     },
    --
    --     -- Notifications about LSP progress
    --     lsp_progress = {
    --         -- Whether to enable showing
    --         enable = true,
    --
    --         -- Notification level
    --         level = "INFO",
    --
    --         -- Duration (in ms) of how long last message should be shown
    --         duration_last = 1000,
    --     },
    --
    --     -- Window options
    --     window = {
    --         -- Floating window config
    --         config = { border = style.window.border },
    --
    --         -- Maximum window width as share (between 0 and 1) of available columns
    --         max_width_share = 0.382,
    --
    --         -- Value of "winblend" option
    --         winblend = 25,
    --     },
    -- },
    pairs = {
        -- In which modes mappings from this `config` should be created
        modes = { insert = true, command = false, terminal = false },

        -- Global mappings. Each right hand side should be a pair information, a
        -- table with at least these fields (see more in |MiniPairs.map|):
        -- - <action> - one of "open", "close", "closeopen".
        -- - <pair> - two character string for pair to be used.
        -- By default pair is not inserted after `\`, quotes are not recognized by
        -- <CR>, `"` does not insert pair after a letter.
        -- Only parts of tables can be tweaked (others will use these defaults).
        mappings = {
            ["("] = { action = "open", pair = "()", neigh_pattern = "[^\\]." },
            ["["] = { action = "open", pair = "[]", neigh_pattern = "[^\\]." },
            ["{"] = { action = "open", pair = "{}", neigh_pattern = "[^\\]." },

            [")"] = { action = "close", pair = "()", neigh_pattern = "[^\\]." },
            ["]"] = { action = "close", pair = "[]", neigh_pattern = "[^\\]." },
            ["}"] = { action = "close", pair = "{}", neigh_pattern = "[^\\]." },

            ["\""] = { action = "closeopen", pair = "\"\"", neigh_pattern = "[^\\].", register = { cr = false } },
            ["'"] = { action = "closeopen", pair = "\"\"", neigh_pattern = "[^%a\\].", register = { cr = false } },
            ["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^\\].", register = { cr = false } },
        },
    },
    snippets = {
        -- Array of snippets and loaders (see |MiniSnippets.config| for details).
        -- Nothing is defined by default. Add manually to have snippets to match.
        snippets = {},

        -- Module mappings. Use `""` (empty string) to disable one.
        mappings = {
            -- Expand snippet at cursor position. Created globally in Insert mode.
            expand = "<C-j>",

            -- Interact with default `expand.insert` session.
            -- Created for the duration of active session(s)
            jump_next = "<C-l>",
            jump_prev = "<C-h>",
            stop = "<C-c>",
        },

        -- Functions describing snippet expansion. If `nil`, default values
        -- are `MiniSnippets.default_<field>()`.
        expand = {
            -- Resolve raw config snippets at context
            prepare = nil,
            -- Match resolved snippets at cursor position
            match = nil,
            -- Possibly choose among matched snippets
            select = nil,
            -- Insert selected snippet
            insert = nil,
        },
    },
    starter = {
        -- Whether to open starter buffer on VimEnter. Not opened if Neovim was
        -- started with intent to show something else.
        autoopen = true,

        -- Whether to evaluate action of single active item
        evaluate_single = false,

        -- Items to be displayed. Should be an array with the following elements:
        -- - Item: table with <action>, <name>, and <section> keys.
        -- - Function: should return one of these three categories.
        -- - Array: elements of these three types (i.e. item, array, function).
        -- If `nil` (default), default items will be used (see |mini.starter|).
        items = nil,

        -- Header to be displayed before items. Converted to single string via
        -- `tostring` (use `\n` to display several lines). If function, it is
        -- evaluated first. If `nil` (default), polite greeting will be used.
        header = nil,

        -- Footer to be displayed after items. Converted to single string via
        -- `tostring` (use `\n` to display several lines). If function, it is
        -- evaluated first. If `nil` (default), default usage help will be shown.
        footer = nil,

        -- Array  of functions to be applied consecutively to initial content.
        -- Each function should take and return content for "Starter" buffer (see
        -- |mini.starter| and |MiniStarter.content| for more details).
        content_hooks = nil,

        -- Characters to update query. Each character will have special buffer
        -- mapping overriding your global ones. Be careful to not add `:` as it
        -- allows you to go into command mode.
        query_updaters = "abcdefghijklmnopqrstuvwxyz0123456789_-.",

        -- Whether to disable showing non-error feedback
        silent = false,
    },
    -- statusline = {
    --     -- Content of statusline as functions which return statusline string. See
    --     -- `:h statusline` and code of default contents (used instead of `nil`).
    --     content = {
    --         -- Content for active window
    --         active = require("utils.mini.statusline"),
    --         -- Content for inactive window(s)
    --         inactive = nil,
    --     },
    --
    --     -- Whether to use icons by default
    --     use_icons = true,
    -- },
    surround = {
        -- Add custom surroundings to be used on top of builtin ones. For more
        -- information with examples, see `:h MiniSurround.config`.
        custom_surroundings = nil,

        -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
        highlight_duration = 500,

        -- Module mappings. Use `""` (empty string) to disable one.
        mappings = {
            add = "ys",       -- Add surrounding in Normal and Visual modes
            delete = "ds",    -- Delete surrounding
            find = "",        -- Find surrounding (to the right)
            find_left = "",   -- Find surrounding (to the left)
            highlight = "",   -- Highlight surrounding
            replace = "cs",   -- Replace surrounding

            suffix_last = "", -- Suffix to search with "prev" method
            suffix_next = "", -- Suffix to search with "next" method
        },

        -- Number of lines within which surrounding is searched
        n_lines = 20,

        -- Whether to respect selection type:
        -- - Place surroundings on separate lines in linewise mode.
        -- - Place surroundings on each line in blockwise mode.
        respect_selection_type = false,

        -- How to search for surrounding (first inside current line, then inside
        -- neighborhood). One of "cover", "cover_or_next", "cover_or_prev",
        -- "cover_or_nearest", "next", "prev", "nearest". For more details,
        -- see `:h MiniSurround.config`.
        search_method = "cover",

        -- Whether to disable showing non-error feedback
        -- This also affects (purely informational) helper messages shown after
        -- idle time if user input is required.
        silent = false,
    },
    trailspace = {
        -- Highlight only in normal buffers (ones with empty "buftype"). This is
        -- useful to not show trailing whitespace where it usually doesn"t matter.
        only_in_normal_buffers = true,
    },
}

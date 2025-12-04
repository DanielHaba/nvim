return {
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
    cursorword = {
        -- Delay (in ms) between when cursor moved and when highlighting appeared
        delay = 100,
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

            ['"'] = { action = "closeopen", pair = '""', neigh_pattern = "[^\\].", register = { cr = false } },
            ["'"] = { action = "closeopen", pair = "''", neigh_pattern = "[^%a\\].", register = { cr = false } },
            ["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^\\].", register = { cr = false } },
        },
    },
    align = {

        -- Module mappings. Use `""` (empty string) to disable one.
        mappings = {
            start = "ga",
            start_with_preview = "gA",
        },

        -- Modifiers changing alignment steps and/or options
        modifiers = {
            -- -- Main option modifiers
            -- ["s"] = --<function: enter split pattern>,
            -- ["j"] = --<function: choose justify side>,
            -- ["m"] = --<function: enter merge delimiter>,
            --
            -- -- Modifiers adding pre-steps
            -- ["f"] = --<function: filter parts by entering Lua expression>,
            -- ["i"] = --<function: ignore some split matches>,
            -- ["p"] = --<function: pair parts>,
            -- ["t"] = --<function: trim parts>,
            --
            -- -- Delete some last pre-step
            -- ["<BS>"] = --<function: delete some last pre-step>,
            --
            -- -- Special configurations for common splits
            -- ["="] = --<function: enhanced setup for "=">,
            -- [","] = --<function: enhanced setup for ",">,
            -- ["|"] = --<function: enhanced setup for "|">,
            -- [" "] = --<function: enhanced setup for " ">,
        },

        -- Default options controlling alignment process
        options = {
            split_pattern = "",
            justify_side = "left",
            merge_delimiter = "",
        },

        -- Default steps performing alignment (if `nil`, default is used)
        steps = {
            pre_split = {},
            split = nil,
            pre_justify = {},
            justify = nil,
            pre_merge = {},
            merge = nil,
        },

        -- Whether to disable showing non-error feedback
        -- This also affects (purely informational) helper messages shown after
        -- idle time if user input is required.
        silent = false,
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
    bufremove = {
        -- Whether to disable showing non-error feedback
        silent = true,
    },
}

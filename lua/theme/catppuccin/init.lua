local lush      = require("lush")
local hsl       = lush.hsl
local rgb       = require("lush.vivid.rgb.convert")

local rosewater = hsl("#dc8a78")
local flamingo  = hsl("#dd7878")
local pink      = hsl("#ea76cb")
local mauve     = hsl("#8839ef")
local red       = hsl("#d20f39")
local maroon    = hsl("#e64553")
local peach     = hsl("#fe640b")
local yellow    = hsl("#df8e1d")
local green     = hsl("#40a02b")
local teal      = hsl("#179299")
local sky       = hsl("#04a5e5")
local sapphire  = hsl("#209fb5")
local blue      = hsl("#1e66f5")
local lavender  = hsl("#7287fd")
local text      = hsl("#4c4f69")
local subtext1  = hsl("#5c5f77")
local subtext0  = hsl("#6c6f85")
local overlay2  = hsl("#7c7f93")
local overlay1  = hsl("#8c8fa1")
local overlay0  = hsl("#9ca0b0")
local surface2  = hsl("#acb0be")
local surface1  = hsl("#bcc0cc")
local surface0  = hsl("#ccd0da")
local base      = hsl("#eff1f5")
local mantle    = hsl("#e6e9ef")
local crust     = hsl("#dce0e8")

local function blend(color, base, factor)
    local f = factor / 100.0
    local i = 1.0 - f
    local a = rgb.hex_to_rgb(color.hex)
    local b = rgb.hex_to_rgb(base.hex)

    return hsl(rgb.rgb_to_hex({
        r = a.r * i + b.r * f,
        g = a.g * i + b.g * f,
        b = a.b * i + b.b * f,
    }))
end

local function to_lush(opts) 
    return setmetatable(opts, {
        __index = function (_, key)
            if key == "__lush" then
                return { kind = "parsed_lush_spec" }
            end 
        end,
        __call = function (table)
           return table 
        end
    })
end

local function border(hl)
    return to_lush({
        fg = hl.bg,
        bg = hl.bg,
    })
end

---@diagnostic disable: undefined-global
local editor = lush(function(injected_functions)
    local sym = injected_functions.sym
    return {
        -- The following are the Neovim (as of 0.8.0-dev+100-g371dfb174) highlight
        -- groups, mostly used for styling UI elements.
        -- Comment them out and add your own properties to override the defaults.
        -- An empty definition `              {                                                              }` will clear all styling, leaving elements looking
        -- like the 'Normal' group.
        -- To be able to link to a group, it must already be defined, so you may have
        -- to reorder items as you go.
        --
        -- See :h highlight-groups
        --
        ColorColumn { bg = surface0 },                                                                          -- Columns set with 'colorcolumn'
        Conceal { fg = overlay1 },                                                                              -- Placeholder characters substituted for concealed text (see 'conceallevel')
        Cursor { fg = surface1, bg = mauve },                                                                   -- Character under the cursor
        lCursor { Cursor },                                                                                     -- Character under the cursor when |language                                                                                                             -mapping| is used (see 'guicursor')
        CursorIM { Cursor },                                                                                    -- Like Cursor, but used when in IME mode |CursorIM|
        CursorColumn { bg = mantle },                                                                           -- Screen                                                                                                                                                -column at the cursor, when 'cursorcolumn' is set.
        CursorLine { bg = crust.mix(base, 10).mix(blue, 15) },                                                  -- Screen                                                                                                                                                -line at the cursor, when 'cursorline' is set. Low               -priority if foreground (ctermfg OR guifg) is not set.
        Directory { fg = blue },                                                                                -- Directory names (and other special names in listings)
        DiffAdd { fg = green },                                                                                 -- Diff mode: Added line |diff.txt|
        DiffChange { fg = yellow },                                                                             -- Diff mode: Changed line |diff.txt|
        DiffDelete { fg = red },                                                                                -- Diff mode: Deleted line |diff.txt|
        DiffText { fg = text },                                                                                 -- Diff mode: Changed text within a changed line |diff.txt|
        EndOfBuffer { fg = surface1 },                                                                          -- Filler lines (~) after the end of the buffer. By default, this is highlighted like |hl                                                                -NonText|.
        TermCursor { Cursor },                                                                                  -- Cursor in a focused terminal
        TermCursorNC { TermCursor },                                                                            -- Cursor in an unfocused terminal
        ErrorMsg { fg = red, gui = "bold italic" },                                                             -- Error messages on the command line
        VertSplit { fg = crust },                                                                               -- Column separating vertically split windows
        Folded { fg = blue },                                                                                   -- Line used for closed folds
        FoldColumn { fg = overlay0 },                                                                           -- 'foldcolumn'
        SignColumn { fg = surface1 },                                                                           -- Column where |signs| are displayed
        SignColumnSB { SignColumn, bg = crust },                                                                -- Column where |signs| are displayed
        Substitute { fg = red, bg = surface1 },                                                                 -- |:substitute| replacement text highlighting
        LineNr { fg = surface1 },                                                                               -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
        LineNrAbove { LineNr },                                                                                 -- Line number for when the 'relativenumber' option is set, above the cursor line
        LineNrBelow { LineNr },                                                                                 -- Line number for when the 'relativenumber' option is set, below the cursor line
        CursorLineNr { fg = lavender },                                                                         -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
        CursorLineFold {},                                                                                      -- Like FoldColumn when 'cursorline' is set for the cursor line
        CursorLineSign {},                                                                                      -- Like SignColumn when 'cursorline' is set for the cursor line
        MatchParen { fg = peach, bg = surface1.mix(base, 70), gui = "bold" },                                   -- Character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
        ModeMsg { fg = text, gui = "bold" },                                                                    -- 'showmode' message (e.g., "                                                                                                                           -                                                                - INSERT -- ")
        MsgArea {},                                                                                             -- Area for messages and cmdline
        MoreMsg { fg = blue },                                                                                  -- |more                                                                                                                                                 -prompt|
        NonText { fg = overlay0 },                                                                              -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
        Normal { fg = text, bg = base },                                                                        -- Normal text
        NormalFloat { Normal, bg = mantle },                                                                    -- Normal text in floating windows.
        FloatTitle { NormalFloat, gui = "bold" },                                                               -- Title of floating windows.
        FloatBorder { border(FloatTitle), lush = "" },                                                       -- Border of floating windows.
        FloatShadow {},
        NormalNC { Normal },                                                                                    -- normal text in non                                                                                                                                    -current windows
        NormalSB { Normal },                                                                                    -- normal text in non                                                                                                                                    -current windows
        Pmenu { fg = overlay2, bg = mantle },                                                                   -- Popup menu: Normal item.
        PmenuSel { bg = surface0, gui = "bold" },                                                               -- Popup menu: Selected item.
        PmenuMatch { fg = text, gui = "bold" },                                                                 -- Popup menu: matching text.
        PmenuMatchSel { gui = "bold" },                                                                         -- Popup menu: matching text in selected item; is combined with |hl                                                                                      -PmenuMatch| and |hl                                             -PmenuSel|.
        PmenuKind {},                                                                                           -- Popup menu: Normal item "kind"
        PmenuKindSel {},                                                                                        -- Popup menu: Selected item "kind"
        PmenuExtra { fg = overlay0 },                                                                           -- Popup menu: Normal item "extra text"
        PmenuExtraSel { PmenuExtra, bg = surface1, gui = "bold" },                                              -- Popup menu: Selected item "extra text"
        PmenuSbar { bg = surface0 },                                                                            -- Popup menu: Scrollbar.
        PmenuThumb { bg = overlay0 },                                                                           -- Popup menu: Thumb of the scrollbar.
        Question { fg = blue },                                                                                 -- |hit                                                                                                                                                  -enter| prompt and yes/no questions
        QuickFixLine { bg = surface1.mix(base, 70), gui = "bold" },                                             -- Current |quickfix| item in the quickfix window. Combined with |hl                                                                                     -CursorLine| when the cursor is there.
        Search { fg = text, bg = sky.mix(base, 30) },                                                           -- Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
        IncSearch { fg = mantle, bg = sky.da(20) },                                                             -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
        CurSearch { fg = mantle, bg = red },                                                                    -- Highlighting a search pattern under the cursor (see 'hlsearch')
        SpecialKey { NonText },                                                                                 -- Unprintable characters: text displayed differently from what it really is. But not 'listchars' whitespace. |hl                                        -Whitespace|
        SpellBad { sp = red, gui = "undercurl" },                                                               -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
        SpellCap { sp = yellow, gui = "undercurl" },                                                            -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
        SpellLocal { sp = blue, gui = "undercurl" },                                                            -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
        SpellRare { sp = green, gui = "undercurl" },                                                            -- Word that is recognized by the spellchecker as one that is hardly ever used. |spell| Combined with the highlighting used otherwise.
        StatusLine { fg = overlay0, bg = mantle },                                                              -- Status line of current window
        StatusLineNC { StatusLine, fg = surface1 },                                                             -- Status lines of not                                                                                                                                   -current windows. Note: If this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
        TabLine { fg = overlay0, bg = crust },                                                                  -- Tab pages line, not active tab page label
        TabLineFill { bg = mantle },                                                                            -- Tab pages line, where there are no labels
        TabLineSel { Normal },                                                                                  -- Tab pages line, active tab page label
        Title { fg = blue },                                                                                    -- Titles for output from ":set all", ":autocmd" etc.
        Visual { bg = surface1, gui = "bold" },                                                                 -- Visual mode selection
        VisualNOS { Visual },                                                                                   -- Visual mode selection when vim is "Not Owning the Selection".
        WarningMsg { fg = yellow },                                                                             -- Warning messages
        Whitespace { fg = surface1 },                                                                           -- "nbsp", "space", "tab" and "trail" in 'listchars'
        Winseparator { fg = crust, bg = "none" },                                                               -- Separator between window splits. Inherts from |hl                                                                                                     -VertSplit| by default, which it will replace eventually.
        MsgSeparator { Winseparator },                                                                          -- Separator for scrolled messages, `msgsep` flag of 'display'
        WildMenu { bg = overlay0 },                                                                             -- Current match in 'wildmenu' completion
        WinBar { fg = rosewater },                                                                              -- Window bar of current window
        WinBarNC { WinBar },                                                                                    -- Window bar of not                                                                                                                                     -current windows
        PreInsert { fg = overlay2 },                                                                            -- Text inserted when "preinsert" is in 'completeopt'.
        ComplHint { fg = subtext0 },                                                                            -- Virtual text of the currently selected completion.
        ComplMatchIns { PreInsert },                                                                            -- Matched text of the currently inserted completion.
        ComplHintMore { Question },                                                                             -- The additional information of the virtual text.


        -- Common vim syntax groups used for all kinds of code and markup.
        -- Commented-out groups should chain up to their preferred (*) group
        -- by default.
        --
        -- See :h group-name
        --
        Comment { fg = overlay2 },                                                                              -- Any comment
        Constant { fg = peach },                                                                                -- (*) Any constant
        String { fg = green },                                                                                  --   A string constant: "this is a string"
        Character { fg = teal },                                                                                --   A character constant: 'c', '\n'
        Number { fg = peach },                                                                                  --   A number constant: 234, 0xff
        Boolean { fg = peach },                                                                                 --   A boolean constant: TRUE, false
        Float { Number },                                                                                       --   A floating point constant: 2.3e10
        Variable { fg = text },                                                                                 -- (*) Any variable name
        Identifier { fg = flamingo },                                                                           -- (*) Any variable name
        Property { fg = lavender },                                                                             --   Property name
        Function { fg = blue },                                                                                 --   Function name (also: methods for classes)
        Statement { fg = mauve },                                                                               -- (*) Any statement
        Conditional { fg = mauve },                                                                             --   if, then, else, endif, switch, etc.
        Repeat { fg = mauve },                                                                                  --   for, do, while, etc.
        Label { fg = sapphire },                                                                                --   case, default, etc.
        Operator { fg = sky },                                                                                  --   "sizeof", "+", "*", etc.
        Keyword { fg = mauve },                                                                                 --   any other keyword
        Exception { fg = mauve },                                                                               --   try, catch, throw
        PreProc { fg = pink },                                                                                  -- (*) Generic Preprocessor
        Include { fg = mauve },                                                                                 --   Preprocessor #include
        Define { PreProc },                                                                                     --   Preprocessor #define
        Macro { PreProc },                                                                                      --   Same as Define
        PreCondit { PreProc },                                                                                  --   Preprocessor #if, #else, #endif, etc.
        Type { fg = yellow },                                                                                   -- (*) int, long, char, etc.
        StorageClass { Type },                                                                                  --   static, register, volatile, etc.
        Structure { Type },                                                                                     --   struct, union, enum, etc.
        Typedef { Type },                                                                                       --   A typedef
        Special { fg = pink },                                                                                  -- (*) Any special symbol
        SpecialChar { Special },                                                                                --   Special character in a constant
        Tag { fg = lavender, gui = "bold" },                                                                    --   You can use CTRL    -] on this
        Delimiter { fg = overlay2 },                                                                            --   Character that needs attention
        SpecialComment { Special },                                                                             --   Special things inside a comment (e.g. '\n')
        Debug { Special },                                                                                      --   Debugging statements
        Underlined { gui = "underline" },                                                                       -- Text that stands out, HTML links
        Bold { gui = "bold" },                                                                                  -- Text that stands out, HTML links
        Italic { gui = "italic" },                                                                              -- Text that stands out, HTML links
        Ignore {},                                                                                              -- Left blank, hidden |hl-Ignore| (NOTE: May be invisible here in template)
        Error { fg = red },                                                                                     -- Any erroneous construct
        Todo { fg = base, bg = flamingo },                                                                      -- Anything that needs extra attention; mostly the keywords TODO FIXME and XXX


        -- These groups are for the native LSP client and diagnostic system. Some
        -- other LSP clients may use these groups, or use their own. Consult your
        -- LSP client's documentation.

        -- See :h diagnostic-highlights, some groups may not be listed, submit a PR fix to lush-template!
        --
        DiagnosticError { fg = red },                                                                           -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
        DiagnosticWarn { fg = yellow },                                                                         -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
        DiagnosticInfo { fg = sky },                                                                            -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
        DiagnosticHint { fg = teal },                                                                           -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
        DiagnosticOk { fg = green },                                                                            -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
        DiagnosticVirtualTextError { DiagnosticError, bg = DiagnosticError.fg.mix(base, 70) },                  -- Used for "Error" diagnostic virtual text.
        DiagnosticVirtualTextWarn { DiagnosticWarn, bg = DiagnosticWarn.fg.mix(base, 70) },                     -- Used for "Warn" diagnostic virtual text.
        DiagnosticVirtualTextInfo { DiagnosticInfo, bg = DiagnosticInfo.fg.mix(base, 70) },                     -- Used for "Info" diagnostic virtual text.
        DiagnosticVirtualTextHint { DiagnosticHint, bg = DiagnosticHint.fg.mix(base, 70) },                     -- Used for "Hint" diagnostic virtual text.
        DiagnosticVirtualTextOk { DiagnosticOk, bg = DiagnosticOk.fg.mix(base, 70) },                           -- Used for "Ok" diagnostic virtual text.
        DiagnosticUnderlineError { sp = DiagnosticError.fg, gui = "underline" },                                -- Used to underline "Error" diagnostics.
        DiagnosticUnderlineWarn { sp = DiagnosticWarn.fg, gui = "underline" },                                  -- Used to underline "Warn" diagnostics.
        DiagnosticUnderlineInfo { sp = DiagnosticInfo.fg, gui = "underline" },                                  -- Used to underline "Info" diagnostics.
        DiagnosticUnderlineHint { sp = DiagnosticHint.fg, gui = "underline" },                                  -- Used to underline "Hint" diagnostics.
        DiagnosticUnderlineOk { sp = DiagnosticOk.fg, gui = "underline" },                                      -- Used to underline "Ok" diagnostics.
        DiagnosticFloatingError { DiagnosticError },                                                            -- Used to color "Error" diagnostic messages in diagnostics float. See |vim.diagnostic.open_float()|
        DiagnosticFloatingWarn { DiagnosticWarn },                                                              -- Used to color "Warn" diagnostic messages in diagnostics float.
        DiagnosticFloatingInfo { DiagnosticInfo },                                                              -- Used to color "Info" diagnostic messages in diagnostics float.
        DiagnosticFloatingHint { DiagnosticHint },                                                              -- Used to color "Hint" diagnostic messages in diagnostics float.
        DiagnosticFloatingOk { DiagnosticOk },                                                                  -- Used to color "Ok" diagnostic messages in diagnostics float.
        DiagnosticSignError { DiagnosticError },                                                                -- Used for "Error" signs in sign column.
        DiagnosticSignWarn { DiagnosticWarn },                                                                  -- Used for "Warn" signs in sign column.
        DiagnosticSignInfo { DiagnosticInfo },                                                                  -- Used for "Info" signs in sign column.
        DiagnosticSignHint { DiagnosticHint },                                                                  -- Used for "Hint" signs in sign column.
        DiagnosticSignOk { DiagnosticOk },                                                                      -- Used for "Ok" signs in sign column.

        -- See :h lsp-highlight, some groups may not be listed, submit a PR fix to lush-template!
        --
        LspReferenceText { bg = surface1 },                                                                     -- Used for highlighting "text" references
        LspReferenceRead { LspReferenceText },                                                                  -- Used for highlighting "read" references
        LspReferenceWrite { LspReferenceText },                                                                 -- Used for highlighting "write" references
        LspCodeLens { fg = overlay0 },                                                                          -- Used to color the virtual text of the codelens. See |nvim_buf_set_extmark()|.
        LspCodeLensSeparator { LspCodeLens },                                                                   -- Used to color the seperator between two or more code lens.
        LspInlayHint { fg = overlay0 },                                                                         -- virtual text of the inlay hints
        LspSignatureActiveParameter { bf = surface0, gui = "bold" },                                            -- Used to highlight the active parameter in the signature help. See |vim.lsp.handlers.signature_help()|.
        LspInfoBorder { FloatBorder },                                                                          -- LspInfo border
        LspDiagnosticsDefaultError { DiagnosticError },                                                         -- Used as the mantle highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
        LspDiagnosticsDefaultWarning { DiagnosticWarn },                                                        -- Used as the mantle highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
        LspDiagnosticsDefaultInformation { DiagnosticInfo },                                                    -- Used as the mantle highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
        LspDiagnosticsDefaultHint { DiagnosticHint },                                                           -- Used as the mantle highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
        LspDiagnosticsFloatingError { DiagnosticFloatingError },                                                -- Used to color "Error" diagnostic messages in diagnostics float
        LspDiagnosticsFloatingWarning { DiagnosticFloatingWarn },                                               -- Used to color "Warning" diagnostic messages in diagnostics float
        LspDiagnosticsFloatingInformation { DiagnosticFloatingInfo },                                           -- Used to color "Information" diagnostic messages in diagnostics float
        LspDiagnosticsFloatingHint { DiagnosticFloatingHint },                                                  -- Used to color "Hint" diagnostic messages in diagnostics float
        LspDiagnosticsError { LspDiagnosticsDefaultError },
        LspDiagnosticsWarning { LspDiagnosticsDefaultWarning },
        LspDiagnosticsInformation { LspDiagnosticsDefaultInformation },
        LspDiagnosticsHint { LspDiagnosticsDefaultHint },
        LspDiagnosticsVirtualTextError { DiagnosticVirtualTextError },                                    -- Used for "Error" diagnostic virtual text
        LspDiagnosticsVirtualTextWarning { DiagnosticVirtualTextWarn },                                   -- Used for "Warning" diagnostic virtual text
        LspDiagnosticsVirtualTextInformation { DiagnosticVirtualTextInfo },                               -- Used for "Information" diagnostic virtual text
        LspDiagnosticsVirtualTextHint { DiagnosticVirtualTextHint },                                      -- Used for "Hint" diagnostic virtual text
        LspDiagnosticsUnderlineError { DiagnosticUnderlineError },                                        -- Used to underline "Error" diagnostics
        LspDiagnosticsUnderlineWarning { DiagnosticUnderlineWarn },                                       -- Used to underline "Warning" diagnostics
        LspDiagnosticsUnderlineInformation { DiagnosticUnderlineInfo },                                   -- Used to underline "Information" diagnostics
        LspDiagnosticsUnderlineHint { DiagnosticUnderlineHint },                                          -- Used to underline "Hint" diagnostics

        ----------------------------------------RAINBOW------------------------------------------
        Rainbow0 { fg = overlay2 },
        Rainbow1 { fg = red },
        Rainbow2 { fg = peach },
        Rainbow3 { fg = yellow },
        Rainbow4 { fg = green },
        Rainbow5 { fg = sapphire },
        Rainbow6 { fg = lavender },
        Rainbow7 { fg = mauve },

        markdownH1 { Rainbow1 },
        markdownH2 { Rainbow2 },
        markdownH3 { Rainbow3 },
        markdownH4 { Rainbow4 },
        markdownH5 { Rainbow5 },
        markdownH6 { Rainbow6 },
        markdownH7 { Rainbow7 },

        Backdrop { fg = hsl("#000000"), bg = hsl("#000000"), blend = 70 },


        -- Tree-Sitter syntax groups.
        --
        -- See :h treesitter-highlight-groups, some groups may not be listed,
        -- submit a PR fix to lush-template!
        --
        -- Tree-Sitter groups are defined with an "@" symbol, which must be
        -- specially handled to be valid lua code, we do this via the special
        -- sym function. The following are all valid ways to call the sym function,
        -- for more details see https://www.lua.org/pil/5.html
        --
        -- sym("@text.literal")
        -- sym('@text.literal')
        -- sym"@text.literal"
        -- sym'@text.literal'
        --
        -- For more information see https://github.com/rktjmp/lush.nvim/issues/109
        sym "@variable" { Variable },                                                                    -- various variable names
        sym "@variable.builtin" { Variable },                                                            -- built-in variable names (e.g. `this`)
        sym "@variable.parameter" { Variable },                                                          -- parameters of a function
        sym "@variable.parameter.builtin" { Variable },                                                  -- special parameters (e.g. `_`, `it`)
        sym "@variable.member" { Variable },                                                             -- object and struct fields
        sym "@constant" { Constant },                                                                    -- constant identifiers
        sym "@constant.builtin" { Constant },                                                            -- built-in constant values
        sym "@constant.macro" { Constant },                                                              -- constants defined by the preprocessor
        sym "@module" { Identifier },                                                                    -- modules or namespaces
        sym "@module.builtin" { Identifier },                                                            -- built-in modules or namespaces
        sym "@label" { Label },                                                                          -- GOTO and other labels (e.g. `label:` in C), including heredoc labels
        sym "@string" { String },                                                                        -- string literals
        sym "@string.documentation" { String },                                                          -- string documenting code (e.g. Python docstrings)
        sym "@string.regexp" { String },                                                                 -- regular expressions
        sym "@string.escape" { String },                                                                 -- escape sequences
        sym "@string.special" { String },                                                                -- other special strings (e.g. dates)
        sym "@string.special.symbol" { String },                                                         -- symbols or atoms
        sym "@string.special.url" { String },                                                            -- URIs (e.g. hyperlinks)
        sym "@string.special.path" { String },                                                           -- filenames
        sym "@character" { Character },                                                                  -- character literals
        sym "@character.special" { SpecialChar },                                                        -- special characters (e.g. wildcards)
        sym "@boolean" { Boolean },                                                                      -- boolean literals
        sym "@number" { Number },                                                                        -- numeric literals
        sym "@number.float" { Float },                                                                   -- floating-point number literals
        sym "@type" { Type },                                                                            -- type or class definitions and annotations
        sym "@type.builtin" { Type },                                                                    -- built-in types
        sym "@type.definition" { Typedef },                                                              -- identifiers in type definitions (e.g. `typedef <type> <identifier>` in C)
        sym "@attribute" { PreProc },                                                                    -- attribute annotations (e.g. Python decorators, Rust lifetimes)
        sym "@attribute.builtin" { PreProc },                                                            -- builtin annotations (e.g. `@property` in Python)
        sym "@property" { Property },                                                                    -- the key in key/value pairs
        sym "@function" { Function },                                                                    -- function definitions
        sym "@function.builtin" { Function },                                                            -- built-in functions
        sym "@function.call" { Function },                                                               -- function calls
        sym "@function.macro" { Macro },                                                                 -- preprocessor macros
        sym "@function.method" { Function },                                                             -- method definitions
        sym "@function.method.call" { Function },                                                        -- method calls
        sym "@constructor" { Function },                                                                 -- constructor calls and definitions
        sym "@operator" { Operator },                                                                    -- symbolic operators (e.g. `+` / `*`)
        sym "@keyword" { Keyword },                                                                      -- keywords not fitting into specific categories
        sym "@keyword.coroutine" { Keyword },                                                            -- keywords related to coroutines (e.g. `go` in Go, `async/await` in Python)
        sym "@keyword.function" { Keyword },                                                             -- keywords that define a function (e.g. `func` in Go, `def` in Python)
        sym "@keyword.operator" { Keyword },                                                             -- operators that are English words (e.g. `and` / `or`)
        sym "@keyword.import" { Keyword },                                                               -- keywords for including or exporting modules (e.g. `import` / `from` in Python)
        sym "@keyword.type" { Keyword },                                                                 -- keywords describing namespaces and composite types (e.g. `struct`, `enum`)
        sym "@keyword.modifier" { Keyword },                                                             -- keywords modifying other constructs (e.g. `const`, `static`, `public`)
        sym "@keyword.repeat" { Keyword },                                                               -- keywords related to loops (e.g. `for` / `while`)
        sym "@keyword.return" { Keyword },                                                               -- keywords like `return` and `yield`
        sym "@keyword.debug" { Keyword },                                                                -- keywords related to debugging
        sym "@keyword.exception" { Keyword },                                                            -- keywords related to exceptions (e.g. `throw` / `catch`)
        sym "@keyword.conditional" { Keyword },                                                          -- keywords related to conditionals (e.g. `if` / `else`)
        sym "@keyword.conditional.ternary" { Keyword },                                                  -- ternary operator (e.g. `?` / `:`)
        sym "@keyword.directive" { Keyword },                                                            -- various preprocessor directives & shebangs
        sym "@keyword.directive.define" { Keyword },                                                     -- preprocessor definition directives
        sym "@punctuation.delimiter" { Delimiter },                                                      -- delimiters (e.g. `;` / `.` / `,`)
        sym "@punctuation.bracket" { Delimiter },                                                        -- brackets (e.g. `()` / `{}` / `[]`)
        sym "@punctuation.special" { Special },                                                          -- special symbols (e.g. `{}` in string interpolation)
        sym "@comment" { Comment },                                                                      -- line and block comments
        sym "@comment.documentation" { Comment },                                                        -- comments documenting code
        sym "@comment.error" { Comment },                                                                -- error-type comments (e.g. `ERROR`, `FIXME`, `DEPRECATED`)
        sym "@comment.warning" { Comment },                                                              -- warning-type comments (e.g. `WARNING`, `FIX`, `HACK`)
        sym "@comment.todo" { Comment },                                                                 -- todo-type comments (e.g. `TODO`, `WIP`)
        sym "@comment.note" { Comment },                                                                 -- note-type comments (e.g. `NOTE`, `INFO`, `XXX`)
        sym "@markup.strong" { gui = "bold" },                                                           -- bold text
        sym "@markup.italic" { gui = "italic" },                                                         -- italic text
        sym "@markup.strikethrough" { gui = "strikethrough" },                                           -- struck-through text
        sym "@markup.underline" { gui = "underline" },                                                   -- underlined text (only for literal underline markup!)
        sym "@markup.heading" { markdownH1 },                                                            -- headings, titles (including markers)
        sym "@markup.heading.1" { markdownH2 },                                                          -- top-level heading
        sym "@markup.heading.2" { markdownH3 },                                                          -- section heading
        sym "@markup.heading.3" { markdownH4 },                                                          -- subsection heading
        sym "@markup.heading.4" { markdownH5 },                                                          -- and so on
        sym "@markup.heading.5" { markdownH6 },                                                          -- and so forth
        sym "@markup.heading.6" { markdownH7 },                                                          -- six levels ought to be enough for anybody
        sym "@markup.quote" { fg = pink },                                                               -- block quotes
        sym "@markup.math" { fg = blue },                                                                -- math environments (e.g. `$ ... $` in LaTeX)
        sym "@markup.link" { fg = lavender },                                                            -- text references, footnotes, citations, etc.
        sym "@markup.link.label" { sym "@markup.link" },                                                 -- link, reference descriptions
        sym "@markup.link.url" { sym "@markup.link", gui = "underline" },                                -- URL-style links
        sym "@markup.raw" { fg = green },                                                                -- literal or verbatim text (e.g. inline code)
        sym "@markup.raw.block" { sym "@markup.raw" },                                                   -- literal or verbatim text as a stand-alone block
        sym "@markup.list" { fg = green },                                                               -- list markers
        sym "@markup.list.checked" { sym "@markup.list" },                                               -- checked todo-style list markers
        sym "@markup.list.unchecked" { sym "@markup.list", fg = overlay1 },                              -- unchecked todo-style list markers
        sym "@diff.plus" { DiffAdd },                                                                    -- added text (for diff files)
        sym "@diff.minus" { DiffDelete },                                                                -- deleted text (for diff files)
        sym "@diff.delta" { DiffChange },                                                                -- changed text (for diff files)
        sym "@tag" { Tag },                                                                              -- XML-style tag names (and similar)
        sym "@tag.builtin" { Tag },                                                                      -- builtin tag names (e.g. HTML5 tags)
        sym "@tag.attribute" { Tag },                                                                    -- XML-style tag attributes
        sym "@tag.delimiter" { Tag },                                                                    -- XML-style tag delimiters

        
  		-- sym"@org.timestamp.active" { PreProc },
  		-- sym"@org.timestamp.inactive" { Comment },
  		-- sym"@org.bullet" { Identifier },
  		-- sym"@org.checkbox" { PreProc },
  		-- sym"@org.checkbox.halfchecked" { PreProc },
  		-- sym"@org.checkbox.checked" { PreProc },
  		-- sym"@org.properties" { Constant },
  		-- sym"@org.drawer" { Constant },
  		-- sym"@org.tag" { Function },
  		-- sym"@org.plan" { Constant },
  		-- sym"@org.comment" { Comment },
  		-- sym"@org.directive" { Comment },
  		-- sym"@org.block" { Comment },
  		-- sym"@org.latex" { Statement },
  		-- sym"@org.hyperlink" { Underlined },
  		-- sym"@org.code" { String },
  		-- sym"@org.code.delimiter" { String },
  		-- sym"@org.verbatim" { String },
  		-- sym"@org.verbatim.delimiter" { String },
  		-- sym"@org.bold" { bold = true },
  		-- sym"@org.bold.delimiter" { bold = true },
  		-- sym"@org.italic" { italic = true },
  		-- sym"@org.italic.delimiter" { italic = true },
  		-- sym"@org.strikethrough" { strikethrough = true },
  		-- sym"@org.strikethrough.delimiter" { strikethrough = true },
  		-- sym"@org.underline" { underline = true },
  		-- sym"@org.underline.delimiter" { underline = true },

        --------------------------------------------GIT------------------------------------------
        GitAdded { DiffAdd },
        GitDeleted { DiffDelete },
        GitModified { DiffChange },
        GitIgnored { fg = overlay0 },
        GitUntracked { fg = mauve },
        GitNew { GitAdded },
        GitStaged { GitAdded },
        GitRenamed { GitModified },
        GitUpdated { GitModified },
        GitCopied { GitModified },
        GitConflict { GitDeleted },
        GitUnstaged { GitDeleted },
        GitUnmerged { GitUnstaged },
        GitUnpulled { GitUnstaged },

        ----------------------------------------TELESCOPE----------------------------------------
        TelescopeTitle { FloatTitle },
        TelescopeNormal { NormalFloat },
        TelescopeBorder { border(TelescopeNormal), lush = "" },
        TelescopePreviewTitle { TelescopeTitle, bg = crust },
        TelescopePreviewNormal { TelescopeNormal, bg = crust },
        TelescopePreviewBorder { border(TelescopePreviewNormal), lush = "" },
        TelescopePromptTitle { TelescopeTitle, bg = base },
        TelescopePromptNormal { TelescopeNormal, bg = base },
        TelescopePromptBorder { border(TelescopePromptNormal), lush = "" },
        TelescopePromptPrefix { fg = flamingo },
        TelescopeResultsTitle { TelescopeTitle, bg = mantle },
        TelescopeResultsNormal { TelescopeNormal, bg = mantle },
        TelescopeResultsBorder { border(TelescopeResultsNormal), lush = "" },
        TelescopeSelectionCaret { TelescopePromptPrefix, bg = TelescopeResultsNormal.bg.da(10) },
        TelescopeSelection { TelescopeSelectionCaret, gui = "bold" },
        TelescopeMatching { fg = blue },

        ----------------------------------------NEOTREE----------------------------------------
        NeoTreeNormal { fg = text, bg = mantle },
        NeoTreeNormalNC { NeoTreeNormal },
        NeoTreeExpander { fg = overlay0 },
        NeoTreeIndentMarker { NeoTreeExpander },
        NeoTreeDirectoryName { Directory },
        NeoTreeDirectoryIcon { NeoTreeDirectoryName },
        NeoTreeRootName { NeoTreeDirectoryName },
        NeoTreeSymbolicLinkTarget { fg = pink },
        NeoTreeModified { fg = peach },

        NeoTreeGitAdded { GitAdded },
        NeoTreeGitConflict { GitConflict },
        NeoTreeGitDeleted { GitDeleted },
        NeoTreeGitIgnored { GitIgnored },
        NeoTreeGitModified { GitModified },
        NeoTreeGitUnstaged { GitUnstaged },
        NeoTreeGitUntracked { GitUntracked },
        NeoTreeGitStaged { GitStaged },

        NeoTreeFloatNormal { NormalFloat },
        NeoTreeFloatBorder { border(NeoTreeFloatNormal), lush = "" },
        NeoTreeFloatTitle { FloatTitle },
        NeoTreeTitleBar { NeoTreeFloatTitle, bg = crust },
        NeoTreeFileNameOpened { fg = pink },
        NeoTreeDimText { fg = overlay1 },
        NeoTreeFilterTerm { fg = green, gui = "bold" },
        NeoTreeTabActive { fg = lavender, bg = mantle, gui = "bold" },
        NeoTreeTabInactive { fg = overlay0, bg = base },
        NeoTreeTabSeparatorActive { NeoTreeTabActive, fg = NeoTreeTabActive.bg },
        NeoTreeTabSeparatorInactive { NeoTreeTabInactive, fg = NeoTreeTabInactive.bg },
        NeoTreeVertSplit { fg = base, bg = base },
        NeoTreeWinSeparator { fg = base, bg = base },
        NeoTreeStatusLineNC { fg = mantle, bg = mantle },

        ----------------------------------------NOTIFY----------------------------------------
        NotifyBody { Normal, bg = surface0 },
        NotifyTitle { NotifyBody, gui = "bold" },
        NotifyBorder { NotifyBody, fg = NotifyBody.bg },
        NotifyIcon { NotifyTitle },
        NotifyERRORBody { fg = text, bg = blend(DiagnosticError.fg, base, 70) },
        NotifyERRORTitle { NotifyTitle, bg = NotifyERRORBody.bg },
        NotifyERRORBorder { border(NotifyERRORTitle), lush = "" },
        NotifyERRORIcon { NotifyERRORTitle },
        NotifyWARNBody { fg = text, bg = blend(DiagnosticWarn.fg, base, 70) },
        NotifyWARNTitle { NotifyTitle, bg = NotifyWARNBody.bg },
        NotifyWARNBorder { border(NotifyWARNTitle), lush = "" },
        NotifyWARNIcon { NotifyWARNTitle },
        NotifyINFOBody { fg = text, bg = blend(DiagnosticInfo.fg, base, 70) },
        NotifyINFOTitle { NotifyTitle, bg = NotifyINFOBody.bg },
        NotifyINFOBorder { border(NotifyINFOTitle), lush = "" },
        NotifyINFOIcon { NotifyINFOTitle },
        NotifyDEBUGBody { fg = text, bg = blend(DiagnosticHint.fg, base, 70) },
        NotifyDEBUGTitle { NotifyTitle, bg = NotifyDEBUGBody.bg },
        NotifyDEBUGBorder { border(NotifyDEBUGTitle), lush = "" },
        NotifyDEBUGIcon { NotifyDEBUGTitle },
        NotifyTRACEBody { fg = text, bg = blend(DiagnosticOk.fg, base, 70) },
        NotifyTRACETitle { NotifyTitle, bg = NotifyTRACEBody.bg },
        NotifyTRACEBorder { border(NotifyTRACETitle), lush = "" },
        NotifyTRACEIcon { NotifyTRACETitle },

        ----------------------------------------BLINK------------------------------------------
        BlinkCmpLabel { fg = overlay2 },
        BlinkCmpLabelDeprecated { fg = overlay0, gui = "strikethrough" },
        BlinkCmpKind { fg = blue },
        BlinkCmpMenu { Pmenu },
        BlinkCmpDoc { NormalFloat },
        BlinkCmpLabelMatch { PmenuMatch },
        BlinkCmpMenuSelection { bg = surface0, gui = "bold" },
        BlinkCmpScrollBarGutter { bg = surface1 },
        BlinkCmpScrollBarThumb { bg = overlay0 },
        BlinkCmpLabelDescription { PmenuExtra },
        BlinkCmpLabelDetail { PmenuExtra },
        BlinkCmpSignatureHelp { NormalFloat },
        BlinkCmpSignatureHelpBorder { border(BlinkCmpSignatureHelp), lush = "" },
        BlinkCmpKindText { fg = mantle, bg = green, gui = "bold" },
        BlinkCmpKindMethod { fg = mantle, bg = blue, gui = "bold" },
        BlinkCmpKindFunction { fg = mantle, bg = blue, gui = "bold" },
        BlinkCmpKindConstructor { fg = mantle, bg = blue, gui = "bold" },
        BlinkCmpKindField { fg = mantle, bg = green, gui = "bold" },
        BlinkCmpKindVariable { fg = mantle, bg = flamingo, gui = "bold" },
        BlinkCmpKindClass { fg = mantle, bg = yellow, gui = "bold" },
        BlinkCmpKindInterface { fg = mantle, bg = yellow, gui = "bold" },
        BlinkCmpKindModule { fg = mantle, bg = blue, gui = "bold" },
        BlinkCmpKindProperty { fg = mantle, bg = blue, gui = "bold" },
        BlinkCmpKindUnit { fg = mantle, bg = green, gui = "bold" },
        BlinkCmpKindValue { fg = mantle, bg = peach, gui = "bold" },
        BlinkCmpKindEnum { fg = mantle, bg = yellow, gui = "bold" },
        BlinkCmpKindKeyword { fg = mantle, bg = mauve, gui = "bold" },
        BlinkCmpKindSnippet { fg = mantle, bg = flamingo, gui = "bold" },
        BlinkCmpKindColor { fg = mantle, bg = red, gui = "bold" },
        BlinkCmpKindFile { fg = mantle, bg = blue, gui = "bold" },
        BlinkCmpKindReference { fg = mantle, bg = red, gui = "bold" },
        BlinkCmpKindFolder { fg = mantle, bg = blue, gui = "bold" },
        BlinkCmpKindEnumMember { fg = mantle, bg = teal, gui = "bold" },
        BlinkCmpKindConstant { fg = mantle, bg = peach, gui = "bold" },
        BlinkCmpKindStruct { fg = mantle, bg = blue, gui = "bold" },
        BlinkCmpKindEvent { fg = mantle, bg = blue, gui = "bold" },
        BlinkCmpKindOperator { fg = mantle, bg = sky, gui = "bold" },
        BlinkCmpKindTypeParameter { fg = mantle, bg = maroon, gui = "bold" },
        BinkCmpKindCopilot { fg = mantle, bg = teal, gui = "bold" },

        ----------------------------------------NOICE------------------------------------------
        NoiceMini { fg = subtext0 },
        NoiceFormatProgressDone { fg = subtext0 },
        NoiceFormatProgressTodo { fg = subtext0 },
        NoicePopup { NormalFloat },
        NoicePopupTitle { FloatTitle },
        NoicePopupBorder { border(NoicePopupTitle), lush = "" },
        NoicePopupmenu { NormalFloat },
        NoicePopupmenuBorder { FloatBorder },
        NoiceCmdline { fg = text, bg = surface0 },
        NoiceCmdlinePopup { NoiceCmdline },
        NoiceCmdlinePopupTitle { NoiceCmdlinePopup },
        NoiceCmdlinePopupBorder { border(NoiceCmdlinePopupTitle), lush = "" },
        NoiceCmdlinePopupTitleInput { NoiceCmdlinePopupTitle },
        NoiceCmdlinePopupBorderInput { border(NoiceCmdlinePopupTitleInput), lush = "" },
        NoiceCmdlineIcon { fg = mauve },
        NoiceCmdlineIconSearch { fg = yellow },
        NoiceCmdlinePopupBorderSearch { NoiceCmdlineIconSearch },

        ----------------------------------------NOICE------------------------------------------
        WhichKey { NormalFloat },
        WhichKeyBorder { border(WhichKey), lush = "" },
        WhichKeyGroup { fg = blue },
        WhichKeySeparator { fg = overlay0 },
        WhichKeyDesc { fg = pink },
        WhichKeyValue { fg = overlay0 },

        ----------------------------------------NEOTEST------------------------------------------
        NeotestPassed { DiagnosticOk },
        NeotestFailed { DiagnosticError },
        NeotestRunning { fg = yellow },
        NeotestSkipped { fg = blue },
        NeotestTest { fg = text },
        NeotestNamespace { fg = mauve },
        NeotestFocused { gui = "bold underline" },
        NeotestFile { Directory },
        NeotestDir { Directory },
        NeotestIndent { fg = overlay1 },
        NeotestExpandMarker { fg = overlay1 },
        NeotestAdapterName { fg = maroon },
        NeotestWinSelect { fg = blue, gui = "bold" },
        NeotestMarked { fg = peach, gui = "bold" },
        NeotestTarget { fg = red },
        NeotestUnknown { fg = text },

        ----------------------------------------OVERSEER------------------------------------------
        OverseerPENDING { fg = subtext0 },
        OverseerRUNNING { fg = yellow },
        OverseerSUCCESS { DiagnosticOk },
        OverseerCANCELED { fg = overlay2 },
        OverseerFAILURE { DiagnosticError },
        OverseerTask { Function },
        OverseerTaskBorder { fg = sky },
        OverseerOutput { fg = text },
        OverseerComponent { Identifier },
        OverseerField { String },
        OverseerNormal { bg = mantle },
        OverseerNormalNC { OverseerNormal },
        OverseerCursorLine { CursorLine },

        ----------------------------------------MASON------------------------------------------
        MasonHeader { fg = base, bg = lavender, gui = "bold" },
        MasonHeaderSecondary { fg = base, bg = blue, gui = "bold" },
        MasonHighlight { fg = green },
        MasonHighlightBlock { fg = base, bg = MasonHighlight.fg },
        MasonHighlightBlockBold { MasonHighlightBlock, gui = "bold" },
        MasonHighlightSecondary { fg = mauve },
        MasonHighlightBlockSecondary { fg = base, bg = MasonHighlightSecondary.fg },
        MasonHighlightBlockBoldSecondary { MasonHighlightBlockSecondary, gui = "bold" },
        MasonMuted { fg = overlay0 },
        MasonMutedBlock { fg = base, bg = MasonMuted.fg },
        MasonMutedBlockBold { MasonMutedBlock, gui = "bold" },
        MasonError { fg = red },
        MasonHeading { fg = lavender, gui = "bold" },


        ----------------------------------------DAP------------------------------------------
        DapBreakpoint { fg = red },
        DapBreakpointCondition { fg = yellow },
        DapBreakpointRejected { fg = mauve },
        DapLogPoint { fg = sky },
        DapStopped { fg = maroon },                                                                             --
        DapUIScope { fg = sky },
        DapUIType { fg = mauve },
        DapUIValue { fg = sky },
        DapUIVariable { fg = text },
        DapUIModifiedValue { fg = peach },
        DapUIDecoration { fg = sky },
        DapUIThread { fg = green },
        DapUIStoppedThread { fg = sky },
        DapUISource { fg = lavender },
        DapUILineNumber { fg = sky },
        DapUIFloatBorder { FloatBorder },
        DapUIWatchesEmpty { fg = maroon },
        DapUIWatchesValue { fg = green },
        DapUIWatchesError { fg = maroon },
        DapUIBreakpointsPath { fg = sky },
        DapUIBreakpointsInfo { fg = green },
        DapUIBreakpointsCurrentLine { fg = green, gui = "bold" },
        DapUIBreakpointsDisabledLine { fg = surface2 },
        DapUIStepOver { fg = blue },
        DapUIStepOverNC { DapUIStepOver },
        DapUIStepInto { fg = blue },
        DapUIStepInfoNC { DapUIStepInto },
        DapUIStepBack { fg = blue },
        DapUIStepBackNC { DapUIStepBack },
        DapUIStepOut { fg = blue },
        DapUIStepOutNC { DapUIStepOut },
        DapUIStop { fg = red },
        DapUIStopNC { DapUIStop },
        DapUIPlayPause { fg = green },
        DapUIPlayPauseNC { DapUIPlayPause },
        DapUIRestart { fg = green },
        DapUIRestartNC { DapUIRestart },
        DapUIUnavailable { fg = surface1 },
        DapUIUnavailableNC { DapUIUnavailable },
        DapUIWinSelect { fg = peach },

        ----------------------------------------DIFFVIEW------------------------------------------
        DiffviewDim1 { Comment },
        DiffviewPrimary { fg = blue },
        DiffviewSecondary { fg = green },
        DiffviewNormal { Normal },
        DiffviewWinSeparator { Winseparator },
        DiffviewFilePanelTitle { fg = blue, gui = "bold" },
        DiffviewFilePanelCounter { fg = text },
        DiffviewFilePanelRootPath { fg = lavender, gui = "bold" },
        DiffviewFilePanelFileName { fg = text },
        DiffviewFilePanelSelected { fg = yellow },
        DiffviewFilePanelPath { Comment },
        DiffviewFilePanelInsertions { GitAdded },
        DiffviewFilePanelDeletions { GitDeleted },
        DiffviewFilePanelConflicts { GitConflict },
        DiffviewFolderName { NeoTreeDirectoryName },
        DiffviewFolderSign { NeoTreeDirectoryIcon },
        DiffviewHash { Identifier },
        DiffviewReference { Function },
        DiffviewReflogSelector { PreProc },
        DiffviewStatusAdded { GitAdded },
        DiffviewStatusUntracked { GitUntracked },
        DiffviewStatusModified { GitModified },
        DiffviewStatusRenamed { GitRenamed },
        DiffviewStatusCopied { GitCopied },
        DiffviewStatusTypeChange { GitModified },
        DiffviewStatusUnmerged { GitUnmerged },
        DiffviewStatusDeleted { GitDeleted },
        DiffviewStatusBroken { GitConflict },
        DiffviewStatusIgnored { GitIgnored },

        ----------------------------------------GITSIGNS------------------------------------------
        GitSignsAdd { GitAdded },
        GitSignsChange { GitModified },
        GitSignsDelete { GitDeleted },
        GitSignsCurrentLineBlame { Comment },
        GitSignsAddPreview { GitAdded, bg = "none" },
        GitSignsDeletePreview { GitDeleted, bg = "none" },
        GitSignsAddInline { fg = base, bg = GitAdded.fg, gui = "bold" },
        GitSignsDeleteInline { fg = base, bg = GitDeleted.fg, gui = "bold" },
        GitSignsChangeInline { fg = base, bg = GitModified.fg, gui = "bold" },

        ----------------------------------------NEOGIT------------------------------------------
        NeogitNormal { NormalFloat },
        NeogitBranch { Identifier },
        NeogitRemote { Include, gui = "bold" },
        NeogitFold { Folded },
        NeogitUnmergedInto { Function },
        NeogitUnpulledFrom { Function },
        NeogitUnpushedTo { Function },
        NeogitObjectId { Comment },
        NeogitStash { Comment },
        NeogitRebaseDone { Comment },
        NeogitDiffContextHighlight { bg = surface0 },
        NeogitDiffAdd { GitAdded },
        NeogitDiffAddHighlight { NeogitDiffAdd },
        NeogitDiffDelete { GitDeleted },
        NeogitDiffDeleteHighlight { NeogitDiffDelete },
        NeogitChangeModified { GitModified, gui = "bold" },
        NeogitChangeAdded { GitAdded, gui = "bold" },
        NeogitChangeDeleted { GitDeleted, gui = "bold" },
        NeogitChangeRenamed { GitRenamed, gui = "bold" },
        NeogitChangeUpdated { GitUpdated, gui = "bold" },
        NeogitChangeCopied { GitCopied, gui = "bold" },
        NeogitChangeBothModified { GitModified, gui = "bold" },
        NeogitChangeNewFile { GitNew, gui = "bold" },
        NeogitUntrackedfiles { GitUntracked, gui = "bold" },
        NeogitUnstagedchanges { GitUnstaged, gui = "bold" },
        NeogitUnmergedchanges { GitUnmerged, gui = "bold" },
        NeogitUnpulledchanges { GitUnpulled, gui = "bold" },
        NeogitStagedchanges { GitStaged, gui = "bold" },
        NeogitRecentcommits { GitStaged, gui = "bold" },
        NeogitStashes { Keyword, gui = "bold" },
        NeogitRebasing { Keyword, gui = "bold" },
        NeogitNotificationError { DiagnosticError },
        NeogitNotificationWarning { DiagnosticWarn },
        NeogitNotificationInfo { DiagnosticInfo },
        NeogitGraphRed { fg = red },
        NeogitGraphBoldRed { NeogitGraphRed, gui = "bold" },
        NeogitGraphWhite { fg = base },
        NeogitGraphBoldWhite { NeogitGraphWhite, gui = "bold" },
        NeogitGraphYellow { fg = yellow },
        NeogitGraphBoldYellow { NeogitGraphYellow, gui = "bold" },
        NeogitGraphGreen { fg = green },
        NeogitGraphBoldGreen { NeogitGraphGreen, gui = "bold" },
        NeogitGraphCyan { fg = sapphire },
        NeogitGraphBoldCyan { NeogitGraphCyan, gui = "bold" },
        NeogitGraphBlue { fg = blue },
        NeogitGraphBoldBlue { NeogitGraphBlue, gui = "bold" },
        NeogitGraphPirple { fg = mauve },
        NeogitGraphBoldPirple { NeogitGraphPirple, gui = "bold" },
        NeogitGraphGray { fg = subtext1 },
        NeogitGraphBoldGray { NeogitGraphGray, gui = "bold" },
        NeogitGraphOrange { fg = peach },
        NeogitGraphBoldOrange { NeogitGraphOrange, gui = "bold" },
        NeogitDiffContext { bg = base },
        NeogitPopupBold { Bold },
        NeogitPopupSwitchKey { fg = lavender },
        NeogitPopupOptionKey { fg = lavender },
        NeogitPopupConfigKey { fg = lavender },
        NeogitPopupActionKey { fg = lavender },
        NeogitFilePath { Directory, gui = "italic" },
        NeogitHunkHeader { Title },
        NeogitHunkHeaderHighlight { NeogitHunkHeader },
        NeogitDiffHeader { Title },
        NeogitDiffHeaderHighlight { NeogitDiffHeader },
        NeogitSectionHeader { WinBar },
        NeogitTagName { Tag },
        NeogitTagDistance { NeogitTagName },
        NeogitWinSeparator { Winseparator },

        ----------------------------------------LUALINE------------------------------------------
        lualine_a_command { fg = base, bg = peach, gui = "bold" },
        lualine_b_command { fg = peach, bg = surface0 },
        lualine_c_command { bg = "none" },
        lualine_a_terminal { fg = base, bg = green, gui = "bold" },
        lualine_b_terminal { fg = green, bg = surface0 },
        lualine_c_terminal { bg = "none" },
        lualine_a_insert { fg = base, bg = green, gui = "bold" },
        lualine_b_insert { fg = green, bg = surface0 },
        lualine_c_insert { bg = "none" },
        lualine_a_inactive { fg = blue, bg = "none" },
        lualine_b_inactive { fg = surface1, bg = "none", gui = "bold" },
        lualine_c_inactive { fg = overlay0, bg = "none" },
        lualine_a_visual { fg = base, bg = mauve, gui = "bold" },
        lualine_b_visual { fg = mauve, bg = surface0 },
        lualine_c_visual { bg = "none" },
        lualine_a_replace { fg = base, bg = red, gui = "bold" },
        lualine_b_replace { fg = red, bg = surface0 },
        lualine_c_replace { bg = "none" },
        lualine_a_normal { fg = mantle, bg = blue, gui = "bold" },
        lualine_b_normal { fg = blue, bg = surface0 },
        lualine_c_normal { fg = text, bg = "none" },

        ----------------------------------------MARKVIEW------------------------------------------
        MarkviewBlockQuoteDefault { fg = overlay2, bg = mantle },
        MarkviewBlockQuoteError { MarkviewBlockQuoteDefault, fg = DiagnosticError.fg },
        MarkviewBlockQuoteNote { MarkviewBlockQuoteDefault, fg = DiagnosticInfo.fg },
        MarkviewBlockQuoteOk { MarkviewBlockQuoteDefault, fg = DiagnosticOk.fg },
        MarkviewBlockQuoteWarn { MarkviewBlockQuoteDefault, fg = DiagnosticWarn.fg },
        MarkviewBlockQuoteSpecial { MarkviewBlockQuoteDefault, fg = Special.fg },
        MarkviewHyperlink = { sym "@markup.link.url" },
        MarkviewCode { bg = mantle, gui = "nocombine" },
        MarkviewCodeFg { fg = MarkviewCode.bg },
        MarkviewCodeInfo { MarkviewCode, fg = surface2 },
        MarkviewInlineCode { bg = surface0 },
        MarkviewTableHeader { Title },
        MarkviewPallete { bg = surface0 },
        MarkviewIcon { bg = mantle },
        MarkviewPallete0 { MarkviewPallete, fg = Rainbow0.fg },
        MarkviewPalette0Fg { fg = MarkviewPallete0.fg },
        MarkviewPalette0Bg { bg = MarkviewPallete0.bg },
        MarkviewIcon0 { MarkviewIcon, fg = MarkviewPallete0.fg },
        MarkviewPallete1 { MarkviewPallete, fg = Rainbow1.fg },
        MarkviewPalette1Fg { fg = MarkviewPallete1.fg },
        MarkviewPalette1Bg { bg = MarkviewPallete1.bg },
        MarkviewIcon1 { MarkviewIcon, fg = MarkviewPallete1.fg },
        MarkviewPallete2 { MarkviewPallete, fg = Rainbow2.fg },
        MarkviewPalette2Fg { fg = MarkviewPallete2.fg },
        MarkviewPalette2Bg { bg = MarkviewPallete2.bg },
        MarkviewIcon2 { MarkviewIcon, fg = MarkviewPallete2.fg },
        MarkviewPallete3 { MarkviewPallete, fg = Rainbow3.fg },
        MarkviewPalette3Fg { fg = MarkviewPallete3.fg },
        MarkviewPalette3Bg { bg = MarkviewPallete3.bg },
        MarkviewIcon3 { MarkviewIcon, fg = MarkviewPallete3.fg },
        MarkviewPallete4 { MarkviewPallete, fg = Rainbow4.fg },
        MarkviewPalette4Fg { fg = MarkviewPallete4.fg },
        MarkviewPalette4Bg { bg = MarkviewPallete4.bg },
        MarkviewIcon4 { MarkviewIcon, fg = MarkviewPallete4.fg },
        MarkviewPallete5 { MarkviewPallete, fg = Rainbow5.fg },
        MarkviewPalette5Fg { fg = MarkviewPallete5.fg },
        MarkviewPalette5Bg { bg = MarkviewPallete5.bg },
        MarkviewIcon5 { MarkviewIcon, fg = MarkviewPallete5.fg },
        MarkviewPallete6 { MarkviewPallete, fg = Rainbow6.fg },
        MarkviewPalette6Fg { fg = MarkviewPallete6.fg },
        MarkviewPalette6Bg { bg = MarkviewPallete6.bg },
        MarkviewIcon6 { MarkviewIcon, fg = MarkviewPallete6.fg },
        MarkviewPallete7 { MarkviewPallete, fg = Rainbow7.fg },
        MarkviewPalette7Fg { fg = MarkviewPallete7.fg },
        MarkviewPalette7Bg { bg = MarkviewPallete7.bg },
        MarkviewIcon7 { MarkviewIcon, fg = MarkviewPallete7.fg },

        ----------------------------------------ORGMODE------------------------------------------
        sym"@org.heading" { sym"@markup.heading" },
        sym"@org.heading1" { sym"@markup.heading.1" },
        sym"@org.heading2" { sym"@markup.heading.2" },
        sym"@org.heading3" { sym"@markup.heading.2" },
        sym"@org.heading4" { sym"@markup.heading.3" },
        sym"@org.heading5" { sym"@markup.heading.4" },
        sym"@org.heading6" { sym"@markup.heading.5" },
        sym"@org.heading7" { sym"@markup.heading.6" },
        sym"@org.priority.highest" { Rainbow1 },
        sym"@org.priority.high" {},
        sym"@org.priority.default" { Rainbow3 },
        sym"@org.priority.low" {},
        sym"@org.priority.lowest" {},
        sym"@org.timestamp.active" {},
        sym"@org.timestamp.inactive" {},
        sym"@org.keyword.todo" {},
        sym"@org.keyword.done" {},
        sym"@org.bullet" {},
        sym"@org.properties" {},
        sym"@org.drawer" {},
        sym"@org.tag" {},
        sym"@org.plan" {},
        sym"@org.block" {},
        sym"@org.inline_block" {},
        sym"@org.comment" {},
        sym"@org.latex_env" {},
        sym"@org.directive" {},
        sym"@org.checkbox" {},
        sym"@org.checkbox.halfchecked" {},
        sym"@org.checkbox.unchecked" {},
        sym"@org.checkbox.checked" {},
        sym"@org.bold" {},
        sym"@org.bold.delimiter" {},
        sym"@org.italic" {},
        sym"@org.italic.delimiter" {},
        sym"@org.strikethrough" {},
        sym"@org.strikethrough.delimiter" {},
        sym"@org.underline" {},
        sym"@org.underline.delimiter" {},
        sym"@org.code" {},
        sym"@org.code.dlimiter" {},
        sym"@org.verbatim" {},
        sym"@org.verbatim.delimiter" {},
        sym"@org.hyperlink" {},
        sym"@org.hyperlink.url" {},
        sym"@org.hyperlink.desc" {},
        sym"@org.latex" {},
        sym"@org.table.delimiter" {},
        sym"@org.table.heading" {},
        sym"@org.edit_src" {},
        sym"@org.agenda.deadline" {},
        sym"@org.agenda.scheduled" {},
        sym"@org.agenda.scheduled_past" {},
        sym"@org.agenda.time_grid" {},
        sym"@org.agenda.day" {},
        sym"@org.agenda.today" {},
        sym"@org.agenda.weekend" {},




        -- sym"@org.code" { MarkviewCode  },
        -- sym"@org.delimiter" {  Delimiter },
        -- sym"@org.quote" { sym"@markup.quote" },



    }
end)


return editor

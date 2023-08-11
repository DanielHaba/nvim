local options = {
    colorscheme = "catppuccin_latte",
    enable_installer = true,

    remaps = {
        highlights = {
            globals = {
                plugins = {},
            },
        },
    },
}

local palette = require("themer.modules.core.api").get_cp(options.colorscheme)
local color = require("themer.utils.colors")
local plugins = options.remaps.highlights.globals.plugins

palette.bg.alt2 = color.blend(palette.bg.base, palette.bg.selected, 0.8)

local cmp = {
    CmpItemKindKeyword = "keyword",
    CmpItemKindText = "statement",
    CmpItemKindSnippet = "preproc",

    CmpItemKindValue = "constant",
    CmpItemKindColor = "constant",
    CmpItemKindVariable = "variable",
    CmpItemKindConstant = "constant",
    CmpItemKindReference = "include",

    CmpItemKindFunction = "function",
    CmpItemKindMethod = "function",
    CmpItemKindConstructor = "constructor",

    CmpItemKindStruct = "struct",
    CmpItemKindClass = "struct",
    CmpItemKindInterface = "struct",
    CmpItemKindEvent = "struct",
    CmpItemKindEnum = "struct",
    CmpItemKindUnit = "struct",

    CmpItemKindModule = "include",
    CmpItemKindFile = "include",
    CmpItemKindFolder = "include",

    CmpItemKindProperty = "property",
    CmpItemKindField = "field",
    CmpItemKindTypeParameter = "parameter",
    CmpItemKindEnumMember = "variable",
    CmpItemKindOperator = "operator",
}
plugins.cmp = {}

for group, item in pairs(cmp) do
    local item_color = palette.syntax[item] or palette.fg
    if item_color == "#0" then
        item_color = "#000000"
    end
    plugins.cmp[group] = {
        bg = item_color,
        fg = color.blend(item_color, palette.bg.base, 0.3),
    }
end

plugins.telescope = {
    TelescopePromptNormal = {
        bg = palette.bg.selected,
    },
    TelescopePromptBorder = {
        bg = palette.bg.selected,
        fg = palette.bg.selected,
    },
    TelescopePromptTitle = {
        fg = palette.bg.selected,
        bg = palette.bg.selected,
    },

    TelescopePreviewNormal = {
        bg = palette.bg.alt,
    },
    TelescopePreviewBorder = {
        fg = palette.bg.alt,
        bg = palette.bg.alt,
    },
    TelescopePreviewTitle = {
        fg = palette.bg.alt,
        bg = palette.bg.alt,
    },

    TelescopeResultsNormal = {
        -- fg = palette.bg.alt2,
        bg = palette.bg.alt2,
    },
    TelescopeResultsBorder = {
        fg = palette.bg.alt2,
        bg = palette.bg.alt2,
    },
    TelescopeResultsTitle = {
        fg = palette.bg.alt2,
        bg = palette.bg.alt2,
    },
}

plugins.base = {
    NormalFloat = { fg = palette.fg, bg = palette.bg.alt },
    FloatBorder = { fg = palette.bg.base, bg = palette.bg.alt },
    FloatTitle = { fg = palette.fg, bg = palette.bg.alt },
}

return options

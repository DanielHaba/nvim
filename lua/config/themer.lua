local options = {
    colorscheme = vim.g.colorscheme,
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

plugins.notify = {
    NotifyBackground = { link = "NormalFloat" },
    NotifyBorder = { link ="FloatBorder" },
    NotifyERROR = { fg = palette.diagnostic.error },
    NotifyWARN = { fg = palette.diagnostic.warn },
    NotifyINFO = { fg = palette.diagnostic.info },
    NotifyDEBUG = { fg = palette.diagnostic.hint },
    NotifyTRACE = { fg = palette.diagnostic.hint },

	NotifyERRORBody = { link = "NotifyBackground" },
	NotifyWARNBody = { link = "NotifyBackground" },
	NotifyINFOBody = { link = "NotifyBackground" },
	NotifyDEBUGBody = { link = "NotifyBackground" },
	NotifyTRACEBody = { link = "NotifyBackground" },

	NotifyERRORBorder = { link = "NotifyBorder" },
	NotifyWARNBorder = { link = "NotifyBorder" },
	NotifyINFOBorder = { link = "NotifyBorder" },
	NotifyDEBUGBorder = { link = "NotifyBorder" },
	NotifyTRACEBorder = { link = "NotifyBorder" },


	NotifyERRORTitle = { link = "NotifyERROR" },
	NotifyERRORIcon = { link = "NotifyERROR" },

	NotifyWARNTitle = { link = "NotifyWARN" },
	NotifyWARNIcon = { link = "NotifyWARN" },

	NotifyINFOTitle = { link = "NotifyINFO" },
	NotifyINFOIcon = { link = "NotifyINFO" },

	NotifyDEBUGTitle = { link = "NotifyDEBUG" },
	NotifyDEBUGIcon = { link = "NotifyDEBUG" },

	NotifyTRACETitle = { link = "NotifyTRACE" },
	NotifyTRACEIcon = { link = "NotifyTRACE" },

}

return options

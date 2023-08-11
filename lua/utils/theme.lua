
local links = {
    TSFunction = "@function",
    TSVariable = "@variable",
    TSKeyword = "@keyword",
    TSString = "@string",
    TSTag = "@tag",
    TSField = "@field",
    TSParameter = "@parameter",
    TSProperty = "@property",
    TSPunctBracket = "@punctuation.bracket",
    TSConstructor = "@constructor",
    TSOperator = "@operator",
    TSConstant = "@constant",
    TSComment = "@comment",
    TSConditional = "@conditional",
    TSType = "@type",
    TSFuncBuiltin = "@function.builtin",
    TSTypeBuiltin = "@type.builtin",
    TSVariableBuiltin = "@variable.builtin",
    TSKeywordFunction = "@keyword.function",
    TSConstBuiltin = "@constant.builtin",
}

for hl, link in pairs(links) do
    vim.api.nvim_set_hl(0, hl, { link = link })
end

require("themer.modules.import").write_colorscheme()

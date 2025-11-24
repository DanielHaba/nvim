local MiniStatusline = require("mini.statusline")


local section_diagnostics = function()
    local signs = (vim.diagnostic.config().signs or { text = {} }).text or {}
    return MiniStatusline.section_diagnostics({
        signs = {
            ERROR = "%#DiagnosticError#" .. (signs[vim.diagnostic.severity.ERROR] or "E"),
            WARN = "%#DiagnosticWarn#" .. (signs[vim.diagnostic.severity.WARN] or "W"),
            INFO = "%#DiagnosticInfo#" .. (signs[vim.diagnostic.severity.INFO] or "I"),
            HINT = "%#DiagnosticHint#" .. (signs[vim.diagnostic.severity.HINT] or "H"),
        }
    })
end


return function()
    local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
    local git           = MiniStatusline.section_git({ trunc_width = 40 })
    local diagnostics   = section_diagnostics()
    local diff          = MiniStatusline.section_diff({ trunc_width = 75 })
    local lsp           = MiniStatusline.section_lsp({ trunc_width = 75 })
    -- local filename      = MiniStatusline.section_filename({ trunc_width = 140 })
    -- local fileinfo      = MiniStatusline.section_fileinfo({ trunc_width = 120 })
    -- local location      = MiniStatusline.section_location({ trunc_width = 75 })
    -- local search        = MiniStatusline.section_searchcount({ trunc_width = 75 })


    return MiniStatusline.combine_groups({
        { hl = mode_hl, strings = { mode } },
        { hl = "MiniStatuslineDevinfo", strings = { git, diff } },
        "%<",
        "",
        "%=",
        { hl = "MiniStatuslineDevinfo",      strings = { diagnostics } },
        { hl = "MiniStatuslineDevinfo",      strings = { lsp } },
    })
end

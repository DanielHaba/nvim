local group = vim.api.nvim_create_augroup("orgsuite_telescope_markview_patch", {})
local markview = require("markview")

vim.api.nvim_create_autocmd("User", {
    group = group,
    pattern = { "TelescopePreviewerLoaded" },
    callback = function(ctx)
        if ctx.data.filetype and ctx.data.filetype ~= "" then 
            vim.bo[ctx.buf].filetype = ctx.data.filetype
            markview.commands.attach(ctx.buf)
        end
    end
})

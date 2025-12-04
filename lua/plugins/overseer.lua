
return {
    {
        "stevearc/overseer.nvim",
        cmd = { 
            "OverseerRun", 
            "OverseerToggle",
            "OverseerOpen",
            "OverseerClose",
            "OverseerShell",
            "OverseerTaskAction",
        },
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "OverseerList",
                callback = function(ctx)
                    local sidebar = require("overseer.task_list.sidebar").get()
                    if sidebar then
                        vim.wo[sidebar:get_winid()].winhighlight = "Normal:OverseerNormal,NormalNC:OverseerNormalNC,CursorLine:OverseerCursorLine"
                    end 
                end,
            })
        end,
        opts = function()
            return require("config.overseer")
        end,
    },
}

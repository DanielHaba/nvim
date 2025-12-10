require("config.vim")

return {
    {
        "keymaps",
        dev = true,
        event = "VimEnter",
        opts = function()
            return require("config.keymaps")
        end,
    },
    {
        "theme",
        dev = true,
        event = "VeryLazy",
        dependencies = {
            { "backdrop" },
            { "focus" },
        },
        opts = {},
    },
    {
        "backdrop",
        dev = true,
        opts = {
            filetypes = {
                "NoicePopupMenu",
                "NoicePopup",
                "NoiceCmdline",
                "NoiceCmdlinePopupMenu",
                "NoiceCmdlineInput",
                "NoiceCmdlineOutput",
                "NoiceCmdlinePopup",
                "NoiceSplit",
                "NoiceVSplit",
                "NoiceMessages",
                -- "NoiceNotify",
                "NoiceConfirm",
                -- "NoiceMini",
                "NoiceHover",
            },
        },
    },
    {

        "focus",
        dev = true,
        opts = {
            ignored = {
                "notify",
                "NoiceNotify",
            },
        },
    },
}

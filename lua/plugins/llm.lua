return {
    { 
        "David-Kunz/gen.nvim",
        cmd = { "Gen" },
        opts = function ()
            return require("config.gen")
        end
    },
}

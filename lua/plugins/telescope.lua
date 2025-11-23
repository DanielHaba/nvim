return {
    {
        "nvim-telescope/telescope.nvim",
        cmd = {
            "Telescope",
        },
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            { "BurntSushi/ripgrep" },
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
        },
        init = function()
            require("utils.backdrop").create("TelescopePrompt")
        end,
        opts = function()
            return require("config.telescope")
        end,
        config = function(_, opts)
            local telescope = require("telescope")
            telescope.setup(opts)

            if opts.load_extensions then
                for name, enabled in pairs(opts.load_extensions) do
                    if enabled then
                        telescope.load_extension(name)
                    end
                end
            end
        end,
    },
}

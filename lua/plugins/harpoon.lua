return {
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
        config = function(_, opts)
            require("harpoon"):setup(opts)
        end,
    },
}

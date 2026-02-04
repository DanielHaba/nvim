return {
    {
        "chrishrb/gx.nvim",
        cmd = { "Browse" },
        dependencies = {
            { "nvim-lua/plenary.nvim" },
        },
        opts = {},
    },
    {
        enabled = false,
        "rest-nvim/rest.nvim",
        dependencies = {
            { 
                "nvim-treesitter/nvim-treesitter",
                opts = {
                    load_extensions = { "rest" },
                },
            },
        },
        cmd = "Rest",
        config = function (_, opts)
            vim.g.rest_nvim = opts 
        end
    },
}

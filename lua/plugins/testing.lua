return {
    {
        "nvim-neotest/neotest",
        dependencies = {
            { "nvim-neotest/nvim-nio" },
            { "nvim-lua/plenary.nvim" },
            { "antoinemadec/FixCursorHold.nvim" },
            { "nvim-treesitter/nvim-treesitter" },
            -- { "fredrikaverpil/neotest-golang" },
            { "nvim-neotest/neotest-go" },
            { "nvim-neotest/neotest-jest" },
        },
        opts = function()
            return require("config.neotest")
        end
    },
    {
        "andythigpen/nvim-coverage",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
        },
        cmd = {
            "Coverage",
            "CoverageLoad",
            "CoverageLoadLcov",
            "CoverageShow",
            "CoverageHide",
            "CoverageToggle",
            "CoverageClear",
            "CoverageSummary",
        },
        opts = { auto_reload = true },
    },
    {
        "fredrikaverpil/neotest-golang",
        build = function()
            vim.system({ "go", "install", "gotest.tools/gotestsum@latest" }):wait()
        end,
    },
}

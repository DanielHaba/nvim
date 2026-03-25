return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            {
                "rcarriga/nvim-dap-ui",
                dependencies = {
                    "nvim-neotest/nvim-nio",
                },
                opts = {},
            },
            {
                "theHamsta/nvim-dap-virtual-text",
                dependencies = {
                    "nvim-treesitter/nvim-treesitter",
                },
                opts = {},
            },
        },
        keys = {
            { "<Leader>b", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
            { "<F6>", function() require("dap").continue() end, desc = "Continue" },
            { "<F7>", function() require("dap").step_over() end, desc = "Step over" },
            { "<F8>", function() require("dap").step_into() end, desc = "Step into" },
            { "<F9>", function() require("dap").step_out() end, desc = "Step out" },
            { "<F10>", function() require("dap").terminate() end, desc = "Terminate" },
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})

            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end
        end,
    },
}

local dap = require("dap")
local dapui = require("dapui")


dap.set_log_level('TRACE')

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

require("config.keymaps").setup("dap")
require("config.keymaps").setup("dap_session")


require("dap-python").setup()

require("dap").configurations.python = {
    {
        type = "python",
        request = "launch",
        name = "Launch (all code)",
        justMyCode = false,
        program = "${file}",
    },
}

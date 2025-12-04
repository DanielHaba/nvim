local neotest_ns = vim.api.nvim_create_namespace("neotest")
vim.diagnostic.config({
	virtual_text = {
		format = function(diagnostic)
			local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
			return message
		end,
	},
}, neotest_ns)

local function load_adapter(name, config)
	local adapter = require(name)(config)
	local build_spec = adapter.build_spec

	adapter.build_spec = function(args)
        local spec = build_spec(args)
        spec.command = "sh -c '" .. spec.command .. "'"
        vim.print(spec)
        return spec
    end
    return adapter
end

return {
	adapters = {
		-- require("neotest-golang")({
		-- 	runner = "gotestsum",
		-- }),
		load_adapter("neotest-go", {
			experimental = {
				recursive_run = true,
				test_table = true,
			},
		}),
		load_adapter("neotest-jest", {
			jestCommand = "npm test --",
			jestArguments = function(defaultArguments, ctx)
				return defaultArguments
			end,
			env = { CI = true },
			cwd = function(path)
				return vim.fn.getcwd()
			end,
			isTestFile = require("neotest-jest.jest-util").defaultIsTestFile,
		}),
	},
	consumers = {
		overseer = require("neotest.consumers.overseer"),
	},
	overseer = {
		enabled = true,
		force_default = true,
	},
}

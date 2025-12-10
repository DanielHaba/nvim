local M = {}

---@param opts table<string, boolean>
function M.setup(opts)
    for patch, enabled in pairs(opts) do
        if enabled then
            pcall(require, "orgsuite.patches." .. patch)
        end
    end
end

return M


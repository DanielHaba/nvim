local ignored = {
    "node_modules",
    ".git",
}
return {}

-- local function list_programs(root)
--     local programs = {}
--     local files = vim.fs.dir(root, {
--         depth = 10,
--         skip = function (dir_name)
--             return not vim.tbl_contains(ignored, dir_name)
--         end,
--     })
--     for file, type in files do
--         local path = vim.fs.joinpath(root, file)
--         if type == "file" then
--             if false and vim.uv.fs_access(path, "X") then
--                 programs[file] = { path }
--             elseif file:find(".sh$") ~= nil then
--                 programs[file] = { "sh", path }
--             end
--         end
--     end
--     return programs
-- end
--
-- ---@type overseer.TemplateFileProvider
-- return {
--     generator = function(opts)
--         local ret = {}
--         local programs = list_programs(opts.dir)
--         vim.print(programs)
--
--         for name, cmd in pairs(programs) do
--             table.insert(ret, {
--                 name = name,
--                 builder = function(params)
--                     return {
--                         name = name,
--                         cwd = opts.dir,
--                         cmd = cmd,
--                         args = {},
--                         env = {},
--                     }
--                 end,
--             })
--         end
--
--         return ret
--     end,
-- }

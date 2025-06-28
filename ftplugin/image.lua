local stdin = vim.loop.new_pipe()
local stdout = vim.loop.new_pipe()
local stderr = vim.loop.new_pipe()
local content = vim.api.nvim_buf_get_lines(0, 0, -1, false)
local preview = {}
local handle

-- content = vim.api.nvim_replace_termcodes(table.concat(content, "\n"), true, true, true)
content = table.concat(content, "\n")
-- content = vim.api.nvim_replace_termcodes(content, true, true, true)
-- content = string.gsub(content, "<([0-9a-fA-F][0-9a-fA-F]?)>", "@%1@")
-- vim.print(content)
return nil

-- handle, _ = vim.loop.spawn(
--     "viu",
--     {
--         args = { "-" },
--         stdio = { stdin, stdout, stderr },
--     },
--     function(code)
--         print("exit code", code)
--     end
-- )
--
-- vim.loop.read_start(stdout, function(err, data)
--     assert(not err, err)
--     if data then
--         print("out chunk", data)
--         table.insert(preview, data)
--     end
-- end)
--
-- vim.loop.read_start(stderr, function(err, data)
--     assert(not err, err)
--     if data then
--         print("err chunk", data)
--         print(data)
--     end
-- end)
--
-- vim.print(content)
-- vim.loop.write(stdin, vim.api.nvim_buf_get_lines(0, 0, lines + 1, false))
-- vim.loop.shutdown(stdin, function ()
--     vim.loop.close(handle, nil)
-- end)


-- if result.code == 0 then
-- vim.api.nvim_buf_set_lines(0, 0, lines + 1, false, {"hello"})
-- end

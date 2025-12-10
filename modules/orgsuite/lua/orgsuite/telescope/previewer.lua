local previewer = require("telescope.previewers.buffer_previewer")
local from_entry = require("telescope.from_entry")
local Path = require("plenary.path")
local utils = require("telescope.utils")
local conf = require("telescope.config").values
local markview = require("markview")

local M = {}

local api = vim.api
local ns_previewer = api.nvim_create_namespace("telescope.previewers")

local jump_to_line = function(self, bufnr, entry)
    pcall(api.nvim_buf_clear_namespace, bufnr, ns_previewer, 0, -1)

    if entry.lnum and entry.lnum > 0 then
        local lnum, lnend = entry.lnum - 1, (entry.lnend or entry.lnum) - 1

        local col, colend = 0, -1
        -- Both col delimiters should be provided for them to take effect.
        -- This is to ensure that column range highlighting was opted in, as `col`
        -- is already used to determine the buffer jump position elsewhere.
        if entry.col and entry.colend then
            col, colend = entry.col - 1, entry.colend - 1
        end

        for i = lnum, lnend do
            pcall(
                utils.hl_range,
                bufnr,
                ns_previewer,
                "TelescopePreviewLine",
                { i, i == lnum and col or 0 },
                { i, i == lnend and colend or -1 }
            )
        end

        local middle_ln = math.floor(lnum + (lnend - lnum) / 2)
        pcall(api.nvim_win_set_cursor, self.state.winid, { middle_ln + 1, 0 })
        if bufnr ~= nil then
            api.nvim_buf_call(bufnr, function()
                vim.cmd "norm! zz"
            end)
        end
    end
end

function M.new(opts)
    return conf.grep_previewer(opts)
end

-- function M.new(opts)
--     opts = opts or {}
--     local cwd = opts.cwd or vim.uv.cwd()
--     return previewer.new_buffer_previewer({
--         title = "Preview",
--         dyn_title = function(_, entry)
--             return Path:new(from_entry.path(entry, false, false)):normalize(cwd)
--         end,
--
--         get_buffer_by_name = function(_, entry)
--             return from_entry.path(entry, false, false)
--         end,
--
--         define_preview = function(self, entry)
--             -- builtin.buffers: bypass path validation for terminal buffers that don't have appropriate path
--             local has_buftype = entry.bufnr and api.nvim_buf_is_valid(entry.bufnr) and vim.bo[entry.bufnr].buftype ~= ""
--                 or false
--             local p
--             if not has_buftype then
--                 p = from_entry.path(entry, true, false)
--                 if p == nil or p == "" then
--                     return
--                 end
--             end
--
--             -- Workaround for unnamed buffer when using builtin.buffer
--             if entry.bufnr and (p == "[No Name]" or has_buftype) then
--                 local lines = api.nvim_buf_get_lines(entry.bufnr, 0, -1, false)
--                 api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)
--                 -- schedule so that the lines are actually there and can be jumped onto when we call jump_to_line
--                 vim.schedule(function()
--                     -- vim.defer_fn(function () 
--                     --     markview.render(self.state.bufnr)
--                     -- end, 500)
--                     jump_to_line(self, self.state.bufnr, entry)
--                     -- require("markview").actions.attach(self.state.bufnr)
--                     -- require("markview.commands").enable(self.state.bufnr)
--                 end)
--             else
--                 conf.buffer_previewer_maker(p, self.state.bufnr, {
--                     bufname = self.state.bufname,
--                     winid = self.state.winid,
--                     preview = opts.preview,
--                     callback = function(bufnr)
--                         -- vim.defer_fn(function () 
--                         --     markview.render(self.state.bufnr)
--                         -- end, 500)
--                         jump_to_line(self, bufnr, entry)
--                     end,
--                     file_encoding = opts.file_encoding,
--                 })
--             end
--         end,
--
--     })
-- end

return M

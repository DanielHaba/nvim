

---@class Backdrop
---@field private win integer|nil
---@field private buf integer|nil
---@field private persistent boolean
local Backdrop = {}
Backdrop.__index = Backdrop


function Backdrop.new(persistent)
    return setmetatable({
        win = nil,
        buf = nil,
        persistent = persistent,
        refs = 0,
    }, Backdrop) 
end

---@param zindex integer
function Backdrop:create(zindex)
    if self.buf == nil then
        self.buf = vim.api.nvim_create_buf(false, true)
        vim.bo[self.buf].buftype = "nofile"
    end
    if self.win == nil then
        if zindex < 1 then zindex = 1 end
        self.win = vim.api.nvim_open_win(self.buf, false, {
            noautocmd = true,
            relative = "editor",
            border = "none",
            row = 0,
            col = 0,
            width = vim.o.columns,
            height = vim.o.lines,
            focusable = false,
            style = "minimal",
            zindex = zindex - 1,
            hide = false,
        })
        vim.wo[self.win].winhighlight = "Normal:Backdrop"
        vim.wo[self.win].winblend = 70
    end
end

function Backdrop:destroy()
    if self.win ~= nil then
        if vim.api.nvim_win_is_valid(self.win) then
            vim.api.nvim_win_close(self.win, true)
        end
        self.win = nil
    end
    if self.buf ~= nil then
        if vim.api.nvim_buf_is_valid(self.buf) then
            vim.api.nvim_buf_delete(self.buf, { force = true })
        end
        self.buf = nil
    end
end

---@type table<Backdrop>
local backdrops = {}

---@param win integer
---@param zindex integer
function Backdrop.open(win, zindex, persistent)
    if backdrops[win] == nil then
        local backdrop = Backdrop.new(persistent)
        backdrop:create(zindex)
        backdrops[win] = backdrop
    end
    backdrops[win].refs = backdrops[win].refs + 1
end

---@param win integer
function Backdrop.close(win)
    if backdrops[win] ~= nil then
        backdrops[win]:destroy()
        backdrops[win] = nil
    end
end

---@param win integer
function Backdrop.free(win)
    if backdrops[win] ~= nil then
        backdrops[win].refs = backdrops[win].refs - 1
        vim.schedule(function ()
            if backdrops[win] and backdrops[win].refs <= 0 then
                Backdrop.close(win)
            end
        end)
    end 
end

local dirty = false
function Backdrop.clean()
    dirty = true
    vim.schedule(function ()
        if not dirty then
            return
        end
        ---@type table<Backdrop>
        local kept_backdrops = {}
        for _, win in ipairs(vim.api.nvim_list_wins()) do
            kept_backdrops[win] = backdrops[win]
            backdrops[win] = nil
        end
        for win, backdrop in pairs(backdrops) do
            if backdrop.persistent then
                kept_backdrops[win] = backdrop
            else
                backdrop:destroy()
            end
        end
        backdrops = kept_backdrops
        dirty = false
    end)
end


local M = {}

function M.setup(opts)
    vim.api.nvim_set_hl(0, "Backdrop", { bg = "#000000", default = true })
    local opts = opts or {} 
    local group = vim.api.nvim_create_augroup("backdrop", {})

    vim.api.nvim_create_autocmd(
        { "WinNew", "WinEnter", "WinLeave", "WinClosed" },
        {
            group = group,
            callback = function ()
                Backdrop.clean()
            end
        }
    )
    vim.api.nvim_create_autocmd(
        { "WinEnter" },
        {
            group = group,
            callback = function ()
                local win = vim.api.nvim_get_current_win()
                local opts = vim.api.nvim_win_get_config(win)
                if opts.relative ~= "" then
                    Backdrop.open(win, opts.zindex)
                end
            end
        }
    )
    vim.api.nvim_create_autocmd("FileType", {
        group = group,
        pattern = opts.filetypes or {},
        callback = function (ctx)
            local win = vim.api.nvim_get_current_win()
            local opts = vim.api.nvim_win_get_config(win)
            if opts.relative ~= "" then 
                Backdrop.open(win, opts.zindex, true)
            end
            vim.api.nvim_create_autocmd({ "WinClosed", "BufLeave" }, {
                group = group,
                buffer = ctx.buf,
                once = true,
                callback = function ()
                   Backdrop.free(win)
                end,
            })
        end
    })
end

return M

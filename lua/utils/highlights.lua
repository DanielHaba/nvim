local M = {}
local color = require("catppuccin.utils.colors")


---@class window
---@field private n {}
---@field private b {}
---@field private t {}
local window = {}
window.__index = window

---@param fg string
---@param bg string
---@param ac string
---@return window
function window.new(fg, bg, ac)
    return window.solid(fg, bg, ac)
end

---@param fg string
---@param bg string
---@param ac string
---@return window
function window.standard(fg, bg, ac)
    local wnd = setmetatable({}, window)

    wnd.n = { fg = fg, bg = bg }
    wnd.b = { fg = ac, bg = bg }
    wnd.t = { fg = ac, bg = bg }

    return wnd
end

---@param fg string
---@param bg string
---@param ac string
---@return window
function window.block(fg, bg, ac)
    local wnd = setmetatable({}, window)

    wnd.n = { fg = fg, bg = bg }
    wnd.b = { fg = bg, bg = bg, blend = 100 }
    wnd.t = { fg = ac, bg = bg }

    return wnd
end

---@param fg string
---@param bg string
---@param ac string
---@return window
function window.solid(fg, bg, ac)
    local wnd = setmetatable({}, window)

    wnd.n = { fg = fg, bg = bg }
    wnd.b = { fg = bg, bg = bg }
    wnd.t = { fg = ac, bg = bg }

    return wnd
end

---@private
---@param fg string
---@param bg string
function window:hl(fg, bg)
    local hl = {}
    if fg ~= "none" then
        hl.fg = fg
    else
        hl.fg = "NONE"
        hl.ctermfg = "NONE"
    end
    if bg ~= "none" then
        hl.bg = bg
    else
        hl.bg = "NONE"
        hl.ctermbg = "NONE"
    end
    return hl
end

function window:border()
    return self.b
end

function window:title()
    return self.t
end

function window:normal()
    return self.n
end

---@param name string
function window:style(name)
    return {
        [name] = self:normal(),
        [name .. "Normal"] = self:normal(),
        [name .. "Title"] = self:title(),
        [name .. "Border"] = self:border(),
    }
end

local function compose(plugins)
    return function(colors)
        local result = {}
        for _, plugin in ipairs(plugins) do
            for _, style in ipairs(plugin(colors)) do
                result = vim.tbl_deep_extend("force", result, style)
            end
        end
        return result
    end
end

local function telescope(colors)
    local prompt = window.new(colors.text, colors.base, colors.blue)
    local preview = window.new(colors.text, colors.surface0, colors.blue)
    local results = window.new(colors.text, colors.crust, colors.blue)

    return {
        prompt:style("TelescopePrompt"),
        preview:style("TelescopePreview"),
        results:style("TelescopeResults"),
    }
end

local function notify_base(windows)
    return {
        windows.error:style("NotifyERROR"),
        windows.warn:style("NotifyWARN"),
        windows.info:style("NotifyINFO"),
        windows.debug:style("NotifyDEBUG"),
        windows.trace:style("NotifyTRACE"),
        {
            NotifyERRORBody = { link = "NotifyERRORNormal" },
            NotifyWARNBody = { link = "NotifyWARNNormal" },
            NotifyINFOBody = { link = "NotifyINFONormal" },
            NotifyDEBUGBody = { link = "NotifyDEBUGNormal" },
            NotifyTRACKEBody = { link = "NotifyTRACKENormal" },
            NotifyERRORIcon = { link = "NotifyERRORTitle" },
            NotifyWARNIcon = { link = "NotifyWARNTitle" },
            NotifyINFOIcon = { link = "NotifyINFOTitle" },
            NotifyDEBUGIcon = { link = "NotifyDEBUGTitle" },
            NotifyTRACKEIcon = { link = "NotifyTRACKETitle" },
        },
    }
end

local function notify_background(colors)
    return notify_base({
        error = window.new(colors.fg, color.blend(colors.red, colors.base, 0.1), colors.red),
        warn = window.new(colors.fg, color.blend(colors.yellow, colors.base, 0.1), colors.yellow),
        info = window.new(colors.fg, color.blend(colors.sky, colors.base, 0.1), colors.sky),
        debug = window.new(colors.fg, color.blend(colors.teal, colors.base, 0.1), colors.teal),
        trace = window.new(colors.fg, color.blend(colors.green, colors.base, 0.1), colors.green),
    })
end

local function notify_foreground(colors)
    return notify_base({
        error = window.new(colors.text, colors.surface0, colors.red),
        warn = window.new(colors.text, colors.surface0, colors.yellow),
        info = window.new(colors.text, colors.surface0, colors.sky),
        debug = window.new(colors.text, colors.surface0, colors.teal),
        trace = window.new(colors.text, colors.surface0, colors.green),
    })
end


local function notify(variant)
    if variant == "background" then
        return notify_background
    end
    return notify_foreground
end

local function float(colors)
    local win = window.new(colors.text, colors.crust, colors.blue)

    return { {
        NormalFloat = win:normal(),
        FloatBorder = win:border(),
        FloatTitle = win:title(),
    } }
end

local function noice(colors)
    local popup = window.new(colors.text, colors.crust, colors.red)
    local popupmenu = window.new(colors.text, colors.crust, colors.red)
    local cmdline = window.new(colors.text, colors.crust, colors.red)
    local confirm = window.new(colors.text, colors.crust, colors.red)
    local split = window.new(colors.text, colors.crust, colors.red)
    local mini = window.new(colors.text, colors.base, colors.red)

    return { {
        NoicePopup = popup:normal(),
        NoicePopupTitle = popup:title(),
        NoicePopupBorder = popup:border(),

        NoicePopupmenu = popupmenu:normal(),
        NoicePopupmenuBorder = popupmenu:border(),
        -- NoicePopupmenuSelected =
        -- NoicePopupmenuMatch =

        NoiceCmdline = cmdline:normal(),
        NoiceCmdlinePopup = cmdline:normal(),
        NoiceCmdlinePopupTitle = cmdline:title(),
        NoiceCmdlinePopupBorder = cmdline:border(),
        NoiceCmdlinePrompt = cmdline:title(),

        NoiceConfirm = confirm:normal(),
        NoiceConfirmBorder = confirm:border(),
        NoiceSplit = split:normal(),
        NoiceSplitBorder = split:border(),
        NoiceMini = mini:normal(),
    } }
end

local function blink(colors)
    return { {

        BlinkCmpKindText = { fg = colors.mantle, bg = colors.green, bold = true },
        BlinkCmpKindMethod = { fg = colors.mantle, bg = colors.blue, bold = true },
        BlinkCmpKindFunction = { fg = colors.mantle, bg = colors.blue, bold = true },
        BlinkCmpKindConstructor = { fg = colors.mantle, bg = colors.blue, bold = true },
        BlinkCmpKindField = { fg = colors.mantle, bg = colors.green, bold = true },
        BlinkCmpKindVariable = { fg = colors.mantle, bg = colors.flamingo, bold = true },
        BlinkCmpKindClass = { fg = colors.mantle, bg = colors.yellow, bold = true },
        BlinkCmpKindInterface = { fg = colors.mantle, bg = colors.yellow, bold = true },
        BlinkCmpKindModule = { fg = colors.mantle, bg = colors.blue, bold = true },
        BlinkCmpKindProperty = { fg = colors.mantle, bg = colors.blue, bold = true },
        BlinkCmpKindUnit = { fg = colors.mantle, bg = colors.green, bold = true },
        BlinkCmpKindValue = { fg = colors.mantle, bg = colors.peach, bold = true },
        BlinkCmpKindEnum = { fg = colors.mantle, bg = colors.yellow, bold = true },
        BlinkCmpKindKeyword = { fg = colors.mantle, bg = colors.mauve, bold = true },
        BlinkCmpKindSnippet = { fg = colors.mantle, bg = colors.flamingo, bold = true },
        BlinkCmpKindColor = { fg = colors.mantle, bg = colors.red, bold = true },
        BlinkCmpKindFile = { fg = colors.mantle, bg = colors.blue, bold = true },
        BlinkCmpKindReference = { fg = colors.mantle, bg = colors.red, bold = true },
        BlinkCmpKindFolder = { fg = colors.mantle, bg = colors.blue, bold = true },
        BlinkCmpKindEnumMember = { fg = colors.mantle, bg = colors.teal, bold = true },
        BlinkCmpKindConstant = { fg = colors.mantle, bg = colors.peach, bold = true },
        BlinkCmpKindStruct = { fg = colors.mantle, bg = colors.blue, bold = true },
        BlinkCmpKindEvent = { fg = colors.mantle, bg = colors.blue, bold = true },
        BlinkCmpKindOperator = { fg = colors.mantle, bg = colors.sky, bold = true },
        BlinkCmpKindTypeParameter = { fg = colors.mantle, bg = colors.maroon, bold = true },
        BinkCmpKindCopilot = { fg = colors.mantle, bg = colors.teal, bold = true },
    } }
end

M.all = compose({
    telescope,
    notify("background"),
    float,
    noice,
    blink,
})

return M

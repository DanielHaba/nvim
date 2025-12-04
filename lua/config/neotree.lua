local function on_move(data)
    Snacks.rename.on_rename_file(data.source, data.destination)
end
local events = require("neo-tree.events")

return {
    close_if_last_window = true,
    popup_border_style = "",
    enable_cursor_hijack = true,
    hide_root_node = true,
    event_handlers = { 
      { event = events.FILE_MOVED, handler = on_move },
      { event = events.FILE_RENAMED, handler = on_move },
    },
    default_component_configs = {
        modified = {
            symbol = "",
        },
        git_status = {
            symbols = {
                added     = "󱇬",
                deleted   = "󱎘",
                renamed   = "󰜴",
                modified  = "󰏫",
                staged    = "󰸞",
                untracked = "󰈤",
                unstaged  = "󰈔",
                conflict  = "󰈅",
            },
        },
    },
}


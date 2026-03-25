local function on_move(data)
    Snacks.rename.on_rename_file(data.source, data.destination)
end
local events = require("neo-tree.events")

return {
    close_if_last_window = true,
    popup_border_style = "",
    enable_cursor_hijack = false,  -- Wyłącz automatyczne przechwytywanie kursora
    hide_root_node = true,
    event_handlers = {
        { event = events.FILE_MOVED,   handler = on_move },
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
    filesystem = {
        commands = {
            avante_add_files = function(state)
                local node = state.tree:get_node()
                local filepath = node:get_id()
                local relative_path = require("avante.utils").relative_path(filepath)

                local sidebar = require("avante").get()

                local open = sidebar:is_open()
                -- ensure avante sidebar is open
                if not open then
                    require("avante.api").ask()
                    sidebar = require("avante").get()
                end

                sidebar.file_selector:add_selected_file(relative_path)

                -- remove neo tree buffer
                if not open then
                    sidebar.file_selector:remove_selected_file("neo-tree filesystem [1]")
                end
            end,
        },
        window = {
            mappings = {
                ["oa"] = "avante_add_files",
            },
        },
    },
}

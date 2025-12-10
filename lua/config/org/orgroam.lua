return {
    directory = "~/orgfiles",
    org_agenda_files = { 
        "~/orgfiles/**/*",
    },
    bindings = false,
    -- -- Bindings
    -- bindings = {
    --
    --     --- Global	Opens org-roam capture window.
    --     capture = "<Leader>nc",
    --     --- Global	Finds node and moves to it, creating it if it does not exist.
    --     find_node = "<Leader>nf",
    --     --- Org	Adds an alias to the node under cursor.
    --     add_alias = "<Leader>naa",
    --     --- Org	Adds an origin to the node under cursor.
    --     add_origin = "<Leader>noa",
    --     --- Org	Completes the node under cursor.
    --     complete_at_point = "<Leader>n.",
    --     --- Org	Goes to the next node in sequence (via origin) for the node under cursor.
    --     goto_next_node = "<Leader>nn",
    --     --- Org	Goes to the prev node in sequence (via origin) for the node under cursor.
    --     goto_prev_node = "<Leader>np",
    --     --- Org	Inserts node at cursor position, creating it if it does not exist.
    --     insert_node = "<Leader>ni",
    --     --- Org	Same as insert_node, but skips opening capture buffer.
    --     insert_node_immediate = "<Leader>nm",
    --     --- Org	Opens the quickfix menu for backlinks to the current node under cursor.
    --     quickfix_backlinks = "<Leader>nq",
    --     --- Org	Removes an alias from the node under cursor.
    --     remove_alias = "<Leader>nar",
    --     --- Org	Removes the origin from the node under cursor.
    --     remove_origin = "<Leader>nor",
    --     --- Org	Toggles the org-roam node-view buffer for the node under cursor.
    --     toggle_roam_buffer = "<Leader>nl",
    --     --- Org	Toggles a fixed org-roam node-view buffer for a selected node.
    --     toggle_roam_buffer_fixed = "<Leader>nb",
    -- },
    extensions = {
        dailies = {
            directory = "journal",
            -- Dailies Extension
            -- NOTE: All dailies keybindings are global
            bindings = false,
            -- bindings = {
            --     --- Capture a specific date’s note.
            --     capture_date = "<Leader>ndD",
            --     --- Capture today’s note.
            --     capture_today = "<Leader>ndN",
            --     --- Capture tomorrow’s note.
            --     capture_tomorrow = "<Leader>ndT",
            --     --- Capture yesterday’s note.
            --     capture_yesterday = "<Leader>ndY",
            --     --- Navigate to dailies note directory.
            --     find_directory = "<Leader>nd.",
            --     --- Navigate to specific date’s note.
            --     goto_date = "<Leader>ndd",
            --     --- Navigate to the next note in date sequence.
            --     goto_next_date = "<Leader>ndf",
            --     --- Navigate to the previous note in date sequence.
            --     goto_prev_date = "<Leader>ndb",
            --     --- Navigate to today’s note.
            --     goto_today = "<Leader>ndn",
            --     --- Navigate to tomorrow’s note.
            --     goto_tomorrow = "<Leader>ndt",
            --     --- Navigate to yesterday’s note.
            --     goto_yesterday = "<Leader>ndy",
            -- },
        },
    },
    ui = {
        select = {
            ---@type fun(node:org-roam.core.file.Node):org-roam.config.ui.SelectNodeItems
            node_to_items = function(node)
                ---@type string[]
                local items = {}

                local function make_item(label)
                    if #node.tags == 0 then
                        -- We can pass a string if the label and value
                        -- are the same
                        return label
                    else
                        local tags = table.concat(node.tags, ", ")

                        -- In the case that the label (displayed) and
                        -- value (injected) are different, we can pass
                        -- a table with `label` and `value` back
                        return {
                            label = ("(%s) %s"):format(tags, label),
                            value = label,
                        }
                    end
                end

                -- For the node's title and its aliases, we want
                -- to create an item where the title/alias is the
                -- value and we show them alongside tags if they exist
                --
                -- This allows us to search tags, but not insert
                -- tags as part of a link if selected
                table.insert(items, make_item(node.title))
                for _, alias in ipairs(node.aliases) do
                    -- Avoid duplicating the title if the alias is the same
                    if alias ~= node.title then
                        table.insert(items, make_item(alias))
                    end
                end

                return items
            end,
        },
    },
}

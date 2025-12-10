return {
    org_directories = {
        "~/orgfiles",
    },
    -- Agenda keymaps (inline comments explain each)
    keymaps = {
        filter_reset      = 'oa', -- reset all filters
        toggle_other      = 'oo', -- toggle catch-all "Other" section
        filter            = 'of', -- live filter (exact text)
        filter_fuzzy      = 'oz', -- live filter (fuzzy)
        filter_query      = 'oq', -- advanced query input
        undo              = 'u',  -- undo last change
        reschedule        = 'cs', -- set/change SCHEDULED
        set_deadline      = 'cd', -- set/change DEADLINE
        cycle_todo        = 't',  -- cycle TODO state
        set_state         = 's',  -- set state directly (st, sd, etc.) or show menu
        reload            = 'r',  -- refresh agenda
        refile            = 'R',  -- refile via Telescope/org-telescope
        hide_item         = 'x',  -- hide current item
        preview           = 'K',  -- preview headline content
        reset_hidden      = 'X',  -- clear hidden list
        toggle_duplicates = 'D',  -- duplicate items may appear in multiple groups
        cycle_view        = 'ov', -- switch view (classic/compact)
    },
    window = {
        border = "solid",
    },
    show_other_group = true,
    show_filename = false,

    groups = {
        { name = '📅 Today', matcher = function(i) return i.scheduled and i.scheduled:is_today() end, sort = { by = 'priority', order = 'desc' } },
        { name = '🗓️ Tomorrow', matcher = function(i) return i.scheduled and i.scheduled:days_from_today() == 1 end },
        { name = '☠️ Deadlines', matcher = function(i) return i.deadline and i.todo_state ~= 'DONE' end, sort = { by = 'deadline', order = 'asc' } },
        { name = '⭐ Important', matcher = function(i) return i.priority == 'A' and (i.deadline or i.scheduled) end, sort = { by = 'date_nearest', order = 'asc' } },
        {
            name = '⏳ Overdue',
            matcher = function(i)
                return i.todo_state ~= 'DONE' and
                    ((i.deadline and i.deadline:is_past()) or (i.scheduled and i.scheduled:is_past()))
            end,
            sort = { by = 'date_nearest', order = 'asc' }
        },
        {
            name = '📆 Upcoming',
            matcher = function(i)
                local days = require('org-super-agenda.config').get().upcoming_days or 10
                local d1 = i.deadline and i.deadline:days_from_today()
                local d2 = i.scheduled and i.scheduled:days_from_today()
                return (d1 and d1 >= 0 and d1 <= days) or (d2 and d2 >= 0 and d2 <= days)
            end,
            sort = { by = 'date_nearest', order = 'asc' }
        },
        -- {
        --     name = '🧺 Tasks',
        --     matcher = function(i)
        --         return i.todo_state ~= "DONE"
        --     end,
        --     sort = { by = 'priority', order = 'desc' },
        --     short_date_labels = true,
        --     inline_dates = true,
        -- },
    },
    -- view_mode = "classic",
    -- classic = {
    --     heading_order = { "todo", "priority", "headline" },
    -- },

}

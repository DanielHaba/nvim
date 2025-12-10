return {
    org_agenda_files = {
        "~/orgfiles/**/*",
    },
    org_default_notes_file = '~/orgfiles/refile.org',
    win_split_mode = "float",
    win_border = "solid",
    org_startup_indented = false,
    org_adapt_indentation = true,
    org_hide_emphasis_markers = true,
    org_log_done = "time",
    org_log_repeat = "time",
    org_log_into_drawer = "LOGBOOK",
    org_id_method = "org",
    org_id_link_to_org_use_id = true,
    calendar_week_start_day = 1,

    org_deadline_warning_days = 14,
    org_agenda_span = "week",
    org_agenda_start_on_weekday = 1,
    org_agenda_start_day = "-1d",
    org_agenda_skip_scheduled_if_done = true,
    org_agenda_skip_deadline_if_done = true,

    org_priority_highest = "A",
    org_priority_default = "C",
    org_priority_lowest = "E",

    -- org_capture_templates = {
    -- },


    mappings = {
        -- Global mappings
        -- There are only 2 global mappings that are accessible from everywhere.
        global = {
            --- Opens up agenda prompt.
            org_agenda = false,
            --- Opens up capture prompt.
            org_capture = false,
        },
        -- Agenda mappings
        -- Mappings used in agenda view window.
        agenda = {
            --- Go to next agenda span.
            org_agenda_later = { "f" },
            --- Go to previous agenda span.
            org_agenda_earlier = { "b" },
            --- Go to span with for today.
            org_agenda_goto_today = { "." },
            --- Show agenda day view.
            org_agenda_day_view = { "vd" },
            --- Show agenda week view.
            org_agenda_week_view = { "vw" },
            --- Show agenda month view.
            org_agenda_month_view = { "vm" },
            --- Show agenda year view.
            org_agenda_year_view = { "vy" },
            --- Close agenda.
            org_agenda_quit = { "<C-q>", "q" },
            --- Open selected agenda item in the same buffer.
            org_agenda_switch_to = { "<CR>" },
            --- Open selected agenda item in split window.
            org_agenda_goto = { "<TAB>" },
            --- Open calendar that allows selecting date to jump to.
            org_agenda_goto_date = { "J" },
            --- Reload all org files and refresh current agenda view.
            org_agenda_redo = { "r" },
            --- Change TODO state of an item in both agenda and original Org file.
            org_agenda_todo = { "t" },
            --- Clock in item under cursor. See Clocking for more details.
            org_agenda_clock_in = { "I" },
            --- Clock out currently active clock item. See Clocking for more details.
            org_agenda_clock_out = { "O" },
            --- Cancel clock on currently active clock item. See Clocking for more details.
            org_agenda_clock_cancel = { "X" },
            --- Jump to currently clocked in headline. See Clocking for more details.
            org_agenda_clock_goto = { "<Leader>oxj" },
            --- Show clock report at the end of the agenda for current agenda time range See Clocking for more details.
            org_agenda_clockreport_mode = { "R" },
            --- Choose the priority of a headline item.
            org_agenda_priority = { "<Leader>o," },
            --- Increase the priority of a headline item.
            org_agenda_priority_up = { "+" },
            --- Decrease the priority of a headline item.
            org_agenda_priority_down = { "-" },
            --- Archive headline item to archive location.
            org_agenda_archive = { "<Leader>o$" },
            --- Toggle “ARCHIVE” tag of a headline item.
            org_agenda_toggle_archive_tag = { "<Leader>oA" },
            --- Set tags on current headline item.
            org_agenda_set_tags = { "<Leader>ot" },
            --- Insert/Update deadline date on current headline item.
            org_agenda_deadline = { "<Leader>oid" },
            --- Insert/Update scheduled date on current headline item.
            org_agenda_schedule = { "<Leader>ois" },
            --- Refile current headline to a destination org-file. Same as org_refile but from agenda view.
            org_agenda_refile = { "<Leader>or" },
            --- Add note to the current headline
            org_agenda_add_note = { "<Leader>ona" },
            --- Open prompt that allows filtering current agenda view by category, tags and title (vim regex, see :help vim.regex())
            org_agenda_filter = { "/" },
            --- Preview the agenda item in a floating window. For configuring the floating window, check Agenda section in ui configuration.
            org_agenda_preview = { "K" },
            -- Show help popup with mappings
            org_agenda_show_help = { "g?" },
        },
        -- Capture mappings
        -- Mappings used in capture window.
        capture = {
            --- Save current capture content to org_default_notes_file and close capture window.
            org_capture_finalize = { "<C-c>" },
            --- Refile capture content to specific destination.
            org_capture_refile = { "<C-s>" },
            --- Close capture window without saving anything.
            org_capture_kill = { "<C-q>" },
            --- Show help popup with mappings.
            org_capture_show_help = { "g?" },

        },
        -- Note mappings
        -- Mappings used in closing note window.
        note = {
            --- Save note window content as closing note for a headline. Ignores first comment (if exists).
            org_note_finalize = { "<C-c>" },
            --- Close note window without saving anything.
            org_note_kill = { "<C-q>" },
        },
        -- Org mappings
        -- Mappings for org files.
        org = {
            --- Refile current headline, including its subtree, to a destination org-file. This file must be one of the files specified for the org_agenda_files setting. A target headline in the destination file can be specified with destination.org/<headline>. If there are multiple headlines with the same name in the destination file, the first occurence will be used.
            org_refile = false,
            --- Increase date part under under cursor. Accepts count: (Example: 5<C-a>) | in examples references cursor position.
            org_timestamp_up = { "<C-a>" },
            --- Decrease date part under under cursor. Same as org_timestamp_up, just opposite direction.
            org_timestamp_down = { "<C-x>" },
            --- Increase date under cursor by 1 or “count” day(s) (Example count: 5<S-UP>).
            org_timestamp_up_day = { "<CS-a>" },
            --- Decrease date under cursor by 1 or “count” day(s) (Example count: 5<S-UP>).
            org_timestamp_down_day = { "<CS-x>" },
            --- Change date under cursor. Opens calendar to select new date.
            org_change_date = false,
            --- Switches the timestamp under the cursor between inactive and active.
            org_toggle_timestamp_type = { "<Leader>od!" },
            --- Choose the priority of a headline item.
            org_priority = { "<C-p>" },
            --- Increase the priority of a headline item.
            org_priority_up = { "+" },
            --- Decrease the priority of a headline item.
            org_priority_down = { "-" },
            --- Cycle todo keyword forward on current headline or open fast access to TODO states prompt (see org_todo_keywords) if it’s enabled.
            org_todo = false,
            --- Cycle todo keyword backward on current headline.
            org_todo_prev = false,
            --- Toggle current line checkbox state.
            org_toggle_checkbox = false,
            --- Toggle current line to headline and vice versa. Checkboxes will turn into TODO headlines.
            org_toggle_heading = { "<Leader>*" },
            --- Insert a hyperlink at cursor position. When the cursor is on a hyperlink, edit that hyperlink. In visual mode, uses selected text as link description. If there are any links stored with org_store_link, pressing <TAB> to autocomplete the input will show list of all stored links to select. Links generated with ID are properly expanded to valid links after selection.
            org_insert_link = false,
            --- Generate a link to the closest headline. If org_id_link_to_org_use_id is true, it appends the ID property to the headline, and generates link with that id to be inserted via org_insert_link. When org_id_link_to_org_use_id is false, it generates the standard file::*headline link (example: file:/path/to/my/todos.org::*My headline)
            org_store_link = false,
            --- Open hyperlink or date under cursor. When date is under the cursor, open the agenda for that day.
            org_open_at_point = false,
            --- Open a source block for editing in a temporary buffer of the associated filetype. This is useful for editing text with language servers attached, etc. When the buffer is closed, the text of the underlying source block in the original Org file is updated. 📝 NOTE: if the Org file that the source block comes from is edited before the special edit buffer is closed, the edits will not be applied. The special edit buffer contents can be recovered from :messages output
            org_edit_special = { "<Leader>'" },
            --- Add note to the current headline.
            org_add_note = { "<Leader>n" },
            --- Cycle folding for current headline.
            org_cycle = { "<TAB>" },
            --- Cycle global folding.
            org_global_cycle = { "<S-TAB>" },
            --- Archive current headline to archive location.
            org_archive_subtree = { "<Leader>$" },
            --- Set tags on current headline.
            org_set_tags_command = { "<C-t>" },
            --- Toggle “ARCHIVE” tag on current headline.
            org_toggle_archive_tag = { "<Leder>x" },
            --- Promote headline.
            org_do_promote = { "<M-Right>" },
            --- Demote headline.
            org_do_demote = { "<M-Left>" },
            --- Promote subtree.
            org_promote_subtree = { "<" },
            --- Demote subtree.
            org_demote_subtree = { ">" },
            --- Add headline, list item or checkbox below, depending on current line.
            org_meta_return = false,
            --- Add headline after current headline + it’s content with same level.
            org_insert_heading_respect_content = { "<Leader>h" },
            --- Add TODO headline right after the current headline.
            org_insert_todo_heading = false,
            --- Add TODO headliner after current headline + it’s content.
            org_insert_todo_heading_respect_content = { "<Leader>t" },
            --- Move current headline + it’s content up by one headline.
            org_move_subtree_up = { "<M-k>" },
            --- Move current headline + it’s content down by one headline.
            org_move_subtree_down = { "<M-j>" },
            --- Open export options. NOTE: Exports are handled via emacs and pandoc. This means that emacs and/or pandoc must be in $PATH. See org_custom_exports if you want to add your own export options.
            org_export = { "<Leader>oe" },
            --- Go to next heading (any level).
            org_next_visible_heading = { "}" },
            --- Go to previous heading (any level).
            org_previous_visible_heading = { "{" },
            --- Go to next heading on same level. Doesn’t go outside of parent.
            org_forward_heading_same_level = { "]]" },
            --- Go to previous heading on same level. Doesn’t go outside of parent.
            org_backward_heading_same_level = { "[[" },
            --- Go to parent heading.
            outline_up_heading = { "g{" },
            --- Insert/Update deadline date.
            org_deadline = { "<Leader>d" },
            --- Insert/Update scheduled date.
            org_schedule = { "<Leader>s" },
            --- Insert/Update date under cursor.
            org_time_stamp = { "<C-.>" },
            --- Insert/Update inactive date under cursor.
            org_time_stamp_inactive = { "<C-,>" },
            --- Clock in headline under cursor. See Clocking for more details.
            org_clock_in = { "<Leader>ci" },
            --- Clock out headline under cursor. See Clocking for more details.
            org_clock_out = { "<Leader>co" },
            --- Cancel currently active clock on current headline. See Clocking for more details.
            org_clock_cancel = { "<Leader>cq" },
            --- Jump to currently clocked in headline. See Clocking for more details.
            org_clock_goto = { "<Leader>cc" },
            --- Set effort estimate property on for current headline. See Clocking for more details.
            org_set_effort = { "<Leader>ea" },
            --- Tangle current file. See Extract source code (tangle) for more details.
            org_babel_tangle = false,
            --- Show help popup with mappings
            org_show_help = { "g?" },
        },
        -- Edit Src
        -- Mappings applied when editing a SRC block content via org_edit_special.
        edit = { 
            --- Abort changes made to temporary buffer created from the content of a SRC block, see above.
            org_edit_src_abort = { "<C-q>" },
            --- Apply changes from the special buffer to the source Org buffer.
            org_edit_src_save = { "<C-s>" },
            --- Apply changes from the special buffer to the source Org buffer and close the edit special window.
            org_edit_src_save_exit = { "<CS-s>" },
            --- Show help within the temporary buffer used to edit the content of a SRC block.
            org_edit_src_show_help = { "g?" },
        },
        --Text objects
        --Operator mappings for org files. Example: Pressing vir select everything from current heading and all child. inner means that it doesn’t select the stars, where around selects inner + stars. See this issue comment for visual preview.
        --📝 NOTE: Some mappings can clash with other plugin mappings, like gitsigns.nvim which also has ih operator mapping.
        text_objects = {
            --- Select inner heading with content.
            inner_heading = { "ih" },
            --- Select around heading with content.
            around_heading = { "ah" },
            --- Select whole inner subtree.
            inner_subtree = { "ir" },
            --- Select around whole subtree.
            around_subtree = { "ar" },
            --- select everything from first level heading to the current heading.
            inner_heading_from_root = false,
            --- select around everything from first level heading to the current heading.
            around_heading_from_root = false,
            --- select everything from first level subtree to the current subtree.
            inner_subtree_from_root = false,
            --- select around everything from first level subtree to the current subtree.
            around_subtree_from_root = false,
        },
    },
    ui = {
        input = {
            use_vim_ui = true,
        },
        menu = {
            handler = function(data)
                -- your handler here, for example:
                local options = {}
                local options_by_label = {}

                for _, item in ipairs(data.items) do
                    -- Only MenuOption has `key`
                    -- Also we don't need `Quit` option because we can close the menu with ESC
                    if item.key and item.label:lower() ~= "quit" then
                        table.insert(options, item.label)
                        options_by_label[item.label] = item
                    end
                end

                local handler = function(choice)
                    if not choice then
                        return
                    end

                    local option = options_by_label[choice]
                    if option.action then
                        option.action()
                    end
                end

                vim.ui.select(options, {
                    propmt = data.propmt,
                }, handler)
            end,
        },
    },

}

return {
    provider = "claude-acp",
    acp_providers = {
        ["claude-acp"] = {
            env = {
                ANTHROPIC_API_KEY = os.getenv("ANTHROPIC_API_KEY"),
            },
        },
    },

    windows = {
        chat = {
            win_opts = {
                winhighlight = "Normal:AgenticChatNormal,FloatBorder:AgenticChatBorder",
                wrap = false,
            },
        },
        input = {
            win_opts = {
                winhighlight = "Normal:AgenticInputNormal,FloatBorder:AgenticInputBorder",
            },
        },
        code = {
            win_opts = {
                winhighlight = "Normal:AgenticCodeNormal,FloatBorder:AgenticCodeBorder",
            },
        },
    },

    headers = {
        chat = function(parts)
            local SessionRegistry = require("agentic.session_registry")
            local session = SessionRegistry.sessions[vim.api.nvim_get_current_tabpage()]

            if not session or not session.chat_history then
                return parts.title
            end

            local title = session.chat_history.title
            if not title or title == "" then
                return parts.title
            end

            return string.format("%%#AgenticChatTitle# %s %%#Normal#", title)
        end,

        input = function(parts)
            local SessionRegistry = require("agentic.session_registry")
            local session = SessionRegistry.sessions[vim.api.nvim_get_current_tabpage()]

            if not session or not session.agent_modes then
                return parts.title
            end

            local mode_id = session.agent_modes.current_mode_id
            if not mode_id then
                return parts.title
            end

            -- Uppercase first letter
            local function ucfirst(str)
                return str:sub(1, 1):upper() .. str:sub(2)
            end

            local mode_name = ucfirst(mode_id)
            local hl_group = "AgenticInputMode" .. mode_name

            return string.format("%%#%s# %s %%#Normal#", hl_group, mode_name)
        end,
    },
}

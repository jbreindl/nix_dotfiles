local wezterm = require("wezterm")
local multiplexing_config = {}

function multiplexing_config.apply(config)
    config.leader = { key = "Space", mods = "CTRL" }
    config.keys = {
        -- Split horizontally
        {
            key = "|",
            mods = "LEADER",
            action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
        },
        -- Split vertically
        {
            key = "-",
            mods = "LEADER",
            action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
        },
        -- Move focus to the left
        {
            key = "h",
            mods = "LEADER",
            action = wezterm.action.ActivatePaneDirection("Left"),
        },
        -- Move focus to the right
        {
            key = "l",
            mods = "LEADER",
            action = wezterm.action.ActivatePaneDirection("Right"),
        },
        -- Move focus up
        {
            key = "k",
            mods = "LEADER",
            action = wezterm.action.ActivatePaneDirection("Up"),
        },
        -- Move focus down
        {
            key = "j",
            mods = "LEADER",
            action = wezterm.action.ActivatePaneDirection("Down"),
        },
        -- Resize pane to the left
        {
            key = "h",
            mods = "LEADER|SHIFT",
            action = wezterm.action.AdjustPaneSize({ "Left", 5 }),
        },
        -- Resize pane to the right
        {
            key = "l",
            mods = "LEADER|SHIFT",
            action = wezterm.action.AdjustPaneSize({ "Right", 5 }),
        },
        -- Resize pane up
        {
            key = "k",
            mods = "LEADER|SHIFT",
            action = wezterm.action.AdjustPaneSize({ "Up", 5 }),
        },
        -- Resize pane down
        {
            key = "j",
            mods = "LEADER|SHIFT",
            action = wezterm.action.AdjustPaneSize({ "Down", 5 }),
        },
        -- tabs
        {
            key = "t",
            mods = "LEADER",
            action = wezterm.action.SpawnTab("CurrentPaneDomain"),
        },
        {
            key = "q",
            mods = "LEADER",
            action = wezterm.action.CloseCurrentTab({ confirm = false }),
        },
        {
            key = "n",
            mods = "LEADER",
            action = wezterm.action.ActivateTabRelative(1),
        },
        {
            key = "p",
            mods = "LEADER|SHIFT",
            action = wezterm.action.ActivateTabRelative(-1),
        },
        -- fuzzy find workspace
        {
            key = "s",
            mods = "LEADER",
            action = wezterm.action.ShowLauncherArgs { flags = "FUZZY|WORKSPACES" },
        },
        -- new workspace
        {
            key = "w",
            mods = "LEADER",
            action = wezterm.action.PromptInputLine {
                description = "Enter workspace name: ",
                action = wezterm.action_callback(function(window, pane, line)
                    if line then
                        window:perform_action(
                            wezterm.action.SwitchToWorkspace { name = line },
                            pane
                        )
                    end
                end),
            }
        },
    }
    for i = 1, 8 do
        table.insert(config.keys, {
            key = tostring(i),
            mods = "LEADER",
            action = wezterm.action.ActivateTab(i - 1),
        })
    end
end

return multiplexing_config

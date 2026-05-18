local wezterm = require("wezterm")
local config = wezterm.config_builder()
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")


-- apply the configs
local appearance = require("appearance").apply(config)
local multiplexing = require("multiplexing").apply(config)
local tabline_config = require("tabline").apply(config)


-- don't ask me if I want to quit when I close the last window
config.window_close_confirmation = "NeverPrompt"


-- Finally, return the configuration to wezterm:
return config

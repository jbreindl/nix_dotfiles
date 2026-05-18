local wezterm = require("wezterm")
local appearance_config = {}

function appearance_config.apply(config)
    -- font
    config.font = wezterm.font("Fira Code", { weight = "Regular" })
    config.font_size = 16
    config.font_dirs = { "/usr/share/fonts", "/usr/share/fonts-font-awesome/" }

    -- color scheme
    config.color_scheme = "Solarized Light (Gogh)"
    config.enable_tab_bar = true
    config.enable_wayland = false

    -- transparency
    config.window_background_opacity = 1.0
end

return appearance_config

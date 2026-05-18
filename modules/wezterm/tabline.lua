local wezterm = require("wezterm")
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")

local sol = {
    base3  = '#fdf6e3',
    base2  = '#eee8d5',
    base1  = '#93a1a1',
    base00 = '#657b83',
    base01 = '#586e75',
    blue   = '#268bd2',
    cyan   = '#2aa198',
    yellow = '#b58900',
}

local tabline_config = {}

function tabline_config.apply(config)
    tabline.setup({
        options = {
            icons_enabled = true,
            theme = config.color_scheme,
            theme_overrides = {
                normal_mode = {
                    a = { fg = sol.base3, bg = sol.blue },
                    b = { fg = sol.base01, bg = sol.base2 },
                    c = { fg = sol.base00, bg = sol.base3 },
                    x = { fg = sol.base00, bg = sol.base3 },
                    y = { fg = sol.base01, bg = sol.base2 },
                    z = { fg = sol.base3, bg = sol.blue },
                },
                copy_mode = {
                    a = { fg = sol.base3, bg = sol.yellow },
                    b = { fg = sol.base01, bg = sol.base2 },
                    c = { fg = sol.base00, bg = sol.base3 },
                    x = { fg = sol.base00, bg = sol.base3 },
                    y = { fg = sol.base01, bg = sol.base2 },
                    z = { fg = sol.base3, bg = sol.yellow },
                },
                search_mode = {
                    a = { fg = sol.base3, bg = sol.cyan },
                    b = { fg = sol.base01, bg = sol.base2 },
                    c = { fg = sol.base00, bg = sol.base3 },
                    x = { fg = sol.base00, bg = sol.base3 },
                    y = { fg = sol.base01, bg = sol.base2 },
                    z = { fg = sol.base3, bg = sol.cyan },
                },
                tab = {
                    active         = { fg = sol.base3, bg = sol.blue },
                    inactive       = { fg = sol.base01, bg = sol.base3 },
                    inactive_hover = { fg = sol.base01, bg = sol.base1 },
                },
            },
            tabs_enabled = true,
            section_separators = {
                left = wezterm.nerdfonts.pl_left_hard_divider,
                right = wezterm.nerdfonts.pl_right_hard_divider,
            },
            component_separators = {
                left = wezterm.nerdfonts.pl_left_soft_divider,
                right = wezterm.nerdfonts.pl_right_soft_divider,
            },
            tab_separators = {
                left = wezterm.nerdfonts.pl_left_hard_divider,
                right = wezterm.nerdfonts.pl_right_hard_divider,
            },
        },
        sections = {
            tabline_a = { 'mode' },
            tabline_b = { 'workspace' },
            tabline_c = { ' ' },
            tab_active = {
                'index',
                { 'process', padding = { left = 0, right = 1 } },
            },
            tab_inactive = { 'index', { 'process', padding = { left = 0, right = 1 } } },
            tabline_x = {},
            tabline_y = {},
            tabline_z = { 'domain' },
        },
        extensions = {},
    })
    tabline.apply_to_config(config)
end

return tabline_config

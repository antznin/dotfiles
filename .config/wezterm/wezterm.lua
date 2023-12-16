local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = 'dayfox'
config.font = wezterm.font {
  family = "JetBrainsMonoNerdFontCompleteM Nerd Font",
  harfbuzz_features = {
    'calt=1',
    'clig=1',
    'liga=1',
  },
}
config.enable_tab_bar = false
config.inactive_pane_hsb = {
  saturation = 0.8,
  brightness = 0.6,
}
config.keys = {
  {
    key = 'j',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ActivateCopyMode,
  },
}

return config

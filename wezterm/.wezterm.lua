local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.font = wezterm.font("ComicShannsMono Nerd Font")
config.font_size = 16.0

--config.color_scheme = "Catppuccin Mocha"
local home = os.getenv("HOME")
--config.window_background_image = home .. "/dotfiles/wezterm/background.png"
config.window_background_image_hsb = {
  brightness = 0.3,
  hue = 1.0,
  saturation = 1.0,
}

config.keys = {
  {
    key = "C",
    mods = "CTRL",
    action = wezterm.action.CopyTo("ClipboardAndPrimarySelection"),
  },
  {
    key = "V",
    mods = "CTRL",
    action = wezterm.action.PasteFrom("Clipboard"),
  },
  {
    key = "V",
    mods = "CTRL",
    action = wezterm.action.PasteFrom("PrimarySelection"),
  },
}

config.text_background_opacity = 1.0
config.window_background_opacity = 0.8

config.use_dead_keys = false

return config

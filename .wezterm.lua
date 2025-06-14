local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.wsl_domains = {
	{
		name = "WSL:Ubuntu",
		distribution = "Ubuntu-22.04",
		username = "yelloweq",
		default_prog = { "zsh" },
		default_cwd = "~",
	},
}

config.default_domain = "WSL:Ubuntu"

config.initial_cols = 120
config.initial_rows = 28
config.font_size = 14
config.line_height = 1.2
config.font = wezterm.font("DankMono Nerd Font")
config.colors = {
	cursor_bg = "white",
	cursor_border = "white",
}

color_scheme = "Catppuccin Mocha"
config.max_fps = 144
config.prefer_egl = true

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.hide_tab_bar_if_only_one_tab = true
config.audible_bell = "Disabled"

return config

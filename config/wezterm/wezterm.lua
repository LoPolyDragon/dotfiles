-- WezTerm 美化配置
local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- 颜色主题 - Catppuccin Mocha (与你的 tmux 主题匹配)
config.color_scheme = "Catppuccin Mocha"

-- 自定义颜色微调
config.colors = {
	-- 终端颜色
	foreground = "#cdd6f4",
	background = "#1e1e2e",
	cursor_bg = "#f5e0dc",
	cursor_fg = "#1e1e2e",
	cursor_border = "#f5e0dc",
	selection_fg = "#1e1e2e",
	selection_bg = "#f5e0dc",

	-- 标签栏颜色
	tab_bar = {
		background = "#11111b",
		active_tab = {
			bg_color = "#cba6f7",
			fg_color = "#11111b",
			intensity = "Bold",
		},
		inactive_tab = {
			bg_color = "#313244",
			fg_color = "#cdd6f4",
		},
		inactive_tab_hover = {
			bg_color = "#45475a",
			fg_color = "#cdd6f4",
		},
		new_tab = {
			bg_color = "#313244",
			fg_color = "#cdd6f4",
		},
		new_tab_hover = {
			bg_color = "#45475a",
			fg_color = "#cdd6f4",
		},
	},
}

-- 字体配置
config.font = wezterm.font_with_fallback({
	"MesloLGL Nerd Font Mono",
	"JetBrains Mono Nerd Font",
	"Fira Code Nerd Font",
	"SF Mono",
})
config.font_size = 16
config.line_height = 1.2
config.font_rules = {
	-- 粗体
	{
		intensity = "Bold",
		font = wezterm.font_with_fallback({
			{ family = "MesloLGL Nerd Font Mono", weight = "Bold" },
			{ family = "JetBrains Mono Nerd Font", weight = "Bold" },
		}),
	},
	-- 斜体
	{
		italic = true,
		font = wezterm.font_with_fallback({
			{ family = "MesloLGL Nerd Font Mono", style = "Italic" },
			{ family = "JetBrains Mono Nerd Font", style = "Italic" },
		}),
	},
}

-- 窗口配置
config.window_background_opacity = 0.95
config.macos_window_background_blur = 20
config.window_decorations = "RESIZE"
config.window_padding = {
	left = 20,
	right = 20,
	top = 20,
	bottom = 10,
}

-- 标签栏配置
config.enable_tab_bar = false
config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = false
config.show_new_tab_button_in_tab_bar = true

-- 性能优化
config.enable_kitty_graphics = true
config.animation_fps = 60
config.max_fps = 120

-- 快捷键配置
config.leader = { key = "s", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	-- 全屏切换
	{
		key = "Return",
		mods = "CMD",
		action = wezterm.action.ToggleFullScreen,
	},

	-- 新建标签页
	{
		key = "t",
		mods = "CMD",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},

	-- 关闭标签页
	{
		key = "w",
		mods = "CMD",
		action = wezterm.action.CloseCurrentTab({ confirm = true }),
	},

	-- 切换标签页
	{
		key = "[",
		mods = "CMD",
		action = wezterm.action.ActivateTabRelative(-1),
	},
	{
		key = "]",
		mods = "CMD",
		action = wezterm.action.ActivateTabRelative(1),
	},

	-- 分割面板
	{
		key = "|",
		mods = "LEADER|SHIFT",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "-",
		mods = "LEADER",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},

	-- 面板导航
	{
		key = "h",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		key = "j",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	{
		key = "k",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		key = "l",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},

	-- 调整面板大小
	{
		key = "H",
		mods = "LEADER|SHIFT",
		action = wezterm.action.AdjustPaneSize({ "Left", 5 }),
	},
	{
		key = "J",
		mods = "LEADER|SHIFT",
		action = wezterm.action.AdjustPaneSize({ "Down", 5 }),
	},
	{
		key = "K",
		mods = "LEADER|SHIFT",
		action = wezterm.action.AdjustPaneSize({ "Up", 5 }),
	},
	{
		key = "L",
		mods = "LEADER|SHIFT",
		action = wezterm.action.AdjustPaneSize({ "Right", 5 }),
	},

	-- 关闭面板
	{
		key = "x",
		mods = "LEADER",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},

	-- 最大化面板
	{
		key = "z",
		mods = "LEADER",
		action = wezterm.action.TogglePaneZoomState,
	},

	-- 复制模式
	{
		key = "[",
		mods = "LEADER",
		action = wezterm.action.ActivateCopyMode,
	},

	-- 快速搜索
	{
		key = "f",
		mods = "CMD",
		action = wezterm.action.Search({ CaseInSensitiveString = "" }),
	},
}

-- 鼠标配置
config.mouse_bindings = {
	-- 右键粘贴
	{
		event = { Down = { streak = 1, button = "Right" } },
		mods = "NONE",
		action = wezterm.action.PasteFrom("Clipboard"),
	},

	-- Ctrl+左键打开链接
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CTRL",
		action = wezterm.action.OpenLinkAtMouseCursor,
	},
}

-- 标签页标题格式
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local title = tab.active_pane.title
	if title and #title > 0 then
		return {
			{ Text = " " .. title .. " " },
		}
	end
	return {
		{ Text = " " .. tab.tab_index + 1 .. " " },
	}
end)

-- 启动时的配置
config.default_prog = { "/bin/zsh", "-l" }
config.default_cwd = os.getenv("HOME")

-- 调试和性能
config.debug_key_events = false
config.enable_wayland = false

return config


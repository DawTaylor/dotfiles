local wezterm = require('wezterm')
local config = wezterm.config_builder()

--------------------------------------------------------------------------------
-- AESTHETICS & THEME (Minimalist Catppuccin Mocha)
--------------------------------------------------------------------------------
config.color_scheme = 'Catppuccin Mocha'

-- Minimalist window decorations: remove standard title bar, keep resizable borders
config.window_decorations = 'RESIZE'
config.window_padding = {
  left = 12,
  right = 12,
  top = 12,
  bottom = 12,
}

-- Typography (Liga SFMono Nerd Font Light)
config.font = wezterm.font_with_fallback({
  { family = 'Liga SFMono Nerd Font', weight = 'Light' },
  'JetBrains Mono',
})
config.font_size = 24.0
config.line_height = 1.15

-- Explicit font rules for Bold / Italic to prevent variant lookup warnings
config.font_rules = {
  {
    intensity = 'Bold',
    font = wezterm.font_with_fallback({
      { family = 'Liga SFMono Nerd Font', weight = 'Bold' },
      'JetBrains Mono',
    }),
  },
  {
    intensity = 'Half',
    font = wezterm.font_with_fallback({
      { family = 'Liga SFMono Nerd Font', weight = 'Light' },
      'JetBrains Mono',
    }),
  },
  {
    italic = true,
    font = wezterm.font_with_fallback({
      { family = 'Liga SFMono Nerd Font', weight = 'Light', italic = true },
      'JetBrains Mono',
    }),
  },
}







-- Default Window Geometry (Larger Window Size)
config.initial_cols = 120
config.initial_rows = 35


-- Tab Bar Plugin (bar.wezterm)
local bar = wezterm.plugin.require('https://github.com/adriankarlen/bar.wezterm')

config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false

-- Apply bar.wezterm configuration after setting color_scheme
bar.apply_to_config(config)


--------------------------------------------------------------------------------
-- LEADER KEY & SHORTCUTS
--------------------------------------------------------------------------------
-- Leader key set to CTRL+a (tmux-style), with a 1 second timeout
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }

local act = wezterm.action

config.keys = {
  ------------------------------------------------------------------------------
  -- SPLITS & PANES
  ------------------------------------------------------------------------------
  -- Horizontal split (side-by-side): Leader + | or Leader + \
  {
    key = '|',
    mods = 'LEADER|SHIFT',
    action = act.SplitHorizontal({ domain = 'CurrentPaneDomain' }),
  },
  {
    key = '\\',
    mods = 'LEADER',
    action = act.SplitHorizontal({ domain = 'CurrentPaneDomain' }),
  },
  -- Vertical split (top-and-bottom): Leader + -
  {
    key = '-',
    mods = 'LEADER',
    action = act.SplitVertical({ domain = 'CurrentPaneDomain' }),
  },

  -- Pane Navigation (Vim style: Leader + h/j/k/l)
  { key = 'h', mods = 'LEADER', action = act.ActivatePaneDirection('Left') },
  { key = 'j', mods = 'LEADER', action = act.ActivatePaneDirection('Down') },
  { key = 'k', mods = 'LEADER', action = act.ActivatePaneDirection('Up') },
  { key = 'l', mods = 'LEADER', action = act.ActivatePaneDirection('Right') },

  -- Pane Navigation (macOS Option + Cmd + Arrow keys)
  { key = 'LeftArrow', mods = 'CMD|OPT', action = act.ActivatePaneDirection('Left') },
  { key = 'RightArrow', mods = 'CMD|OPT', action = act.ActivatePaneDirection('Right') },
  { key = 'UpArrow', mods = 'CMD|OPT', action = act.ActivatePaneDirection('Up') },
  { key = 'DownArrow', mods = 'CMD|OPT', action = act.ActivatePaneDirection('Down') },

  -- Pane Resizing (Leader + Shift + H/J/K/L)
  { key = 'H', mods = 'LEADER|SHIFT', action = act.AdjustPaneSize({ 'Left', 5 }) },
  { key = 'J', mods = 'LEADER|SHIFT', action = act.AdjustPaneSize({ 'Down', 5 }) },
  { key = 'K', mods = 'LEADER|SHIFT', action = act.AdjustPaneSize({ 'Up', 5 }) },
  { key = 'L', mods = 'LEADER|SHIFT', action = act.AdjustPaneSize({ 'Right', 5 }) },

  -- Toggle Pane Zoom (Maximize/Restore): Leader + z
  { key = 'z', mods = 'LEADER', action = act.TogglePaneZoomState },

  -- Close current pane: Leader + x
  { key = 'x', mods = 'LEADER', action = act.CloseCurrentPane({ confirm = true }) },

  ------------------------------------------------------------------------------
  -- TABS
  ------------------------------------------------------------------------------
  -- New Tab: Cmd + T or Leader + c
  { key = 't', mods = 'CMD', action = act.SpawnTab('CurrentPaneDomain') },
  { key = 'c', mods = 'LEADER', action = act.SpawnTab('CurrentPaneDomain') },

  -- Close Tab/Pane: Cmd + W
  { key = 'w', mods = 'CMD', action = act.CloseCurrentPane({ confirm = false }) },

  -- Tab Navigation (Cmd + Shift + [ / ])
  { key = '[', mods = 'CMD|SHIFT', action = act.ActivateTabRelative(-1) },
  { key = ']', mods = 'CMD|SHIFT', action = act.ActivateTabRelative(1) },
  { key = 'p', mods = 'LEADER', action = act.ActivateTabRelative(-1) },
  { key = 'n', mods = 'LEADER', action = act.ActivateTabRelative(1) },

  -- Direct Tab Selection (Cmd + 1..9)
  { key = '1', mods = 'CMD', action = act.ActivateTab(0) },
  { key = '2', mods = 'CMD', action = act.ActivateTab(1) },
  { key = '3', mods = 'CMD', action = act.ActivateTab(2) },
  { key = '4', mods = 'CMD', action = act.ActivateTab(3) },
  { key = '5', mods = 'CMD', action = act.ActivateTab(4) },
  { key = '6', mods = 'CMD', action = act.ActivateTab(5) },
  { key = '7', mods = 'CMD', action = act.ActivateTab(6) },
  { key = '8', mods = 'CMD', action = act.ActivateTab(7) },
  { key = '9', mods = 'CMD', action = act.ActivateTab(8) },

  -- Rename Tab: Leader + r
  {
    key = 'r',
    mods = 'LEADER',
    action = act.PromptInputLine({
      description = 'Enter new tab title:',
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          window:active_tab():set_title(line)
        end
      end),
    }),
  },

  ------------------------------------------------------------------------------
  -- KEYBOARD CURSOR NAVIGATION & SELECTION (Copy Mode & QuickSelect)
  ------------------------------------------------------------------------------
  -- Enter Copy Mode (Vim-style cursor navigation): Leader + [ or Cmd + Shift + X
  { key = '[', mods = 'LEADER', action = act.ActivateCopyMode },
  { key = 'X', mods = 'CMD|SHIFT', action = act.ActivateCopyMode },

  -- QuickSelect Mode (Select URLs, commit hashes, paths with keyboard hints): Leader + Space
  { key = 'Space', mods = 'LEADER', action = act.QuickSelect },

  ------------------------------------------------------------------------------
  -- MACOS CURSOR & WORD NAVIGATION (Opt / Cmd + Arrows & Backspace)
  ------------------------------------------------------------------------------
  -- Option + Left/Right: Jump backward/forward by word
  { key = 'LeftArrow', mods = 'OPT', action = act.SendString('\x1bb') },
  { key = 'RightArrow', mods = 'OPT', action = act.SendString('\x1bf') },

  -- Cmd + Left/Right: Jump to start/end of line
  { key = 'LeftArrow', mods = 'CMD', action = act.SendString('\x01') },
  { key = 'RightArrow', mods = 'CMD', action = act.SendString('\x05') },

  -- Option + Backspace: Delete word backward
  { key = 'Backspace', mods = 'OPT', action = act.SendString('\x17') },

  -- Cmd + Backspace: Delete line backward
  { key = 'Backspace', mods = 'CMD', action = act.SendString('\x15') },

  ------------------------------------------------------------------------------
  -- TERMINAL MANAGEMENT
  ------------------------------------------------------------------------------
  -- Clear Terminal / Scrollback & Viewport: Cmd + K
  {
    key = 'k',
    mods = 'CMD',
    action = act.Multiple({
      act.ClearScrollback('ScrollbackAndViewport'),
      act.SendKey({ key = 'L', mods = 'CTRL' }),
    }),
  },
}

return config



-- WezTerm config
-- https://wezfurlong.org/wezterm/config/files.html

local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

-- Split/pane keys mirror Ghostty's defaults per OS (these add to WezTerm's defaults)
local is_mac = wezterm.target_triple:find("darwin") ~= nil

if is_mac then
  config.keys = {
    { key = "d", mods = "CMD", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { key = "d", mods = "CMD|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
    { key = "[", mods = "CMD", action = act.ActivatePaneDirection("Prev") },
    { key = "]", mods = "CMD", action = act.ActivatePaneDirection("Next") },
    { key = "w", mods = "CMD", action = act.CloseCurrentPane({ confirm = true }) },
  }
else
  config.keys = {
    { key = "o", mods = "CTRL|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { key = "e", mods = "CTRL|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
    { key = "[", mods = "CTRL|SUPER", action = act.ActivatePaneDirection("Prev") },
    { key = "]", mods = "CTRL|SUPER", action = act.ActivatePaneDirection("Next") },
    { key = "w", mods = "CTRL|SHIFT", action = act.CloseCurrentPane({ confirm = true }) },
  }
end

return config

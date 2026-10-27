-- WezTerm config
-- https://wezfurlong.org/wezterm/config/files.html

local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

-- Theme: Dracula's soft blue-black, with its accents reused for tab colors
config.color_scheme = "Dracula (Official)"
local dracula = {
  bg = "#282a36",
  bar = "#21222c",
  tab = "#343746",
  accents = { "#bd93f9", "#ff79c6", "#8be9fd", "#50fa7b", "#ffb86c", "#f1fa8c", "#ff5555" },
}

-- Close windows, tabs and panes without asking
config.window_close_confirmation = "NeverPrompt"

-- Retro tab bar: no close button that prompts, and tabs render at the width we pad them to
config.use_fancy_tab_bar = false
config.tab_max_width = 32
config.colors = { tab_bar = { background = dracula.bar } }
local TAB_MIN_WIDTH = 20

-- Rename the current tab; an empty name goes back to the automatic label
local rename_tab = act.PromptInputLine({
  description = "Tab name (empty for automatic)",
  action = wezterm.action_callback(function(window, _, line)
    if line ~= nil then
      window:active_tab():set_title(line)
    end
  end),
})

-- Split/pane keys mirror Ghostty's defaults per OS (these add to WezTerm's defaults)
local is_mac = wezterm.target_triple:find("darwin") ~= nil

if is_mac then
  config.keys = {
    { key = "d", mods = "CMD", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { key = "d", mods = "CMD|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
    { key = "[", mods = "CMD", action = act.ActivatePaneDirection("Prev") },
    { key = "]", mods = "CMD", action = act.ActivatePaneDirection("Next") },
    { key = "w", mods = "CMD", action = act.CloseCurrentPane({ confirm = false }) },
    { key = "w", mods = "CTRL|SHIFT", action = act.CloseCurrentTab({ confirm = false }) },
    { key = "r", mods = "CMD|SHIFT", action = rename_tab },
  }
else
  config.keys = {
    { key = "o", mods = "CTRL|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { key = "e", mods = "CTRL|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
    { key = "[", mods = "CTRL|SUPER", action = act.ActivatePaneDirection("Prev") },
    { key = "]", mods = "CTRL|SUPER", action = act.ActivatePaneDirection("Next") },
    { key = "w", mods = "CTRL|SHIFT", action = act.CloseCurrentPane({ confirm = false }) },
    { key = "r", mods = "CTRL|SHIFT", action = rename_tab },
  }
end

-- Last folder of the pane's working directory, or nil when unknown (e.g. over plain ssh)
local function cwd_name(pane)
  local cwd = pane.current_working_dir
  if not cwd then
    return nil
  end
  local path = (type(cwd) == "string" and cwd or cwd.file_path):gsub("/+$", "")
  if path == "" or path == wezterm.home_dir then
    return "~"
  end
  return path:match("([^/]+)$")
end

-- Pane titles that only name the shell or a path (idle prompts), where the folder says more
local SHELL_TITLES = { zsh = true, bash = true, fish = true, sh = true, [""] = true }
local function is_idle_title(title)
  return SHELL_TITLES[title] or title:find("^[~/]") or title:find("^%.%.")
end

-- Label priority: a name set with rename, then a title the program set (Claude Code sets
-- one per task, also over ssh), then the folder
local function tab_label(tab)
  if tab.tab_title ~= "" then
    return tab.tab_title
  end
  local title = tab.active_pane.title:match("^%s*(.-)%s*$")
  if not is_idle_title(title) then
    return title
  end
  return cwd_name(tab.active_pane) or title
end

-- Same project, same color: hash the folder (or label) into the accent list
local function tab_color(key)
  local hash = 0
  for i = 1, #key do
    hash = (hash * 31 + key:byte(i)) % 2147483647
  end
  return dracula.accents[hash % #dracula.accents + 1]
end

wezterm.on("format-tab-title", function(tab, _, _, _, _, max_width)
  local label = tab_label(tab)
  local color = tab_color(cwd_name(tab.active_pane) or label)

  local text = " " .. wezterm.truncate_right(label, max_width - 2) .. " "
  local pad = TAB_MIN_WIDTH - wezterm.column_width(text)
  if pad > 0 then
    text = string.rep(" ", pad // 2) .. text .. string.rep(" ", pad - pad // 2)
  end

  if tab.is_active then
    return {
      { Background = { Color = color } },
      { Foreground = { Color = dracula.bg } },
      { Attribute = { Intensity = "Bold" } },
      { Text = text },
      { Background = { Color = dracula.bar } },
      { Text = " " },
    }
  end
  return {
    { Background = { Color = dracula.tab } },
    { Foreground = { Color = color } },
    { Text = text },
    { Background = { Color = dracula.bar } },
    { Text = " " },
  }
end)

return config

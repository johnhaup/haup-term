-- WezTerm config
-- https://wezfurlong.org/wezterm/config/files.html

local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

-- Theme: Dracula's soft blue-black, with its accents reused for tab colors
config.color_scheme = "Dracula (Official)"

-- Geist Mono (term-refresh installs it); JetBrains Mono ships with WezTerm as the fallback
config.font = wezterm.font_with_fallback({ "Geist Mono", "JetBrains Mono" })
local dracula = {
  bg = "#282a36",
  bar = "#21222c",
  tab = "#343746",
  accents = { "#bd93f9", "#ff79c6", "#8be9fd", "#50fa7b", "#ffb86c", "#f1fa8c", "#ff5555" },
}

-- Close windows, tabs and panes without asking. The tab × button only skips the prompt
-- for programs in this list, so it names the usual ones beyond the shells.
config.window_close_confirmation = "NeverPrompt"
config.skip_close_confirmation_for_processes_named = {
  "zsh", "bash", "fish", "sh", "tmux", "ssh", "mosh-client", "claude", "node", "bun",
  "python", "python3", "nvim", "vim", "less", "man", "lazygit", "yazi", "htop", "top",
  "btop", "gh", "git", "make",
}

-- Fancy tab bar for its × close buttons, in Dracula colors
config.use_fancy_tab_bar = true
config.tab_max_width = 56
config.window_frame = {
  active_titlebar_bg = dracula.bar,
  inactive_titlebar_bg = dracula.bar,
  -- Monospace like the terminal, so the minimum width (counted in columns) holds
  font = wezterm.font_with_fallback({
    { family = "Geist Mono", weight = "Bold" },
    { family = "JetBrains Mono", weight = "Bold" },
  }),
  font_size = 12.0,
}
config.colors = {
  tab_bar = {
    inactive_tab_edge = dracula.bar,
    new_tab = { bg_color = dracula.bar, fg_color = "#f8f8f2" },
    new_tab_hover = { bg_color = dracula.tab, fg_color = "#f8f8f2" },
  },
}
local TAB_MIN_WIDTH = 32

-- Rename the current tab; an empty name goes back to the automatic label
local rename_tab = act.PromptInputLine({
  description = "Tab name (empty for automatic)",
  action = wezterm.action_callback(function(window, _, line)
    if line ~= nil then
      window:active_tab():set_title(line)
    end
  end),
})

-- Try a font in the current window only; nothing is saved. Fonts missing on this
-- machine fall back to the default.
local FONTS = {
  "JetBrains Mono", "Fira Code", "Cascadia Code", "Monaspace Neon", "Monaspace Argon",
  "Monaspace Krypton", "Monaspace Xenon", "Monaspace Radon", "Geist Mono", "CommitMono",
  "Maple Mono", "Victor Mono", "IBM Plex Mono", "Hack", "Menlo",
}
local font_choices = {}
for _, name in ipairs(FONTS) do
  table.insert(font_choices, { label = name })
end
local pick_font = act.InputSelector({
  title = "Try a font (this window only)",
  fuzzy = true,
  choices = font_choices,
  action = wezterm.action_callback(function(window, _, _, label)
    if label then
      local overrides = window:get_config_overrides() or {}
      overrides.font = wezterm.font(label)
      window:set_config_overrides(overrides)
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
    { key = "f", mods = "CMD|SHIFT", action = pick_font },
  }
else
  config.keys = {
    { key = "o", mods = "CTRL|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { key = "e", mods = "CTRL|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
    { key = "[", mods = "CTRL|SUPER", action = act.ActivatePaneDirection("Prev") },
    { key = "]", mods = "CTRL|SUPER", action = act.ActivatePaneDirection("Next") },
    { key = "w", mods = "CTRL|SHIFT", action = act.CloseCurrentPane({ confirm = false }) },
    { key = "r", mods = "CTRL|SHIFT", action = rename_tab },
    { key = "f", mods = "CTRL|SHIFT|ALT", action = pick_font },
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
-- one per task, also over ssh) prefixed with the folder, then the folder
local function tab_label(tab)
  if tab.tab_title ~= "" then
    return tab.tab_title
  end
  local title = tab.active_pane.title:match("^%s*(.-)%s*$")
  if not is_idle_title(title) then
    local folder = cwd_name(tab.active_pane)
    if not folder or folder == "~" then
      return title
    end
    -- Keep Claude Code's leading status glyph (✳ ◐ …) in front of the folder
    local glyph, summary = title:match("^([^%w%p%s]+)%s+(.+)$")
    if glyph then
      return glyph .. " " .. folder .. " - " .. summary
    end
    return folder .. " - " .. title
  end
  return cwd_name(tab.active_pane) or title
end

wezterm.on("format-tab-title", function(tab, _, _, _, _, max_width)
  local label = tab_label(tab)
  -- Each tab keeps the color it opened with; tab ids count up, so neighbors differ
  local color = dracula.accents[tab.tab_id % #dracula.accents + 1]

  -- Title plus the × button and its margins must fit in max_width. In windows too narrow for
  -- every tab, WezTerm shrinks them all and clips the ends regardless.
  local text = " " .. wezterm.truncate_right(label, max_width - 8) .. " "
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
    }
  end
  return {
    { Background = { Color = dracula.tab } },
    { Foreground = { Color = color } },
    { Text = text },
  }
end)

return config

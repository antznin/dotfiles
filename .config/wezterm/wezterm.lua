local wezterm = require 'wezterm'

--
-- Config
--

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- config.colors = wezterm.color.load_scheme(os.getenv("HOME") .. "/.config/wezterm/github_light.toml")
local custom = wezterm.color.get_builtin_schemes()["Catppuccin Latte"]
custom.background = "#ffffff"
config.color_schemes = {
  ["custom"] = custom,
}
config.color_scheme = "custom"

config.font = wezterm.font {
  family = "JetBrainsMonoNerdFontCompleteM Nerd Font",
  harfbuzz_features = {
    'calt=1',
    'clig=1',
    'liga=1',
  },
}

config.font_size = 14

config.enable_tab_bar = false

config.keys = {
  {
    key = 'j',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ActivateCopyMode,
  },
  -- For some strange reason Wezterm thinks the dead key from qwerty-lafayette
  -- is still the semicolon. Disable the key completely in Wezterm, which does
  -- not write the semicolon but keeps dead key combinations.
  {
    key = 'phys:Semicolon',
    action = wezterm.action.Nop,
  },
  {
    key = 'phys:Semicolon',
    mods = 'SHIFT',
    action = wezterm.action.Nop,
  },
  {
    key = 'UpArrow',
    mods = 'SHIFT',
    action = wezterm.action.ScrollToPrompt(-1)
  },
  {
    key = 'DownArrow',
    mods = 'SHIFT',
    action = wezterm.action.ScrollToPrompt(1)
  },
}

-- Select the output of a command (requires shell integration)
config.mouse_bindings = {
  {
    event = { Down = { streak = 4, button = 'Left' } },
    action = wezterm.action.SelectTextAtMouseCursor 'SemanticZone',
    mods = 'NONE',
  },
}

-- config.debug_key_events = true

config.warn_about_missing_glyphs = false

config.audible_bell = "Disabled"

--
-- Window title
--

local function basename(s)
  return string.gsub(s, '.*[/\\](.*)', '%1')
end

local function url_to_path(s)
  return string.gsub(s, '^[^/]+://[^/]+(/.*)', '%1')
end

local function shexec(command)
  local handle = io.popen(command)
  if handle == nil then
    return ""
  end

  local result = handle:read("*a")
  handle:close()
  return result
end

wezterm.on(
  'format-window-title',
  function(tab, pane, tabs, panes, config)
    local pname = basename(pane.foreground_process_name)

    if pname == "zsh" then
      pname = ""
    else
      pname = "(" .. pname .. ") "
    end

    local cwd = url_to_path(tostring(pane.current_working_dir))

    local command = "git -C '" .. cwd .. "' rev-parse --show-toplevel 2>/dev/null || true"
    local git_repo_name = ""
    local git_top_level = shexec(command):gsub('[\n\r]', '')

    if git_top_level ~= "" then
      git_repo_name = "[" .. basename(git_top_level) .. "]"
      local git_top_level_len = string.len(git_top_level)
      local cwd_len = string.len(cwd)
      cwd = string.sub(cwd, git_top_level_len + 2, cwd_len)
      if cwd ~= "" then
        cwd = "/" .. cwd
      end
    end

    return pname .. git_repo_name .. cwd
  end)


--
-- Quick select custom patterns
--

config.quick_select_patterns = {

  -- CUSTOM

  -- Kernel configuration name. Parenthesis
  -- removes the unrequired CONFIG_ prefix.
  'CONFIG_([A-Z0-9_]+)',

  -- CVEs
  'CVE-[0-9]{4}-[0-9]+',

  -- Email headers
  '(?i)Message-Id: <(.+)>',
  'From: (.+?>)',
  'To: (.+?>)',
  'Signed-off-by: (.+?>)',
  'Cc: (.+?>)',

  -- menuconfig
  'Symbol: ([A-Z0-9_]+) \\[',

  -- ${PN}-...
  '\\$\\{PN\\}-([a-z-0-9]+) ',

  -- Yocto variables
  -- '[A-Z_]+',

  -- by ty -l
  ' {1,2}([0-9]+):.*PATCH.*',
}


return config

-- Following options are the default
-- Each of these are documented in `:help nvim-tree.OPTION_NAME`

local status_ok, nvim_tree

status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

nvim_tree.setup {
  disable_netrw = false,
  hijack_netrw = true,
  hijack_cursor = false,
  update_cwd = true,
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  diagnostics = {
    enable = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
    ignore_list = {},
  },
  filters = {
    dotfiles = true,
    custom = {
      "cscope.in.out",
      "cscope.out",
      "cscope.po.out",
    },
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 500,
  },
  actions = {
    open_file = {
      quit_on_open = false,
      resize_window = true,
      window_picker = {
        enable = false,
      }
    }
  },
  view = {
    width = 30,
    hide_root_folder = false,
    side = "left",
    mappings = {
      custom_only = false,
      list = {
        { key = { "<CR>", "o", "<2-LeftMouse>" }, action = "edit" },
        { key = "<C-e>",                          action = "" },
        { key = "O",                              action = "edit_no_picker" },
        { key = { "<C-]>", "<2-RightMouse>" },    action = "cd" },
        { key = "s",                              action = "vsplit" },
        { key = "S",                              action = "split" },
        { key = "t",                              action = "tabnew" },
        { key = "<",                              action = "prev_sibling" },
        { key = ">",                              action = "next_sibling" },
        { key = "P",                              action = "parent_node" },
        { key = "<BS>",                           action = "close_node" },
        { key = "<Tab>",                          action = "preview" },
        { key = "K",                              action = "first_sibling" },
        { key = "J",                              action = "last_sibling" },
        { key = "I",                              action = "toggle_git_ignored" },
        { key = "H",                              action = "toggle_dotfiles" },
        { key = "U",                              action = "toggle_custom" },
        { key = "R",                              action = "refresh" },
        { key = "a",                              action = "create" },
        { key = "d",                              action = "remove" },
        { key = "D",                              action = "trash" },
        { key = "r",                              action = "rename" },
        { key = "<C-r>",                          action = "full_rename" },
        { key = "x",                              action = "cut" },
        { key = "c",                              action = "copy" },
        { key = "p",                              action = "paste" },
        { key = "y",                              action = "copy_name" },
        { key = "Y",                              action = "copy_path" },
        { key = "gy",                             action = "copy_absolute_path" },
        { key = "[e",                             action = "prev_diag_item" },
        { key = "<C-f>",                          action = "prev_git_item" },
        { key = "]e",                             action = "next_diag_item" },
        { key = "<C-g>",                          action = "next_git_item" },
        { key = "-",                              action = "dir_up" },
        { key = "<leader>s",                      action = "system_open" },
        { key = "f",                              action = "live_filter" },
        { key = "F",                              action = "clear_live_filter" },
        { key = "q",                              action = "close" },
        { key = "W",                              action = "collapse_all" },
        { key = "E",                              action = "expand_all" },
        { key = "<leader>S",                      action = "search_node" },
        { key = ".",                              action = "run_file_command" },
        { key = "<C-k>",                          action = "toggle_file_info" },
        { key = "g?",                             action = "toggle_help" },
        { key = "m",                              action = "toggle_mark" },
        { key = "bmv",                            action = "bulk_move" },
      },
    },
    number = false,
    relativenumber = false,
  },
  -- git_hl = 1,
  renderer = {
    root_folder_modifier = ":t",
    icons = {
      show = {
        git = true,
        folder = true,
        file = true,
        folder_arrow = true,
      },
      glyphs = {
        default = "",
        symlink = "",
        git = {
          unstaged = "",
          staged = "S",
          unmerged = "",
          renamed = "➜",
          deleted = "",
          untracked = "U",
          ignored = "◌",
        },
        folder = {
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
        },
      },
    },
  },
}

-- Opening and closing nvim-tree resizes the dapui left column.
-- This code below adds an event that resets the dapui interface
-- when nvim-tree is closed only if one of them is already open.
-- This is done by simply resetting the UI to its defaults.
local dapui, status_ok_dapui
status_ok_dapui, dapui = pcall(require, "dapui")
if status_ok_dapui then
  local api = require("nvim-tree.api")
  local event = api.events.Event
  api.events.subscribe(event.TreeClose, function()
    local bufs = vim.api.nvim_list_bufs()
    for bufno, _ in pairs(bufs) do
      local bufname
      _, bufname = pcall(vim.api.nvim_buf_get_name, bufno)
      if string.find(bufname, "DAP REPL$") then
        dapui.open({ reset = true })
        break
      end
    end
  end)
end

local function on_attach(bufnr)

  local api = require('nvim-tree.api')

  local function opts(desc)
    return {
      desc = 'nvim-tree: ' .. desc,
      buffer = bufnr,
      noremap = true,
      silent = true,
      nowait = true
    }
  end

  vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', '<2-LeftMouse>', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', 'O', api.node.open.no_window_picker, opts('Open: No Window Picker'))
  vim.keymap.set('n', '<C-]>', api.tree.change_root_to_node, opts('CD'))
  vim.keymap.set('n', '<2-RightMouse>', api.tree.change_root_to_node, opts('CD'))
  vim.keymap.set('n', 's', api.node.open.vertical, opts('Open: Vertical Split'))
  vim.keymap.set('n', 'S', api.node.open.horizontal, opts('Open: Horizontal Split'))
  vim.keymap.set('n', 't', api.node.open.tab, opts('Open: New Tab'))
  vim.keymap.set('n', '<', api.node.navigate.sibling.prev, opts('Previous Sibling'))
  vim.keymap.set('n', '>', api.node.navigate.sibling.next, opts('Next Sibling'))
  vim.keymap.set('n', 'P', api.node.navigate.parent, opts('Parent Directory'))
  vim.keymap.set('n', '<BS>', api.node.navigate.parent_close, opts('Close Directory'))
  vim.keymap.set('n', '<Tab>', api.node.open.preview, opts('Open Preview'))
  vim.keymap.set('n', 'K', api.node.navigate.sibling.first, opts('First Sibling'))
  vim.keymap.set('n', 'J', api.node.navigate.sibling.last, opts('Last Sibling'))
  vim.keymap.set('n', 'I', api.tree.toggle_gitignore_filter, opts('Toggle Git Ignore'))
  vim.keymap.set('n', 'H', api.tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
  vim.keymap.set('n', 'U', api.tree.toggle_custom_filter, opts('Toggle Hidden'))
  vim.keymap.set('n', 'R', api.tree.reload, opts('Refresh'))
  vim.keymap.set('n', 'a', api.fs.create, opts('Create'))
  vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
  vim.keymap.set('n', 'D', api.fs.trash, opts('Trash'))
  vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
  vim.keymap.set('n', '<C-r>', api.fs.rename_sub, opts('Rename: Omit Filename'))
  vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
  vim.keymap.set('n', 'c', api.fs.copy.node, opts('Copy'))
  vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
  vim.keymap.set('n', 'y', api.fs.copy.filename, opts('Copy Name'))
  vim.keymap.set('n', 'Y', api.fs.copy.relative_path, opts('Copy Relative Path'))
  vim.keymap.set('n', 'gy', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
  vim.keymap.set('n', '[e', api.node.navigate.diagnostics.prev_recursive, opts('Prev Diagnostic Recursive'))
  vim.keymap.set('n', '<C-f>', api.node.navigate.git.prev_recursive, opts('Prev Git Recursive'))
  vim.keymap.set('n', ']e', api.node.navigate.diagnostics.next_recursive, opts('Next Diagnostic Recursive'))
  vim.keymap.set('n', '<C-g>', api.node.navigate.git.next_recursive, opts('Next Git Recursive'))
  vim.keymap.set('n', '-', api.tree.change_root_to_parent, opts('Up'))
  vim.keymap.set('n', '<leader>s', api.node.run.system, opts('Run System'))
  vim.keymap.set('n', 'f', api.live_filter.start, opts('Filter'))
  vim.keymap.set('n', 'F', api.live_filter.clear, opts('Clean Filter'))
  vim.keymap.set('n', 'q', api.tree.close, opts('Close'))
  vim.keymap.set('n', 'W', api.tree.collapse_all, opts('Collapse'))
  vim.keymap.set('n', 'E', api.tree.expand_all, opts('Expand All'))
  vim.keymap.set('n', '<leader>S', api.tree.search_node, opts('Search'))
  vim.keymap.set('n', '.', api.node.run.cmd, opts('Run Command'))
  vim.keymap.set('n', '<C-k>', api.node.show_info_popup, opts('Info'))
  vim.keymap.set('n', 'g?', api.tree.toggle_help, opts('Help'))
  vim.keymap.set('n', 'm', api.marks.toggle, opts('Toggle Bookmark'))
  vim.keymap.set('n', 'bmv', api.marks.bulk.move, opts('Move Bookmarked'))
  vim.keymap.set('n', ']o', function() api.node.navigate.opened.next() end, opts('Next Opened'))
  vim.keymap.set('n', '[o', api.node.navigate.opened.prev, opts('Next Opened'))

end

local options = {
  disable_netrw = false,
  hijack_netrw = true,
  hijack_cursor = false,
  update_cwd = true,
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  on_attach = on_attach,
  diagnostics = {
    enable = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
    show_on_dirs = true,
    show_on_open_dirs = false,
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
    show_on_dirs = true,
    show_on_open_dirs = false,
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
    side = "left",
    number = false,
    relativenumber = false,
  },
  -- git_hl = 1,
  renderer = {
    root_folder_modifier = ":t",
    full_name = true,  -- Display name in full when too big.
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
-- local dapui, status_ok_dapui
-- status_ok_dapui, dapui = pcall(require, "dapui")
-- if status_ok_dapui then
--   local api = require("nvim-tree.api")
--   local event = api.events.Event
--   api.events.subscribe(event.TreeClose, function()
--     local bufs = vim.api.nvim_list_bufs()
--     for bufno, _ in pairs(bufs) do
--       local bufname
--       _, bufname = pcall(vim.api.nvim_buf_get_name, bufno)
--       if string.find(bufname, "DAP REPL$") then
--         dapui.open({ reset = true })
--         break
--       end
--     end
--   end)
-- end

return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup(options)
  end,
}

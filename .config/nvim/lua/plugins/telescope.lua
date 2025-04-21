local function livegreprecursive(p_bufnr)
  -- send results to quick fix list
  require("telescope.actions").send_to_qflist(p_bufnr)
  local qflist = vim.fn.getqflist()
  local paths = {}
  local hash = {}
  for k in pairs(qflist) do
    local path = vim.fn.bufname(qflist[k]["bufnr"]) -- extract path from quick fix list
    if not hash[path] then -- add to paths table, if not already appeared
      paths[#paths + 1] = path
      hash[path] = true -- remember existing paths
    end
  end
  -- show search scope with message
  vim.notify("find in ...\n  " .. table.concat(paths, "\n  "))
  -- execute live_grep_args with search scope
  require("telescope").extensions.live_grep_args.live_grep_args({ search_dirs = paths })
end

return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-media-files.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "cmake -S. -Bbuild -DCMAKE_POLICY_VERSION_MINIMUM=3.5 -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
    },
    { "nvim-telescope/telescope-live-grep-args.nvim" },
  },
  config = function()
    local actions = require("telescope.actions")
    local telescope = require("telescope")

    telescope.setup({
      defaults = {

        prompt_prefix = " → ",
        selection_caret = " ",
        path_display = { "truncate" },

        mappings = {
          i = {
            ["<C-r>"] = {
              livegreprecursive,
              type = "action",
              opts = {
                nowait = true,
                silent = true,
                desc = "Live grep on results",
              },
            },

            ["<C-n>"] = actions.cycle_history_next,
            ["<C-p>"] = actions.cycle_history_prev,

            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,

            ["<C-c>"] = actions.close,

            ["<Down>"] = actions.move_selection_next,
            ["<Up>"] = actions.move_selection_previous,

            ["<CR>"] = actions.select_default,
            ["<C-i>"] = actions.select_horizontal,
            ["<C-s>"] = actions.select_vertical,
            ["<C-t>"] = actions.select_tab,

            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,

            ["<PageUp>"] = actions.results_scrolling_up,
            ["<PageDown>"] = actions.results_scrolling_down,

            ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
            ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["<C-l>"] = actions.complete_tag,
            ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
          },

          n = {
            ["<C-r>"] = {
              livegreprecursive,
              type = "action",
              opts = {
                nowait = true,
                silent = true,
                desc = "Live grep on results",
              },
            },

            ["<esc>"] = actions.close,
            ["<CR>"] = actions.select_default,
            ["<C-x>"] = actions.select_horizontal,
            ["<C-v>"] = actions.select_vertical,
            ["<C-t>"] = actions.select_tab,

            ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
            ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

            ["j"] = actions.move_selection_next,
            ["k"] = actions.move_selection_previous,
            ["H"] = actions.move_to_top,
            ["M"] = actions.move_to_middle,
            ["L"] = actions.move_to_bottom,

            ["<Down>"] = actions.move_selection_next,
            ["<Up>"] = actions.move_selection_previous,
            ["gg"] = actions.move_to_top,
            ["G"] = actions.move_to_bottom,

            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,

            ["<PageUp>"] = actions.results_scrolling_up,
            ["<PageDown>"] = actions.results_scrolling_down,

            ["?"] = actions.which_key,
          },
        },
      },
      pickers = {
        -- Default configuration for builtin pickers goes here:
        -- picker_name = {
        --   picker_config_key = value,
        --   ...
        -- }
        -- Now the picker_config_key will be applied every time you call this
        -- builtin picker
      },
      extensions = {
        media_files = {
          -- filetypes whitelist
          -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
          filetypes = { "png", "webp", "jpg", "jpeg" },
          find_cmd = "rg", -- find command (defaults to `fd`)
        },
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = "smart_case", -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        },
        -- Your extension configuration goes here:
        -- extension_name = {
        --   extension_config_key = value,
        -- }
        -- please take a look at the readme of the extension you want to configure
      },
    })
    telescope.load_extension("live_grep_args")
    telescope.load_extension("media_files")
    telescope.load_extension("fzf")
  end,
}

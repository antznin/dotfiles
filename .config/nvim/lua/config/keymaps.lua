local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

--
-- Vim keymaps
--

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":BufferLineCycleNext<CR>", opts)
keymap("n", "<S-h>", ":BufferLineCyclePrev<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Quit all
keymap("n", "<C-q>", ":wqa<CR>", opts)

-- Move between tabs
keymap("n", "<A-l>", ":tabnext<CR>", opts)
keymap("n", "<A-h>", ":tabprevious<CR>", opts)
-- Create new tab
keymap("n", "<A-t>", ":tabnew<CR>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- RST mappings
keymap("v", "<C-i>", 'mtc`<C-r>"`<esc>`t', opts)  -- surround `
keymap("v", "<C-x>", 'mtc``<C-r>"``<esc>`t', opts)   -- surround ``

-- Contract to "[...]"
keymap("v", "<C-e>", 'c[...]<esc>j', { noremap = true, silent = true })

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Move file to `where` and notify.
local function move_to(where)
  local path = vim.api.nvim_buf_get_name(0)
  if string.sub(path, -5) == "patch" then
    local parent = vim.fs.dirname(path)
    local source = vim.fs.basename(parent)
    local filename = vim.fs.basename(path)
    vim.system({'mv', '-v', path, parent .. "/" .. where})
    vim.notify("Moved file:\n" .. filename .. "\n" .. source .. " 🡒 " .. where)
    vim.cmd("Bdelete")
  end
end

local function move_to_done()
  move_to("../done/")
end

local function move_to_todo()
  move_to("../todo/")
end

local function move_to_unreviewed()
  move_to("../unreviewed/")
end

-- Quick moves for patch reviews.
vim.keymap.set("n", "<leader>md", move_to_done, opts)
vim.keymap.set("n", "<leader>mt", move_to_todo, opts)
vim.keymap.set("n", "<leader>mu", move_to_unreviewed, opts)

-- Spell checking
local function toggle_spell_check()
  vim.opt.spell = not (vim.opt.spell:get())
end

vim.keymap.set("n", "<leader>ts", toggle_spell_check, opts)

--
-- Telescope
--

-- Return what's under the visual selection
local function _get_visual_selection()
  local s_start = vim.fn.getpos("'<")
  local s_end = vim.fn.getpos("'>")
  local n_lines = math.abs(s_end[2] - s_start[2]) + 1
  local lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)
  lines[1] = string.sub(lines[1], s_start[3], -1)
  if n_lines == 1 then
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
  else
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
  end
  return table.concat(lines, "\n")
end

-- Try git_files. If not in a repository, will fallback on find_files.
local function _telescope_try_git_files(find_opts)
  local builtin = require("telescope.builtin")
  local status_ok, _ = pcall(builtin.git_files)
  if not status_ok then
    builtin.find_files(find_opts)
  end
end

vim.keymap.set("n", "<leader>f", _telescope_try_git_files, opts)

-- Search dotfiles
local function _telescope_find_dotfiles()
  require("telescope.builtin").find_files({
    prompt_title = "Find dotfiles",
    cwd = vim.env.HOME,
    find_command = {
      "git",
      "--git-dir", vim.env.HOME .. "/.dotfiles",
      "--work-tree", vim.env.HOME,
      "ls-files",
      "--exclude-standard",
      "--cached"
    }
  })
end
vim.keymap.set("n", "<leader>u", _telescope_find_dotfiles, opts)

local function _telescope_yank_live_grep()
  require("telescope.builtin").live_grep({ default_text = _get_visual_selection() })
end
vim.keymap.set("v", "<c-t>", _telescope_yank_live_grep, opts)

keymap("n", "<C-t>", "<cmd>Telescope live_grep<cr>", opts)
keymap("n", "<leader>g", "<cmd>Telescope find_files<cr>", opts)
keymap("n", "<leader>n", "<cmd>Telescope notify<cr>", opts) -- Requires nvim-notify
keymap("n", "<leader>d", "<cmd>Telescope lsp_workspace_symbols<cr>", opts)
keymap("n", "<leader>r", "<cmd>Telescope lsp_document_symbols<cr>", opts)

--
-- Gitsigns
--

keymap("n", "<C-g>", ":Gitsigns next_hunk<CR>", opts)
keymap("n", "<C-f>", ":Gitsigns prev_hunk<CR>", opts)
keymap("n", "<leader>lb", ":Gitsigns toggle_current_line_blame<CR>", opts)

--
-- nvim-tree
--

keymap("n", "<C-e>", ":NvimTreeToggle<CR>", opts)

--
-- Bufferline
--

keymap("n", "<C-w>", ":Bdelete<CR>", { noremap = true, silent = true, nowait = true })
keymap("n", "<A-h>", ":BufferLineMovePrev<CR>", { noremap = true, silent = true, nowait = true })
keymap("n", "<A-l>", ":BufferLineMoveNext<CR>", { noremap = true, silent = true, nowait = true })

--
-- Luasnip
--

keymap("i", "<C-n>", "<Plug>luasnip-next-choice", {})
keymap("i", "<C-p>", "<Plug>luasnip-prev-choice", {})

--
-- Replacer
--

keymap("n", "<leader>rr", "<cmd>lua require('replacer').run({ rename_files = false, })<cr>", opts)

--
-- Toggle Fullscreen (caenrique/nvim-maximize-window-toggle)
--

keymap("n", "<leader>o", "<cmd>ToggleOnly<cr>", opts)

--
-- LSP
--

-- Global LSP mappings.
keymap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
keymap("n", "<C-z>", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opts)
keymap("n", "<C-c>", "<cmd>Lspsaga diagnostic_jump_next<cr>", opts)
keymap("n", "<space>q", "<cmd>lua vim.diagnostic.setloclist()<cr>", opts)

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP keymaps',
  callback = function(event)
    local opts = {buffer = event.buf}
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<cr>", opts)
    vim.keymap.set("n", "<leader>D", "<cmd>Lspsaga peek_definition<cr>", opts)
    vim.keymap.set("n", "<leader>k", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<cr>", opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>O", "<cmd>Lspsaga outline<cr>", opts)
    vim.keymap.set("n", "<leader>lr", "<cmd>Lspsaga finder<cr>", opts)
  end,
})

--
-- DAP (unused)
--

-- keymap("n", "<F5>", "<cmd>lua require('dap').continue()<cr>", opts)
-- keymap("n", "<F10>", "<cmd>lua require('dap').step_over()<cr>", opts)
-- keymap("n", "<F11>", "<cmd>lua require('dap').step_into()<cr>", opts)
-- keymap("n", "<F12>", "<cmd>lua require('dap').step_out()<cr>", opts)
-- keymap("n", "<leader>b", "<cmd>lua require('dap').toggle_breakpoint()<cr>", opts)
-- keymap("n", "<leader>B", "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", opts)
-- keymap(
--   "n",
--   "<leader>lp",
--   "<cmd>lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>",
--   opts
-- )
-- keymap("n", "<leader>du", "<cmd>lua require('dapui').toggle()<cr>", opts)

--
-- Toggle wrapping
--

local function toggle_line_wrapping()
  textwidth = vim.opt.textwidth._value
  if textwidth ~= 0 then
    vim.opt.textwidth = 0
    vim.notify("Line wrapping disabled")
  else
    vim.opt.textwidth = 80
    vim.notify("Line wrapping enabled")
  end
end

vim.keymap.set("n", "<leader>lw", toggle_line_wrapping, opts)

--
-- Trim
--

keymap("n", "<leader>tt", "<cmd>Trim<cr>", opts)

--
-- Git fugitive
--

keymap("n", "<leader>gc", ":Git cof -s<CR>", opts)

--
-- Zen mode
--

keymap("n", "<leader>zz", ":ZenMode<CR>", opts)

--
-- Formatter
--

keymap("n", "<leader>wf", ":Format<CR>", opts)

-- Return keymaps used by other files.
return {
  lsp_keymaps = lsp_keymaps,
}

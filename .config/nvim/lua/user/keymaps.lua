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
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

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

-- Insert --
-- Press kj fast to enter
keymap("i", "kj", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

--
-- Telescope
--

-- Try git_files. If not in a repository, will fallback on find_files.
local telescope_try_git_giles = function ()
	local builtin = require("telescope.builtin")
	local status_ok, _ = pcall(builtin.git_files)
	if not status_ok then
		builtin.find_files()
	end
end

vim.keymap.set("n", "<leader>f", telescope_try_git_giles, opts)
keymap("n", "<leader>g", "<cmd>Telescope find_files<cr>", opts)
keymap("n", "<C-t>", "<cmd>Telescope live_grep<cr>", opts)
keymap("n", "<C-s>", "<cmd>Telescope grep_string<cr>", opts)
keymap("n", "<leader>n", "<cmd>Telescope notify<cr>", opts) -- Requires nvim-notify

local toggleterm_keymaps = function(bufnr)
	local bufopts = { noremap = true }
	-- vim.api.nvim_buf_set_keymap(bufnr, 't', '<esc>', [[<C-\><C-n>]], bufopts)
	vim.api.nvim_buf_set_keymap(bufnr, 't', 'jk', [[<C-\><C-n>]], bufopts)
	vim.api.nvim_buf_set_keymap(bufnr, 't', '<C-h>', [[<C-\><C-n><C-W>h]], bufopts)
	vim.api.nvim_buf_set_keymap(bufnr, 't', '<C-j>', [[<C-\><C-n><C-W>j]], bufopts)
	vim.api.nvim_buf_set_keymap(bufnr, 't', '<C-k>', [[<C-\><C-n><C-W>k]], bufopts)
	vim.api.nvim_buf_set_keymap(bufnr, 't', '<C-l>', [[<C-\><C-n><C-W>l]], bufopts)
end

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
-- Toggleterm
--

keymap("n", "<leader>yp", ":lua _PYTHON_TOGGLE()<CR>", opts)
keymap("n", "<leader>yn", ":lua _NCDU_TOGGLE()<CR>", opts)
keymap("n", "<leader>yh", ":lua _HTOP_TOGGLE()<CR>", opts)
keymap("n", "<leader>yt", ":lua _TSHELL_TOGGLE()<CR>", opts)
keymap("n", "<leader>yl", ":lua _LAZYGIT_TOGGLE()<CR>", opts)
keymap("n", "<leader>yw", ":lua _WALOG_TOGGLE()<CR>", opts)

--
-- Bufferline
--

keymap("n", "<C-w>", ":Bdelete<CR>", opts)

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
keymap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<cr>', opts)

-- Called by mason.lua.
local lsp_keymaps = function(bufnr)
	local bufopts = { noremap = true, silent = true, buffer = bufnr }

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
	vim.keymap.set('n', '<leader>k', vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
	vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
	vim.keymap.set('n', '<leader>wf', function() vim.lsp.buf.format { async = true } end, bufopts)
	vim.keymap.set('n', '<leader>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
end

--
-- DAP
--

keymap("n", "<F5>", "<cmd>lua require('dap').continue()<cr>", opts)
keymap("n", "<F10>", "<cmd>lua require('dap').step_over()<cr>", opts)
keymap("n", "<F11>", "<cmd>lua require('dap').step_into()<cr>", opts)
keymap("n", "<F12>", "<cmd>lua require('dap').step_out()<cr>", opts)
keymap("n", "<leader>b", "<cmd>lua require('dap').toggle_breakpoint()<cr>", opts)
keymap(
	"n",
	"<leader>B",
	"<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
	opts)
keymap(
	"n",
	"<leader>lp",
	"<cmd>lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>",
	opts)
keymap("n", "<leader>du", "<cmd>lua require('dapui').toggle()<cr>", opts)

-- Return keymaps used by other files.
return {
	lsp_keymaps = lsp_keymaps,
	toggleterm_keymaps = toggleterm_keymaps,
}

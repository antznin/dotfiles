local options = {
  backup = false,                          -- creates a backup file
  clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
  cmdheight = 1,                           -- more space in the neovim command line for displaying messages
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0,                        -- so that `` is visible in markdown files
  fileencoding = "utf-8",                  -- the encoding written to a file
  hlsearch = true,                         -- highlight all matches on previous search pattern
  inccommand = "split",                    -- "for incsearch while sub
  ignorecase = true,                       -- ignore case in search patterns
  mouse = "a",                             -- allow the mouse to be used in neovim
  pumheight = 10,                          -- pop up menu height
  showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
  showtabline = 2,                         -- always show tabs
  smartcase = true,                        -- smart case
  smartindent = true,                      -- make indenting smarter again
  splitbelow = true,                       -- force all horizontal splits to go below current window
  splitright = true,                       -- force all vertical splits to go to the right of current window
  swapfile = false,                        -- creates a swapfile
  termguicolors = true,                    -- set term gui colors (most terminals support this)
  timeoutlen = 1000,                        -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true,                         -- enable persistent undo
  updatetime = 300,                        -- faster completion (4000ms default)
  writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  expandtab = true,                        -- convert tabs to spaces
  shiftwidth = 2,                          -- the number of spaces inserted for each indentation
  tabstop = 2,                             -- insert 2 spaces for a tab
  cursorline = true,                       -- highlight the current line
  number = true,                           -- set numbered lines
  relativenumber = true,                   -- set relative numbered lines
  numberwidth = 2,                         -- set number column width to 2 {default 4}
  signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time
  wrap = true,                             -- display lines as one long line
  scrolloff = 8,                           -- is one of my fav
  sidescrolloff = 8,
  guifont = "monospace:h17",               -- the font used in graphical neovim applications
  foldmethod = "expr",
  foldexpr = "nvim_treesitter#foldexpr()", -- use tree-sitter folding
  foldenable = false,                      -- disable folding at startup
  textwidth = 80,
  colorcolumn = "81",                      -- Colored column.
  spelllang = "en_us",                     -- English by default.
}

-- don't give ins-completion-menu messages; for example, "-- XXX completion
-- (YYY)", "match 1 of 2", "The only match", "Pattern not found", "Back at
-- original", etc.
vim.opt.shortmess:append "c"

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.api.nvim_create_augroup('NeovimConfig', {})
vim.api.nvim_create_autocmd('BufWritePost', {
  group = 'NeovimConfig',
  pattern = 'init.lua',
  command = "source %",
  desc = 'Auto-reload the configuration.',
})

-- Search with `*`, but don't jump dirst and don't add to jump list.
vim.cmd "nnoremap * :keepjumps normal! mi*`i<CR>"

-- Requires commentary.vim
vim.api.nvim_create_user_command(
  'CopyCommentPaste',
  [[
    silent exec 'Commentary'
    silent exec 'normal! yyp'
    silent exec 'Commentary'
]],
  {}
)
vim.cmd "nnoremap <silent> gcp :CopyCommentPaste<CR>"

-- Make :W, :Q, … act the same as :w, :q, … as I always make these errors.
vim.cmd "command! W write"
vim.cmd "command! Q quit"
vim.cmd "command! Wq wq"
vim.cmd "command! WQ wq"
vim.cmd "command! Wqa wqa"
vim.cmd "command! WQa wqa"

-- makes * and # work on visual mode too.
vim.api.nvim_exec(
  [[
  function! g:VSetSearch(cmdtype)
    let temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
    let @s = temp
  endfunction

  xnoremap * :<C-u>call g:VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
  xnoremap # :<C-u>call g:VSetSearch('?')<CR>?<C-R>=@/<CR><CR>
]],
  false
)

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]

-- Markdown: don't consider bullet points as comments.
-- vim.cmd "au FileType markdown setl comments=n:>"
-- vim.opt.showbreak = "  "
vim.cmd [[let &formatlistpat='^\s*\d\+\.\s\+\|^[-*+]\s\+']]
vim.cmd [[set formatoptions+=n]]

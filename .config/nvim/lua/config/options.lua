local options = {
  backup = false, -- creates a backup file
  clipboard = "unnamedplus", -- allows neovim to access the system clipboard
  cmdheight = 1, -- more space in the neovim command line for displaying messages
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0, -- so that `` is visible in markdown files
  fileencoding = "utf-8", -- the encoding written to a file
  hlsearch = true, -- highlight all matches on previous search pattern
  inccommand = "split", -- "for incsearch while sub
  ignorecase = true, -- ignore case in search patterns
  mouse = "a", -- allow the mouse to be used in neovim
  pumheight = 10, -- pop up menu height
  showmode = false, -- we don't need to see things like -- INSERT -- anymore
  showtabline = 2, -- always show tabs
  smartcase = true, -- smart case
  smartindent = true, -- make indenting smarter again
  splitbelow = true, -- force all horizontal splits to go below current window
  splitright = true, -- force all vertical splits to go to the right of current window
  swapfile = false, -- creates a swapfile
  termguicolors = true, -- set term gui colors (most terminals support this)
  timeoutlen = 1000, -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true, -- enable persistent undo
  updatetime = 300, -- faster completion (4000ms default)
  writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  expandtab = true, -- convert tabs to spaces
  shiftwidth = 2, -- the number of spaces inserted for each indentation
  tabstop = 2, -- insert 2 spaces for a tab
  cursorline = true, -- highlight the current line
  number = true, -- set numbered lines
  relativenumber = false, -- set relative numbered lines
  numberwidth = 2, -- set number column width to 2 {default 4}
  signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
  wrap = true, -- display lines as one long line
  scrolloff = 8, -- is one of my fav
  sidescrolloff = 8,
  guifont = "monospace:h17", -- the font used in graphical neovim applications
  foldmethod = "expr",
  foldexpr = "nvim_treesitter#foldexpr()", -- use tree-sitter folding
  foldenable = false, -- disable folding at startup
  textwidth = 80,
  colorcolumn = "81", -- Colored column.
  spelllang = "en_us", -- English by default.
  shell = "/usr/bin/zsh",
}

-- don't give ins-completion-menu messages; for example, "-- XXX completion
-- (YYY)", "match 1 of 2", "The only match", "Pattern not found", "Back at
-- original", etc.
vim.opt.shortmess:append("c")

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd('set list')
vim.cmd('set listchars=tab:»\\ ,extends:›,precedes:‹,nbsp:·,trail:·')

-- Search with `*`, but don't jump dirst and don't add to jump list.
vim.cmd("nnoremap * :keepjumps normal! mi*`i<CR>")

-- Requires commentary.vim
vim.api.nvim_create_user_command(
  "CopyCommentPaste",
  [[
    silent exec 'Commentary'
    silent exec 'normal! yyp'
    silent exec 'Commentary'
]],
  {}
)
vim.cmd("nnoremap <silent> gcp :CopyCommentPaste<CR>")

-- Make :W, :Q, … act the same as :w, :q, … as I always make these errors.
vim.cmd("command! W write")
vim.cmd("command! Q quit")
vim.cmd("command! Wq wq")
vim.cmd("command! WQ wq")
vim.cmd("command! Wqa wqa")
vim.cmd("command! WQa wqa")

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

vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.opt.iskeyword:append("-")

-- Markdown: don't consider bullet points as comments.
vim.cmd "au FileType markdown setl comments=n:>"
vim.opt.showbreak = "  "
vim.cmd([[let &formatlistpat='^\s*\d\+\.\s\+\|^[-*+]\s\+']])
vim.cmd([[set formatoptions+=n]])

-- Better session restore experience.
vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- Bitbake files.
vim.cmd([[
  au BufRead,BufNewFile *.bb set filetype=bitbake
  au BufRead,BufNewFile *.bbclass set filetype=bitbake
  au BufRead,BufNewFile *.bbappend set filetype=bitbake
  au BufRead,BufNewFile *.inc set filetype=bitbake
  au BufRead,BufNewFile local.conf.sample set filetype=bitbake
  au BufRead,BufNewFile bblayers.conf.sample set filetype=bitbake
]])

-- Spell file
vim.cmd("set spellfile=" .. vim.env.HOME .. "/.config/nvim/spell/en.utf-8.add")

-- Turn on spell checking
vim.cmd([[
  au BufRead,BufNewFile filetype=rst set spell
  au BufRead,BufNewFile filetype=md  set spell
  au BufRead,BufNewFile filetype=gitcommit set spell
  au BufRead,BufNewFile filetype=mail set spell
]])

-- Turn on exrc
-- Place files called .nvim.lua in project directories to have special autocmd
-- executed when running nvim from there.
vim.cmd([[
  set exrc
]])

-- Jump options, go back to closed buffer with ctrl-o
vim.cmd([[
  set jumpoptions-=clean
]])

-- Custom colors for emails
-- From the catpuccin palette
vim.cmd([[
  hi mailQuoted1 guifg=#6c6f85
  hi mailQuoted2 guifg=#696969
  hi mailQuoted3 guifg=#6c6f85
  hi mailQuoted4 guifg=#696969
  hi mailQuoted5 guifg=#6c6f85
  hi mailQuoted6 guifg=#696969
  hi mailQuotedDiffPlus1 guifg=#6c6f85 guibg=#d0ffd0
  hi mailQuotedDiffMinus1 guifg=#6c6f85 guibg=#ffe0e0
]])

-- Display aerc emails with custom syntax file.
-- Open them in zen mode.
vim.cmd([[
  au BufRead aerc-compose-*.eml setlocal filetype=custom_mail
]])


"""""""""""""""""
" VUNDLE CONFIG "
"""""""""""""""""

set nocompatible
filetype off

" Map leader to space
let mapleader ="\<Space>"

set shell=/bin/bash

call plug#begin('~/.vim/plugged')

" PLUGINS "

Plug 'tpope/vim-fugitive'
" Plug 'godlygeek/tabular'
Plug 'wincent/terminus'
Plug 'honza/vim-snippets'
Plug 'terryma/vim-multiple-cursors'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
" Plug 'tmhedberg/SimpylFold'
Plug 'kergoth/vim-bitbake'
" Plug 'plasticboy/vim-markdown'
Plug 'airblade/vim-gitgutter'
"Plug 'mzlogin/vim-markdown-toc'
Plug 'ctrlpvim/ctrlp.vim'
    let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:0'
    let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
    if executable('ag')
        let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
    endif

" Plug 'neoclide/coc.nvim', {'branch': 'release'}
"     " TextEdit might fail if hidden is not set.
"     " set hidden
"     " Give more space for displaying messages.
"     set cmdheight=2
"     " Don't pass messages to |ins-completion-menu|.
"     set shortmess+=c
"     " Always show the signcolumn, otherwise it would shift the text each time
"     " diagnostics appear/become resolved.
"     if has("patch-8.1.1564")
"       " Recently vim can merge signcolumn and number column into one
"       set signcolumn=number
"     else
"       set signcolumn=yes
"     endif
"     " Use tab for trigger completion with characters ahead and navigate.
"     " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
"     " other plugin before putting this into your config.
"     inoremap <silent><expr> <TAB>
"           \ pumvisible() ? "\<C-n>" :
"           \ <SID>check_back_space() ? "\<TAB>" :
"           \ coc#refresh()
"     inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

"     function! s:check_back_space() abort
"       let col = col('.') - 1
"       return !col || getline('.')[col - 1]  =~# '\s'
"     endfunction
"     " Use <c-space> to trigger completion.
"     inoremap <silent><expr> <c-space> coc#refresh()
"     " Make <CR> auto-select the first completion item and notify coc.nvim to
"     " format on enter, <cr> could be remapped by other vim plugin
"     inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
"                               \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
"     " GoTo code navigation.
"     nmap <silent> gd <Plug>(coc-definition)
"     nmap <silent> gy <Plug>(coc-type-definition)
"     nmap <silent> gi <Plug>(coc-implementation)
"     nmap <silent> gr <Plug>(coc-references)
"     " Use K to show documentation in preview window.
"     nnoremap <silent> K :call <SID>show_documentation()<CR>

"     function! s:show_documentation()
"       if (index(['vim','help'], &filetype) >= 0)
"         execute 'h '.expand('<cword>')
"       elseif (coc#rpc#ready())
"         call CocActionAsync('doHover')
"       else
"         execute '!' . &keywordprg . " " . expand('<cword>')
"       endif
"     endfunction

"     " Coc snippets
"     " Use <C-z> for trigger snippet expand.
"     imap <C-z> <Plug>(coc-snippets-expand)
"     " Use <C-z> for select text for visual placeholder of snippet.
"     vmap <C-z> <Plug>(coc-snippets-select)
"     " Use <C-j> for jump to next placeholder, it's default of coc.nvim
"     let g:coc_snippet_next = '<c-z>'
"     " Use <C-k> for jump to previous placeholder, it's default of coc.nvim
"     let g:coc_snippet_prev = '<c-a>'
"     " Highlight the symbol and its references when holding the cursor.
"     autocmd CursorHold * silent call CocActionAsync('highlight')
"     " Symbol renaming.
"     nmap <leader>rn <Plug>(coc-rename)
"     " Formatting selected code.
"     xmap <leader>f  <Plug>(coc-format-selected)
"     nmap <leader>f  <Plug>(coc-format-selected)

"     " spell check
"     vmap <leader>a <Plug>(coc-codeaction-selected)
" "     nmap <leader>a <Plug>(coc-codeaction-selected)


" Plug 'dense-analysis/ale'
"     let g:ale_completion_enabled = 1
"     let g:ale_sign_column_always = 1
"     let g:ale_fixers = {
"     \   '*': ['remove_trailing_lines', 'trim_whitespace'],
"     \   'python': ['isort', 'black', 'autopep8'],
"     \}
"     let g:ale_linters = {'python': ['mypy', 'flake8', 'pylint']}
"     let g:ale_python_flake8_options = '--max-line-length=90'
"     let g:ale_python_pylint_executable = 'pylint3'

" Plug 'junegunn/goyo.vim'
"     let g:goyo_width=94
"     let g:goyo_linenr=1

"     function! s:goyo_enter()
"       let b:quitting = 0
"       let b:quitting_bang = 0
"       autocmd QuitPre <buffer> let b:quitting = 1
"       cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
"     endfunction

"     function! s:goyo_leave()
"       " Quit Vim if this is the only remaining buffer
"       if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
"         if b:quitting_bang
"           qa!
"         else
"           qa
"         endif
"       endif
"     endfunction

"   autocmd! User GoyoEnter call <SID>goyo_enter()
"   autocmd! User GoyoLeave call <SID>goyo_leave()

Plug 'scrooloose/nerdtree'
    nnoremap <C-e> :NERDTreeToggle<cr>
    let NERDTreeMinimalUI=1
    let NERDTreeAutoDeleteBuffer=1
    " let g:NERDTreeDirArrowExpandable = 'v'
    " let g:NERDTreeDirArrowCollapsible = '>'

Plug 'Xuyuanp/nerdtree-git-plugin'
    let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'✹',
                \ 'Staged'    :'+',
                \ 'Untracked' :'*',
                \ 'Renamed'   :'→',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✖',
                \ 'Dirty'     :'✗',
                \ 'Ignored'   :'☒',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \ }

Plug 'SirVer/ultisnips'
    let g:UltiSnipsSnippetsDir=$HOME.'/.vim/bundle/vim-snippets/UltiSnips'
    let g:UltiSnipsSnippetDirectories=["UltiSnips"]
    let g:UltiSnipsExpandTrigger="<c-z>"
    let g:UltiSnipsJumpForwardTrigger="<c-z>"
    let g:UltiSnipsJumpBackwardTrigger="<c-b>"
    let g:UltiSnipsListSnippets="<c-l>"
    let g:UltiSnipsEditSplit="vertical"

Plug 'vim-airline/vim-airline'
    let g:airline_powerline_fonts = 1
    " let g:airline#extensions#tabline#enabled = 1
    let g:airline_section_y=''
    " let g:airline#extensions#tabline#fnamemod = ':t' " Show just the filename

" Plug 'lervag/vimtex'
"     let g:polyglot_disabled = ['latex']
"     let g:tex_flavor='latex'
"     let g:vimtex_view_method='zathura'
"     let g:vimtex_quickfix_mode=0

" Plug 'lifepillar/vim-mucomplete'
"     set completeopt+=menuone
"     set completeopt+=noselect
"     set completeopt+=noinsert
"     set shortmess+=c
"     setlocal dictionary+=spell
"     setlocal complete+=k
"     let g:mucomplete#chains = {}
"     let g:mucomplete#chains.default = ['ulti', 'path', 'omni', 'keyn', 'dict', 'uspl']

" Plug 'Yggdroot/indentLine'
"     let g:indentLine_char = '▏'
"     " let g:indentLine_showFirstIndentLevel = 1
"     let g:indentLine_conceallevel = 0

" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'
"     " Preview window on the upper side of the window with 40% height,
"     " hidden by default, ctrl-/ to toggle
"     let g:fzf_preview_window = ['down:40%:hidden', '<Leader>p']
"     let g:fzf_buffers_jump = 1

" COLORSCHEMES "
Plug 'arcticicestudio/nord-vim'
" Plug 'ayu-theme/ayu-vim'
"     set termguicolors     " enable true colors support
"     let ayucolor="dark"   " for dark version of theme

call plug#end()

filetype plugin indent on

"""""""""""""""
" VIM RELATED "
"""""""""""""""

cd %:p:h

" Set delay
set timeoutlen=1000 ttimeoutlen=0
set updatetime=300

" Syntax and filetype
syntax on

" make backspace work like most other programs
set backspace=2

" Colorscheme
colorscheme nord

" Line length
" set tw=80

" Tabs
set tabstop=4
set sw=4
set expandtab

" " Line numbering
set number relativenumber
" augroup numbertoggle
"   autocmd!
"   autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
"   autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
" augroup END

" Copy visual selection to clipboard
vnoremap <C-c> "+y

"Vim splits navigation
nnoremap <C-Down> <C-W><C-J>
nnoremap <C-Up> <C-W><C-K>
nnoremap <C-Right> <C-W><C-L>
nnoremap <C-Left> <C-W><C-H>
set splitbelow
set splitright

" Vim tabs navigation
nnoremap <A-Right> gt
nnoremap <A-Left> gT
nnoremap <Esc>t :tabnew<cr> :NERDTreeToggle<cr>

"" VHDL comments on new lines
"autocmd FileType vhdl setlocal comments=:--
"autocmd FileType vhdl setlocal formatoptions+=cro
"" Bitbake comments
"autocmd FileType bitbake setlocal commentstring=#\ %s

" Bitbake syntax highlighting
au BufRead,BufNewFile *.bb set filetype=bitbake
au BufRead,BufNewFile *.bbclass set filetype=bitbake
au BufRead,BufNewFile *.bbappend set filetype=bitbake
au BufRead,BufNewFile *.inc set filetype=bitbake
au! Syntax bitbake source $HOME/.vim/syntax/bitbake.vim

" Enable folding
set foldmethod=indent
set foldlevel=99
set nofoldenable
nmap <leader><f> za

" Enable word highlighting
set hlsearch
nnoremap * :let @/ = '\<'.expand('<cword>').'\>'\|set hlsearch<C-M>
" Clear hightlights
nnoremap <Leader>8 :let @/=""<cr>

" undo hidtory
set undofile

" Saving
nnoremap <C-s> :w<cr>
inoremap <C-s> :w<cr>
nnoremap <C-q> :wqa<cr>
" nnoremap <C-w> :wq<cr>

" Italic font
hi Italic cterm=italic
hi Comment cterm=italic

" Modeline magic
set modeline
set modelines=5
function! AppendModeline()
  let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d %set :",
        \ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), printf(""))
  call append(line("$"), l:modeline)
endfunction
nnoremap <silent> <Leader>ml :call AppendModeline()<CR>

" Pkg highlighting
au BufNewFile,BufRead *.pkg set filetype=vhdl

" set formatprg=par\ -w70

autocmd FileType tex set spell
autocmd FileType tex set spelllang=fr

" Spell correction
imap <C-l> <Esc>[s1z=`]a

" My aliases
command FormatBif :%s/\([^ ][ ]\{0,1},\) /\1\r      /g
command Tkeysdir :%s@/data/txl/workspace/wyld/bsp/sources/custom/meta-txl/txl-bsp/secureboot@\$KEYS_DIR@g
command Tbuild :%s@/data/txl/workspace/wyld/build@\$KEYS_DIR@g

nmap <leader>q gqap

set colorcolumn=80
hi ColorColumn ctermbg=white

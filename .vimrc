"""""""""""""""""
" VUNDLE CONFIG "
"""""""""""""""""

set nocompatible
filetype off

call plug#begin('~/.vim/plugged')

" PLUGINS "

Plug 'tpope/vim-fugitive'
Plug 'godlygeek/tabular'
Plug 'wincent/terminus'
Plug 'honza/vim-snippets'
Plug 'terryma/vim-multiple-cursors'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tmhedberg/SimpylFold'
Plug 'kergoth/vim-bitbake'
Plug 'plasticboy/vim-markdown'

Plug 'dense-analysis/ale'
    let g:ale_completion_enabled = 1
    let g:ale_sign_column_always = 1
    let g:ale_fixers = {
    \   '*': ['remove_trailing_lines', 'trim_whitespace'],
    \   'python': ['isort', 'black', 'autopep8'],
    \}
    let g:ale_linters = {'python': ['mypy', 'flake8', 'pylint']}
    let g:ale_python_flake8_options = '--max-line-length=90'
    let g:ale_python_pylint_executable = 'pylint3'

Plug 'junegunn/goyo.vim'
    let g:goyo_width=94
    let g:goyo_linenr=1

    function! s:goyo_enter()
      let b:quitting = 0
      let b:quitting_bang = 0
      autocmd QuitPre <buffer> let b:quitting = 1
      cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
    endfunction

    function! s:goyo_leave()
      " Quit Vim if this is the only remaining buffer
      if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
        if b:quitting_bang
          qa!
        else
          qa
        endif
      endif
    endfunction

    autocmd! User GoyoEnter call <SID>goyo_enter()
    autocmd! User GoyoLeave call <SID>goyo_leave()

Plug 'scrooloose/nerdtree'
    nnoremap <C-e> :NERDTreeToggle<cr>

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

Plug 'lervag/vimtex'
    let g:polyglot_disabled = ['latex']
    let g:tex_flavor='latex'
    let g:vimtex_view_method='zathura'
    let g:vimtex_quickfix_mode=0

Plug 'lifepillar/vim-mucomplete'
    set completeopt+=menuone
    set completeopt+=noselect
    set completeopt+=noinsert
    set shortmess+=c
    setlocal dictionary+=spell
    setlocal complete+=k
    let g:mucomplete#chains = {}
    let g:mucomplete#chains.default = ['ulti', 'path', 'omni', 'keyn', 'dict', 'uspl']

Plug 'Yggdroot/indentLine'
    let g:indentLine_char = '▏'
    let g:indentLine_conceallevel = 0

" COLORSCHEMES "
Plug 'arcticicestudio/nord-vim'

call plug#end()

filetype plugin indent on

"""""""""""""""
" VIM RELATED "
"""""""""""""""

" Set delay
set timeoutlen=1000 ttimeoutlen=0 
set updatetime=100

" Syntax and filetype
syntax on
 
" make backspace work like most other programs
set backspace=2

" Line length
set tw=90

" Tabs
set tabstop=4
set sw=4
set expandtab

" Line numbering
set number relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Copy visual selection to clipboard
vnoremap <C-c> "+y

" Color scheme (needs nord installed)
colorscheme nord 

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

" VHDL comments on new lines
autocmd FileType vhdl setlocal comments=:--
autocmd FileType vhdl setlocal formatoptions+=cro
" Bitbake comments
autocmd FileType bitbake setlocal commentstring=#\ %s

" " Bitbake syntax highlighting
" au BufRead,BufNewFile *.bb set filetype=bitbake
" au BufRead,BufNewFile *.bbclass set filetype=bitbake
" au BufRead,BufNewFile *.bbappend set filetype=bitbake
" au BufRead,BufNewFile *.inc set filetype=bitbake
" au! Syntax bitbake source $HOME/.vim/syntax/bitbake.vim

" Enable folding
set foldmethod=indent
set foldlevel=99
set nofoldenable
nnoremap <space> za

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

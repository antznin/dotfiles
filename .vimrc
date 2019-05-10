"""""""""""""""""
" VUNDLE CONFIG "
"""""""""""""""""

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" PLUGINS "
Plugin 'tpope/vim-fugitive'
Plugin 'junegunn/goyo.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'godlygeek/tabular'
Plugin 'wincent/terminus'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'vim-airline/vim-airline'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'sheerun/vim-polyglot'
Plugin 'tpope/vim-surround'
Plugin 'lervag/vimtex'
" Plugin 'Valloric/YouCompleteMe', {'do': './install.sh --clang-completer' }

" COLORSCHEMES "
Plugin 'arcticicestudio/nord-vim'

call vundle#end()
filetype plugin indent on


"""""""""""""""
" VIM RELATED "
"""""""""""""""

" Set delay
set timeoutlen=1000 ttimeoutlen=0 

" Syntax and filetype
syntax on
 
" make backspace work like most other programs
set backspace=2

" Line length
set tw=90

" Line numbering
set number relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

colorscheme nord 

" Pathogen plugin requirements
" call pathogen#infect()
" call pathogen#helptags()
" filetype plugin indent on


""""""""""""""""""
" PLUGIN RELATED "
""""""""""""""""""

" Airline powerline fonts
let g:airline_powerline_fonts = 1

" Goyo config
let g:goyo_width=94
let g:goyo_linenr=0

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

" vimtex
let g:polyglot_disabled = ['latex']
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0

" Modeline magic
" Append modeline after last line in buffer.
" Use substitute() instead of printf() to handle '%%s' modeline in LaTeX
" files.
set modeline
set modelines=5
function! AppendModeline()
  let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d %set :",
        \ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), l:modeline)
endfunction
nnoremap <silent> <Leader>ml :call AppendModeline()<CR>

" Pkg highlighting
au BufNewFile,BufRead *.pkg set filetype=vhdl

" YouCompleteMe setup
let g:ycm_autoclose_preview_window_after_completion = 1
" let g:ycm_filetype_blacklist={'unite': 1}
let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_complete_in_comments = 1 
let g:ycm_seed_identifiers_with_syntax = 1 
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>

" Ultisnips config
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsSnippetsDir=$HOME.'/.vim/bundle/vim-snippets/UltiSnips'
let g:UltiSnipsSnippetDirectories=["UltiSnips"]
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsListSnippets="<c-h>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"


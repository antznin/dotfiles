"""""""""""""""""""
" VIM-PLUG CONFIG "
"""""""""""""""""""

set nocompatible
filetype off

" Map leader to space
let mapleader ="g"

set shell=/bin/bash

call plug#begin('~/.vim/plugged')

" PLUGINS "

Plug 'arcticicestudio/nord-vim'
Plug 'honza/vim-snippets'
Plug 'sheerun/vim-polyglot'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'wincent/terminus'

Plug 'airblade/vim-gitgutter'
    nmap <C-h> <Plug>(GitGutterNextHunk)
    nmap <C-g> <Plug>(GitGutterPrevHunk)
Plug 'kergoth/vim-bitbake'
    " Bitbake syntax highlighting
    au BufRead,BufNewFile *.bb set filetype=bitbake
    au BufRead,BufNewFile *.bbclass set filetype=bitbake
    au BufRead,BufNewFile *.bbappend set filetype=bitbake
    au BufRead,BufNewFile *.inc set filetype=bitbake
    au BufRead,BufNewFile local.conf.sample set filetype=bitbake
    au BufRead,BufNewFile bblayers.conf.sample set filetype=bitbake
Plug 'ctrlpvim/ctrlp.vim'
    let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:0'
    let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
    if executable('ag')
        let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
    endif
Plug 'scrooloose/nerdtree'
    nnoremap <C-e> :NERDTreeToggle<cr>
    let NERDTreeMinimalUI=1
    let NERDTreeAutoDeleteBuffer=1
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
    let g:airline_section_y=''

call plug#end()

filetype plugin indent on

"""""""""""""""
" VIM RELATED "
"""""""""""""""

colorscheme nord

cd %:p:h

" Set delay
set timeoutlen=1000 ttimeoutlen=0

" Syntax and filetype
syntax on

" make backspace work like most other programs
set backspace=2

" Colorscheme


" Line length
" set tw=80

" Tabs
set tabstop=4
set sw=4
set expandtab

" " Line numbering
set number relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

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

" VHDL
" autocmd FileType vhdl setlocal comments=:--
" autocmd FileType vhdl setlocal formatoptions+=cro
" au BufNewFile,BufRead *.pkg set filetype=vhdl

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

autocmd FileType tex set spell
autocmd FileType tex set spelllang=fr

" Spell correction
" imap <C-l> <Esc>[s1z=`]a

nmap <leader>q gqap

function! CleverTab()
   if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
      return "\<Tab>"
   else
      return "\<C-N>"
   endif
endfunction
inoremap <Tab> <C-R>=CleverTab()<CR>

" Cscope
function! CscopeLoad()
    if has("cscope")
            " Look for a 'cscope.out' file starting from the current directory,
            " going up to the root directory.
            let s:dirs = split(getcwd(), "/")
            while s:dirs != []
                    let s:path = "/" . join(s:dirs, "/")
                    if (filereadable(s:path . "/cscope.out"))
                            execute "cs add " . s:path . "/cscope.out " . s:path . " -v"
                            break
                    endif
                    let s:dirs = s:dirs[:-2]
            endwhile

            set csto=0  " Use cscope first, then ctags
            set cst     " Only search cscope
            set csverb  " Make cs verbose

            nmap <C-c>s :cs find s <C-R>=expand("<cword>")<CR><CR>
            nmap <C-c>g :cs find g <C-R>=expand("<cword>")<CR><CR>
            nmap <C-c>c :cs find c <C-R>=expand("<cword>")<CR><CR>
            nmap <C-c>t :cs find t <C-R>=expand("<cword>")<CR><CR>
            nmap <C-c>e :cs find e <C-R>=expand("<cword>")<CR><CR>
            nmap <C-c>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
            nmap <C-c>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
            nmap <C-c>d :cs find d <C-R>=expand("<cword>")<CR><CR>
            nmap <C-c>q :cs find a <C-R>=expand("<cword>")<CR><CR>
            nmap <F6> :cnext <CR>
            nmap <F5> :cprev <CR>

            " Open a quickfix window for the following queries.
            set cscopequickfix=s-,c-,d-,i-,t-,e-,g-
    endif
endfunction
call CscopeLoad()

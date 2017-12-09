syntax on

filetype on
filetype indent on
filetype plugin on

set background=dark
set clipboard=unnamed
set completeopt-=preview
set encoding=utf-8
set expandtab
set fileencoding=utf-8
set hidden
set incsearch
set laststatus=2
set mouse=a
set nocompatible
set ruler
set shiftwidth=4
set tabstop=4
set viminfo=

let g:ctrlp_user_command = ['.git', 'cd %s & git ls-files -co --exclude-standard']
let g:elm_format_autosave = 1
let g:xml_syntax_folding=1

execute pathogen#infect()

colo onedark

autocmd BufNewFile,BufRead *.adoc,*.asciidoc setf asciidoc
autocmd BufNewFile,BufRead *.gradle setf groovy
autocmd FileType haskell setlocal et sw=2 ts=2 autoindent
autocmd FileType xml setlocal foldmethod=syntax

nmap <C-B> :CtrlPBuffer<CR>

if has("mac")
    if has("gui_macvim")
        set macligatures
    endif
    set guifont=Fira\ Code:h14
elseif has("unix")
    " Nothing here for now
elseif has("win32")
    set guifont=Fira_Mono_Medium:h12
    set guioptions=rL

    set directory=~/vimswap/
endif

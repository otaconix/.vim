unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

syntax on

filetype on
filetype indent on
filetype plugin on

set background=dark
set clipboard=unnamed
set completeopt-=preview
let &directory=fnamemodify($MYVIMRC, ":p:h") . "/swap//"
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
set modelines=100

let g:ale_yaml_yamllint_options = '-d "{extends: default, rules: {colons: {max-spaces-after: -1}}}"'
let g:ctrlp_by_filename = 1
let g:ctrlp_user_command = ['.git', 'cd %s & git ls-files -co --exclude-standard']
if !has('python') && !has('python3')
    echo 'In order to use pymatcher plugin, you need +python compiled vim'
else
    let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
endif
let g:xml_syntax_folding = 1

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
        set guifont=Fira\ Code:h14
    endif
elseif has("unix")
    " Nothing here for now
elseif has("win32")
    set guifont=Fira_Mono_Medium:h12
    set guioptions=rL
endif

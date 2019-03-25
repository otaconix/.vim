unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim
if filereadable(glob("~/.localvimrc"))
    source ~/.localvimrc
endif

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
set hlsearch
set incsearch
set laststatus=2
set modelines=100
set mouse=a
set nocompatible
set ruler
set shiftwidth=4
set tabstop=4
set viminfo=

let g:ale_yaml_yamllint_options = '-d "{extends: default, rules: {colons: {max-spaces-after: -1}}}"'
let g:ctrlp_by_filename = 1
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
if !has('python') && !has('python3')
    echo 'In order to use pymatcher plugin, you need +python compiled vim'
else
    let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
endif
let g:xml_syntax_folding = 1

packloadall

colo onedark

vnoremap * y/<C-R>"<CR>

autocmd BufNewFile,BufRead *.adoc,*.asciidoc setf asciidoc
autocmd BufNewFile,BufRead *.gradle setf groovy
autocmd FileType haskell setlocal expandtab shiftwidth=2 tabstop=2 autoindent | let b:neoformat_enabled_haskell=['brittany']
autocmd FileType netrw setlocal bufhidden=wipe
autocmd FileType xml setlocal foldmethod=syntax

command Wb w | bd

augroup fmt
    au!
    au BufWritePre * Neoformat
augroup END

nmap <C-B> :CtrlPBuffer<CR>

if has("mac")
    if has("gui_macvim")
        set macligatures
        set guifont=Fira\ Code:h14
    endif
elseif has("unix")
    set guifont=Fira\ Code\ weight=453\ 12
    set guioptions=
elseif has("win32")
    set guifont=Fira_Mono_Medium:h12
    set guioptions=
endif

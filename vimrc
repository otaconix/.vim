unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim
if filereadable(glob("~/.localvimrc"))
    source ~/.localvimrc
endif

syntax on

filetype on
filetype indent on
filetype plugin on

set background=dark                                      " Use dark background
set clipboard=unnamedplus                                " Use 'unnamedplus' clipboard
set completeopt+=noselect
let &directory=fnamemodify($MYVIMRC, ":p:h") . "/swap//" " Put swap files in the same directory vimrc is in
set encoding=utf-8
set expandtab                                            " Use spaces instead of tabs
if &modifiable
    set fileencoding=utf-8
endif
set hidden                                               " Allow hidden buffers
set hlsearch                                             " Highlight search results
set incsearch                                            " Highlight incremental search results (highlight as you type)
set laststatus=2
set modelines=100                                        " Search for modelines within the first 100 lines
set mouse=a
set nocompatible
set ruler
set shiftwidth=4
set tabstop=4
set viminfo=

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
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

autocmd BufNewFile,BufRead *.adoc,*.asciidoc setf asciidoc
autocmd BufNewFile,BufRead *.gradle setf groovy
autocmd FileType haskell setlocal expandtab shiftwidth=2 tabstop=2 autoindent | let b:neoformat_enabled_haskell=['brittany']
autocmd FileType netrw setlocal bufhidden=wipe
autocmd FileType xml setlocal foldmethod=syntax
autocmd FileType yaml setlocal expandtab shiftwidth=2 tabstop=2 autoindent

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
    set guifont=Cascadia\ Code\ 12
    set guioptions=
elseif has("win32")
    set guifont=Fira_Mono_Medium:h12
    set guioptions=
endif

" Work around issue with background when using Kitty terminal
if &term == "xterm-kitty"
    let &t_ut=''
endif

" Use GUI colors on the terminal
if has('termguicolors')
    set termguicolors
    let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum"
    let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum"
endif

let s:LanguageClient_serverCommands = {
            \ 'bash': ['bash-language-server', 'start'],
            \ 'dockerfile': ['docker-langserver', '--stdio'],
            \ 'javascript': ['javascript-typescript-langserver'],
            \ 'python': ['pyls'],
            \ 'rust': ['rustup', 'run', 'stable', 'rls'],
            \ }

let g:LanguageClient_serverCommands = {}

for languageServer in keys(s:LanguageClient_serverCommands)
    let binary = s:LanguageClient_serverCommands[languageServer][0]

    if executable(binary)
        let g:LanguageClient_serverCommands[languageServer] = s:LanguageClient_serverCommands[languageServer]
    endif
endfor

nnoremap <F5> :call LanguageClient_contextMenu()<CR>

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
set completeopt+=popup
let &directory=expand("<sfile>:p:h") . "/swap//" " Put swap files in the same directory vimrc is in
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
set shiftwidth=2
set tabstop=2
set viminfo=

let g:ctrlp_by_filename = 1
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
if !has('python') && !has('python3')
  echomsg 'In order to use pymatcher plugin, you need +python compiled vim'
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
autocmd FileType haskell setlocal autoindent | let b:neoformat_enabled_haskell=['brittany']
autocmd FileType netrw setlocal bufhidden=wipe
autocmd FileType xml setlocal foldmethod=syntax
autocmd FileType yaml setlocal autoindent

augroup Workarounds
  au!
  au CompleteDone * call popup_close(popup_findinfo()) " Workaround for misbehaving ctrlp when a popup window is still open
augroup END

command Wb w | bd

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
  set guifont=Cascadia_Code:h10:cANSI:qDRAFT
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

" Setup language servers
let s:LanguageClient_serverCommands = {
      \ 'bash': ['bash-language-server', 'start'],
      \ 'dockerfile': ['docker-langserver', '--stdio'],
      \ 'go': ['gopls', 'serve'],
      \ 'java': ['jdtls'],
      \ 'javascript': [
        \ ['typescript-language-server', '--stdio'],
        \ ['javascript-typescript-langserver'], 
        \ ],
      \ 'python': ['pyls'],
      \ 'rust': ['rust-analyzer'],
      \ }

let g:LanguageClient_serverCommands = {}

" Only add language servers for which the binary is on the path
for languageServer in keys(s:LanguageClient_serverCommands)
  let servers = s:LanguageClient_serverCommands[languageServer]
  if type(servers[0]) != v:t_list
    let servers = [servers]
  endif

  for server in servers
    if !has_key(g:LanguageClient_serverCommands, languageServer) && executable(server[0])
      let g:LanguageClient_serverCommands[languageServer] = server
      break
    endif
  endfor
endfor

nnoremap <silent> <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> <Leader>f :call LanguageClient#textDocument_formatting()<CR>
nnoremap <silent> <Leader>g :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <Leader>h :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> <Leader>r :call LanguageClient#textDocument_rename()<CR>

colo evening
syntax on
filetype on
filetype indent on
filetype plugin on

set shiftwidth=4
set tabstop=4
set noexpandtab
set laststatus=2
set hidden

if has("gui_macvim")
	set macligatures
endif
set guifont=Fira\ Code:h14

let g:ctrlp_user_command = ['.git', 'cd %s & git ls-files -co --exclude-standard']
let g:elm_format_autosave = 1

execute pathogen#infect()

nmap <C-B> :CtrlPBuffer<CR>

autocmd FileType haskell set et sw=2 ts=2 autoindent

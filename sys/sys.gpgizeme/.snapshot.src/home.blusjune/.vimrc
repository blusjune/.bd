imap <C-R>ts<CR> <C-R>=system('tstamp')<CR>
imap <C-R>pwd<CR> <C-R>=system('pwd')<CR>
imap <C-R>ls<CR> <C-R>=system('ls -1F')<CR>

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
call pathogen#infect()

set nocompatible
set nu ai cin

filetype plugin on
filetype indent on
let g:solarized_termcolors=256
let g:solarized_termtrans=0
let g:solarized_degrade=0
let g:solarized_bold=1
let g:solarized_underline=1
let g:solarized_italic=1
let g:solarized_contrast="normal"
let g:solarized_visibility="normal"
colorscheme solarized
syntax enable
syntax on

if has('gui_running')
	set background=light
else
	set background=dark
endif


" This needs to run before setting termguicolours
if !has('gui_running') && &term =~ '\%(screen\|tmux\)'
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

" Make Catppuccin theme work
set termguicolors

" Set numbers
set rnu
set nu

set hls
set is
set cursorline
set smartcase
set showmode

" Width of tabs
set tabstop=4

" Whitespace for indentation
set shiftwidth=4

" Convert tabs to spaces
set expandtab

" Num spaces to delete/insert with backspace/tab
set softtabstop=4

set nocompatible
set scrolloff=10
set laststatus=2

filetype on
syntax on

colorscheme catppuccin_mocha

" Change cursor depending on the mode.
" Not sure how this will fare outside of MacOS and iTerm2.
"
" https://stackoverflow.com/questions/4777950/vim-change-block-cursor-when-in-insert-mode
let &t_SI = "\<esc>[5 q"
let &t_SR = "\<esc>[5 q"
let &t_EI = "\<esc>[2 q"

set ttimeout
set ttimeoutlen=1
set listchars=tab:>-,trail:~,extends:>,precedes:<,space:.
set ttyfast


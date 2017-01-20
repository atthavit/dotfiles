set nocompatible
syntax enable
set t_Co=256
set term=xterm-256color

set nu
set relativenumber
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set showcmd
set incsearch
set hlsearch
set nowrap
set hidden
set splitright
set splitbelow
set backspace=2
set encoding=utf-8
set tags=./tags;,tags;,.git/tags; " find tags file in file dir, parent dirs and .git dir
set smartcase
set ignorecase " required by smartcase

" Disable arrow keys for practicing
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

cmap w!! w !sudo tee %

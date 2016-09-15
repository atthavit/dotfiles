call plug#begin('~/.vim/plugged')
" Plug 'https://github.com/powerline/powerline.git'
Plug 'https://github.com/scrooloose/nerdtree.git'
Plug 'https://github.com/vim-airline/vim-airline.git'
Plug 'https://github.com/vim-airline/vim-airline-themes.git'
Plug 'https://github.com/kien/ctrlp.vim.git'

" Themes
Plug 'https://github.com/sickill/vim-monokai.git'
Plug 'https://github.com/tomasr/molokai'
Plug 'https://github.com/altercation/vim-colors-solarized.git'
Plug 'https://github.com/morhetz/gruvbox.git'
Plug 'https://github.com/sjl/badwolf.git'
Plug 'NLKNguyen/papercolor-theme'
call plug#end()
set nocompatible

syntax enable
set t_Co=256
set term=xterm-256color
"let g:solarized_termcolors=256

set background=dark
let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox

"set background=light
"colorscheme PaperColor



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

" Disable arrow keys for practicing
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" powerline
"set rtp+=~/.vim/plugged/powerline/powerline/bindings/vim
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline_theme='powerlineish'


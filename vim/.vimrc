call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'kien/ctrlp.vim'
Plug 'godlygeek/tabular'
Plug 'dhruvasagar/vim-table-mode'
Plug 'tpope/vim-fugitive'

" Themes
" Plug 'https://github.com/sickill/vim-monokai.git'
" Plug 'https://github.com/tomasr/molokai'
" Plug 'https://github.com/altercation/vim-colors-solarized.git'
Plug 'https://github.com/morhetz/gruvbox.git'
" Plug 'https://github.com/sjl/badwolf.git'
" Plug 'NLKNguyen/papercolor-theme'
call plug#end()
set nocompatible

syntax enable
set t_Co=256
set term=xterm-256color
"let g:solarized_termcolors=256

set background=dark
let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox
set t_ut= "background issue in tmux (https://github.com/morhetz/gruvbox/issues/81)

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
set tags=./tags;,tags;,.git/tags; " find tags file in file dir, parent dirs and .git dir
set smartcase

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

" for GUI
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 10
set mouse=c

" vim-table-mode
let g:table_mode_corner="|" " markdown-compatible

call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'godlygeek/tabular'
Plug 'dhruvasagar/vim-table-mode'
Plug 'tpope/vim-fugitive'
Plug 'chase/vim-ansible-yaml'
Plug 'w0rp/ale'
Plug 'mattn/emmet-vim'
Plug 'valloric/MatchTagAlways'  " highlight enclosing html tags
Plug 'tpope/vim-unimpaired'
Plug 'posva/vim-vue'
Plug 'davidhalter/jedi-vim'
Plug 'majutsushi/tagbar'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-commentary'
Plug 'fisadev/vim-isort'

" Theme
Plug 'https://github.com/morhetz/gruvbox.git'
call plug#end()

set nocompatible
syntax enable
set t_Co=256
set term=xterm-256color

set background=dark
let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox
" background issue in tmux (https://github.com/morhetz/gruvbox/issues/81)
set t_ut=

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
set tags=./tags;,tags;,.git/tags;  " find tags file in file dir, parent dirs and .git dir
set smartcase
set ignorecase
set wildmenu
set wildmode=list:longest,full

filetype plugin on
" 2 spaces on js, html, vue
autocmd FileType html setlocal sw=2 ts=2 sts=2
autocmd FileType javascript setlocal sw=2 ts=2 sts=2
autocmd FileType vue setlocal sw=2 ts=2 sts=2

noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

cmap w!! w !sudo tee %

" Jump between html tags
runtime macros/matchit.vim

" GUI
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 10
set mouse=c

" ctrlp
let g:ctrlp_max_files=0
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|node_modules)$',
  \ 'file': '\v\.(pyc)$',
  \ }
let g:ctrlp_show_hidden = 1
let g:ctrlp_working_path_mode = 0

" ALE
filetype off
let &runtimepath.=',~/.vim/bundle/ale'
filetype plugin on
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" vim-airline
set laststatus=2
let g:airline_theme='powerlineish'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tagbar#enabled = 1

" vim-table-mode
let g:table_mode_corner="|" " markdown-compatible

" MatchTagAlways
let g:mta_filetypes = {
    \ 'html' : 1,
    \ 'xhtml' : 1,
    \ 'xml' : 1,
    \ 'jinja' : 1,
    \ 'htmldjango' : 1,
    \}

" vim-gitgutter
set updatetime=250

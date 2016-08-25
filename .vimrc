call plug#begin('~/.vim/plugged')
Plug 'https://github.com/powerline/powerline.git'
call plug#end()

set nocompatible
set term=xterm-256color

set nu
set relativenumber
set expandtab
set tabstop=4
set shiftwidth=4 
set softtabstop=4
set showcmd
set incsearch

" powerline
set laststatus=2
set rtp+=~/.vim/plugged/powerline/powerline/bindings/vim

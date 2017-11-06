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
Plug 'ap/vim-css-color'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-commentary'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'johngrib/vim-game-code-break'
Plug 'Chiel92/vim-autoformat'
Plug 'fisadev/vim-isort'
Plug 'maralla/completor.vim', {'for': 'python'}  " autocompletion
Plug 'wincent/ferret'  " file search
Plug 'fatih/vim-go'

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
set nofoldenable
" auto-reload
set autoread
au FocusGained,BufEnter * checktime
au CursorHold,CursorHoldI * checktime

filetype plugin on
autocmd FileType html setlocal sw=2 ts=2 sts=2
autocmd FileType javascript setlocal sw=2 ts=2 sts=2
autocmd FileType vue setlocal sw=2 ts=2 sts=2
autocmd FileType yaml setlocal sw=2 ts=2 sts=2
autocmd FileType go setlocal noet ts=4 sw=4 sts =4

noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

cmap w!! w !sudo tee %
nnoremap <Leader>w :update<CR>
nnoremap <Leader>q :q<CR>

" from https://stackoverflow.com/questions/510503/ctrlspace-for-omni-and-keyword-completion-in-vim
inoremap <expr> <C-n> pumvisible() \|\| &omnifunc == '' ?
    \ "\<lt>C-n>" :
    \ "\<lt>C-x>\<lt>C-o><c-r>=pumvisible() ?" .
    \ "\"\\<lt>c-n>\\<lt>c-p>\\<lt>c-n>\" :" .
    \ "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"

" Jump between html tags
runtime macros/matchit.vim

" GUI
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 10
set mouse=c

" ctrlp
nnoremap <C-n> :CtrlPTag<CR>
let g:ctrlp_max_files=0
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|node_modules)$',
  \ 'file': '\v\.(pyc|swp|swo)$',
  \ }
let g:ctrlp_show_hidden = 1
let g:ctrlp_working_path_mode = 0
let g:ctrlp_extensions = ['tag']
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:30'

" ALE
filetype off
let &runtimepath.=',~/.vim/bundle/ale'
filetype plugin on
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
let g:ale_fixers = {
    \ 'python': ['yapf'],
    \}

" vim-airline
set laststatus=2
let g:airline_theme='powerlineish'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#virtualenv#enabled = 0

" vim-table-mode
let g:table_mode_corner="|" " markdown-compatible

" MatchTagAlways
let g:mta_filetypes = {
    \ 'html' : 1,
    \ 'xhtml' : 1,
    \ 'xml' : 1,
    \ 'jinja' : 1,
    \ 'htmldjango' : 1,
    \ 'vue' : 1,
    \}

" vim-gitgutter
set updatetime=250

" vim-indent-guides
let g:indent_guides_guide_size = 1

" jedi-vim
let g:jedi#force_py_version = 3

" vim-autoformat
noremap <F3> :Autoformat<CR>
let g:formatdef_yapf = "'yapf -l '.a:firstline.'-'.a:lastline"  " to use yapf settings from config file

" vim-isort
let g:vim_isort_python_version = 'python3'

" jedi-vim
let g:jedi#completions_enabled = 0  " use completor.vim instead
let g:jedi#smart_auto_mappings = 0
let g:jedi#force_py_version = 3

" completor.vim
let g:completor_python_binary = 'python3'

function! RemoveTrailingSpaces(...)
    %s/\s*$//
    ''
endfunction

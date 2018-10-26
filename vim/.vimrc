call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
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
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
Plug 'ap/vim-css-color'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-commentary'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'tmhedberg/SimpylFold'
Plug 'Konfekt/FastFold'
Plug 'johngrib/vim-game-code-break', { 'on': 'VimGameCodeBreak' }
Plug 'Chiel92/vim-autoformat'
Plug 'fisadev/vim-isort'
Plug 'sjl/gundo.vim', { 'on': 'GundoToggle' }
Plug 'fatih/vim-go'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --completion --no-key-bindings --no-update-rc'}
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'hashivim/vim-terraform'
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'RRethy/vim-illuminate'
Plug 'SirVer/ultisnips'
" Python plugins
Plug 'Vimjas/vim-python-pep8-indent', { 'for': 'python' }
Plug 'Shougo/deoplete.nvim', { 'for': 'python' }
Plug 'roxma/nvim-yarp', { 'for': 'python' }
Plug 'roxma/vim-hug-neovim-rpc', { 'for': 'python' }
Plug 'zchee/deoplete-jedi', { 'for': 'python' }

" Theme
Plug 'morhetz/gruvbox'
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
set timeoutlen=500

" auto-reload
set autoread
au FocusGained,BufEnter * checktime
au CursorHold,CursorHoldI * checktime

filetype plugin on
autocmd FileType go setlocal noet ts=4 sw=4 sts =4
autocmd FileType html setlocal sw=2 ts=2 sts=2
autocmd FileType javascript setlocal sw=2 ts=2 sts=2
autocmd FileType python setlocal omnifunc=jedi#completions
autocmd FileType terraform setlocal sw=2 ts=2 sts=2 commentstring=#%s
autocmd FileType vue setlocal sw=2 ts=2 sts=2
autocmd FileType yaml setlocal sw=2 ts=2 sts=2

noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

cmap w!! w !sudo tee %
" get the dir of current buffer in command mode
cnoremap <Leader>d <C-R>=expand("%:p:h")."/"<CR>
cnoremap <Leader>m mks! ~/.vim<Left><Left><Left><Left>
nnoremap <Leader>w :update<CR>
nnoremap <Leader>q :q<CR>
vnoremap <leader>e64 c<c-r>=substitute(system('base64 --wrap=0', @"), '\n$', '', 'g')<esc>
vnoremap <leader>d64 c<c-r>=substitute(system('base64 --decode --wrap=0', @"), '\n$', '', 'g')<esc>
inoremap <C-Space> <C-x><C-o>
inoremap <C-@> <C-x><C-o>

" see https://github.com/Shougo/deoplete.nvim/issues/83
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<cr>")

" Jump between html tags
runtime macros/matchit.vim

" GUI
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 10
set mouse=c

" fzf
nnoremap <C-p> :FZF<CR>
nnoremap <C-n> :Tags<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>l :Lines<CR>
nnoremap <Leader>c :Commits!<CR>
nnoremap <Leader>m :Maps<CR>
let g:fzf_layout = { 'down': '~30%' }
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
let g:fzf_commits_log_options = '--graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
"   :Ag  - Start fzf with hidden preview window that can be enabled with "?" key
"   :Ag! - Start fzf in fullscreen with preview window
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('right:50%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

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
let g:jedi#completions_enabled = 0  " use deoplete-jedi instead
let g:jedi#smart_auto_mappings = 0
let g:jedi#force_py_version = 3

" gundo.vim
nnoremap <F6> :GundoToggle<CR>
let g:gundo_prefer_python3 = 1

" emmet-vim
let g:user_emmet_leader_key='<Leader><Leader>'

" tagbar
noremap <Leader>t :TagbarToggle<CR>

" vim-go
let g:go_fmt_command = 'goimports'
let g:go_addtags_transform = 'camelcase'
autocmd Filetype go nmap <Leader>d :GoDeclsDir<CR>
autocmd Filetype go nmap <Leader>i :GoInfo<CR>
autocmd Filetype go nmap <leader>t :GoTest -short<cr>
autocmd Filetype go nmap <leader>cov :GoCoverageToggle<cr>

" deoplete
let g:deoplete#enable_at_startup = 1

function! RemoveTrailingSpaces(...)
    %s/\s*$//
    ''
endfunction

" vim-terraform
let g:terraform_fold_sections=1

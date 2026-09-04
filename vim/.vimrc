" ~/.vimrc

let mapleader=" "

" basic settings
colorscheme desert

set mouse=a
set noswapfile
set completeopt=menuone,noselect
set tabstop=4
set shiftwidth=2
set smartindent
set number
set relativenumber
set signcolumn=yes
set nowrap
set ignorecase
set termguicolors
set incsearch

" fuzzy
set path+=**
set wildmenu
set wildoptions=fuzzy
nnoremap <leader>f :find *


" syntax
syntax on
filetype plugin indent on


" mappings
vnoremap <leader>y "+y
nnoremap <leader>w :update<CR>
nnoremap <leader>n :vs<CR>
nnoremap <leader>q :quit<CR>
nnoremap <leader>p "+p
vnoremap <leader>p "+p
nnoremap <leader>vc :e $MYVIMRC<CR>
nnoremap <leader>vz :e ~/.zshrc<CR>
nnoremap <leader>te :term<CR>

" quickfix
nnoremap <leader>co :copen<CR>
nnoremap <leader>nn :cn<CR>
nnoremap <leader>pp :cp<CR>

" file switching
nnoremap <leader>e :e #<CR>
nnoremap <leader>vs :rightbelow vs #<CR>

" terminal escape
tnoremap <Esc> <C-\><C-n>

" center screen on search and down up
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap n nzz
nnoremap N Nzz

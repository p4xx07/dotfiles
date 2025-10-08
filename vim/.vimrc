" ~/.vimrc

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

let mapleader=" "

" mappings
nnoremap <leader>w :write<CR>
nnoremap <leader>q :quit<CR>
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


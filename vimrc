set background=dark
colorscheme everforest

set shortmess+=I "skip intro
syntax on
set ts=4 sw=4 sts=4 et
set number
set relativenumber

set ttyfast "placebo?

set ignorecase
set hidden
set mouse=a

let mapleader=" "
map <leader><leader> :Commands<CR>
map <leader>/ :execute 'Rg ' . input('Rg/')<CR>
map <leader>b :Buffers<CR>
map <leader>f :GF<CR>
map <leader>d :GF?<CR>
map <leader>l :BLines<CR>

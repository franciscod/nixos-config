set background=dark
let g:everforest_better_performance = 1 " !?
colorscheme everforest
syntax on

set shortmess+=I "skip intro
set ts=4 sw=4 sts=4 et
set number
set relativenumber

set ttyfast "placebo?

set ignorecase smartcase
set hidden
set mouse=a

set autoindent

let mapleader=" "
map <leader><leader> :Commands<CR>
map <leader>/ :execute 'Rg ' . input('Rg/')<CR>
map <leader>b :Buffers<CR>
map <leader>f :Files<CR>
map <leader>g :GFiles<CR>
map <leader>G :GFiles?<CR>
map <leader>l :BLines<CR>
map <leader>o :b #<CR>
map <leader>p "+p
map <leader>y "+y
map <leader>m :wa<CR>:make<CR>
map <leader>i <cmd>source ~/.config/nvim/init.vim<CR>

command Autosave   autocmd  TextChanged,TextChangedI <buffer> silent write
command NoAutosave autocmd! TextChanged,TextChangedI

map ge G
map U <C-R>

map [c :cprev<CR>
map ]c :cnext<CR>

set list
set listchars=tab:\|\ ,trail:·,space:·,extends:>,precedes:<,nbsp:+
match Todo /\s\+$/

lua <<EOF

require'lspconfig'.zls.setup{}
require'lspconfig'.clangd.setup{}

EOF

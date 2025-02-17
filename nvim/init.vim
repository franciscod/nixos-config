set background=dark
let g:everforest_better_performance = 1 " !?
colorscheme everforest
syntax on

set hlsearch
set shortmess+=I "skip intro
set ts=4 sw=4 sts=4 et
set number
set relativenumber
set colorcolumn=80

set ttyfast "placebo?

set ignorecase smartcase
set hidden
set mouse=a

set autoindent
set noswapfile

set updatetime=100 "fast gitgutter

let mapleader=" "
map <leader>f :GFiles<CR>
map <leader>F :Files<CR>
map <leader>/ :Rg<CR>
map <leader>b :Buffers<CR>
"map <leader><leader> :Commands<CR>
"map <leader>d :GFiles?<CR>
"map <leader>l :BLines<CR>
map <leader>o :b #<CR>
map <leader>p "+p
map <leader>y "+y
map <leader>m :wa<CR>:make<CR>
map <leader>i <cmd>source $MYVIMRC<CR>
map <leader>I <cmd>edit $MYVIMRC<CR>

command Autosave   autocmd  TextChanged,TextChangedI <buffer> silent write
command NoAutosave autocmd! TextChanged,TextChangedI
autocmd BufEnter *.pl :setlocal filetype=prolog

map ge G
map U <C-R>

map [c :cprev<CR>
map ]c :cnext<CR>

map [b :bprev<CR>
map ]b :bnext<CR>

set list
set listchars=tab:\|\ ,trail:·,space:·,extends:>,precedes:<,nbsp:+
" match Todo /\s\+$/ " highlight trailing spaces

" C#
set errorformat+=%f(%l\\,%c):\ %m%.%#

" lua <<EOF
"
" require'lspconfig'.zls.setup{}
" require'lspconfig'.clangd.setup{}
" require'lspconfig'.lua_ls.setup{}
" require'lspconfig'.gopls.setup{}
" 
" vim.api.nvim_create_autocmd('LspAttach', {
"   group = vim.api.nvim_create_augroup('UserLspConfig', {}),
"   callback = function(ev)
"     -- Enable completion triggered by <c-x><c-o>
"     vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
" 
"     -- Buffer local mappings.
"     -- See `:help vim.lsp.*` for documentation on any of the below functions
"     local opts = { buffer = ev.buf }
"     vim.keymap.set('n',          '<C-k>',     vim.lsp.buf.signature_help, opts)
"     vim.keymap.set('n',          'gD',        vim.lsp.buf.declaration, opts)
"     vim.keymap.set('n',          'gd',        vim.lsp.buf.definition, opts)
"     vim.keymap.set('n',          'gi',        vim.lsp.buf.implementation, opts)
"     vim.keymap.set('n',          'gr',        vim.lsp.buf.references, opts)
"     vim.keymap.set('n',          'K',         vim.lsp.buf.hover, opts)
"     vim.keymap.set('n',          '<space>D',  vim.lsp.buf.type_definition, opts)
"     vim.keymap.set('n',          '<space>F',  function() vim.lsp.buf.format { async = true } end, opts)
"     vim.keymap.set('n',          '<space>rn', vim.lsp.buf.rename, opts)
"     vim.keymap.set('n',          '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
"     vim.keymap.set('n',          '<space>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
"     vim.keymap.set('n',          '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
"     vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
"   end,
" })
"
" local builtin = require('telescope.builtin')
" vim.keymap.set('n', '<leader>f', builtin.find_files, {})
" vim.keymap.set('n', '<leader>g', builtin.git_files, {})
" vim.keymap.set('n', '<leader>b', builtin.buffers, {})
" vim.keymap.set('n', '<leader>d', builtin.git_status, {})
" vim.keymap.set('n', '<leader>/', builtin.live_grep, {})
" vim.keymap.set('n', '<leader>?', builtin.grep_string, {})
"
" EOF

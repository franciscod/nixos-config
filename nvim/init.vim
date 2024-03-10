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

set updatetime=100 "fast gitgutter

let mapleader=" "
map <leader><leader> :Commands<CR>
map <leader>/ :execute 'Rg ' . input('Rg/')<CR>
map <leader>b :Buffers<CR>
map <leader>d :GFiles?<CR>
map <leader>f :Files<CR>
map <leader>g :GFiles<CR>
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

map [b :bprev<CR>
map ]b :bnext<CR>

set list
set listchars=tab:\|\ ,trail:·,space:·,extends:>,precedes:<,nbsp:+
match Todo /\s\+$/

lua <<EOF

require'lspconfig'.zls.setup{}
require'lspconfig'.clangd.setup{}

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n',          '<C-k>',     vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n',          'gD',        vim.lsp.buf.declaration, opts)
    vim.keymap.set('n',          'gd',        vim.lsp.buf.definition, opts)
    vim.keymap.set('n',          'gi',        vim.lsp.buf.implementation, opts)
    vim.keymap.set('n',          'gr',        vim.lsp.buf.references, opts)
    vim.keymap.set('n',          'K',         vim.lsp.buf.hover, opts)
    vim.keymap.set('n',          '<space>D',  vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n',          '<space>f',  function() vim.lsp.buf.format { async = true } end, opts)
    vim.keymap.set('n',          '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n',          '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n',          '<space>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
    vim.keymap.set('n',          '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
  end,
})

EOF

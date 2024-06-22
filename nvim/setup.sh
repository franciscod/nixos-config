mkdir -p pack/clones/start
cd pack/clones/start

git clone https://tpope.io/vim/repeat.git
git clone https://tpope.io/vim/sensible.git
git clone https://tpope.io/vim/sleuth.git && vim -u NONE -c "helptags sleuth/doc" -c q
git clone https://tpope.io/vim/fugitive.git && vim -u NONE -c "helptags fugitive/doc" -c q
git clone https://tpope.io/vim/eunuch.git && vim -u NONE -c "helptags eunuch/doc" -c q
git clone https://tpope.io/vim/surround.git && vim -u NONE -c "helptags surround/doc" -c q
git clone https://github.com/junegunn/fzf
git clone https://github.com/junegunn/fzf.vim
git clone https://github.com/sainnhe/everforest
git clone https://github.com/mg979/vim-visual-multi && vim -u NONE -c "helptags vim-visual-multi/doc" -c q
git clone https://github.com/Olical/vim-enmasse
git clone https://github.com/leafo/moonscript-vim.git
git clone https://github.com/neovim/nvim-lspconfig
git clone https://github.com/fatih/vim-go.git
git clone https://github.com/airblade/vim-gitgutter
git clone https://github.com/tpope/vim-commentary
git clone https://github.com/nvim-lua/plenary.nvim
git clone https://github.com/nvim-telescope/telescope.nvim -b 0.1.6

mkdir -p pack/clones/start
cd pack/clones/start

git clone https://tpope.io/vim/sensible.git
git clone https://tpope.io/vim/sleuth.git && vim -u NONE -c "helptags sleuth/doc" -c q
git clone https://tpope.io/vim/fugitive.git && vim -u NONE -c "helptags fugitive/doc" -c q
git clone https://tpope.io/vim/eunuch.git && vim -u NONE -c "helptags eunuch/doc" -c q
git clone https://github.com/junegunn/fzf
git clone https://github.com/junegunn/fzf.vim
git clone https://github.com/sainnhe/everforest
git clone https://github.com/mg979/vim-visual-multi 
git clone https://github.com/Olical/vim-enmasse
git clone https://github.com/leafo/moonscript-vim.git

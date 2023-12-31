mkdir -p pack/clones/start
cd pack/clones/start

git clone https://tpope.io/vim/sensible.git
git clone https://tpope.io/vim/sleuth.git && vim -u NONE -c "helptags sleuth/doc" -c q
git clone https://tpope.io/vim/fugitive.git && vim -u NONE -c "helptags fugitive/doc" -c q
git clone https://github.com/junegunn/fzf
git clone https://github.com/junegunn/fzf.vim
git clone https://github.com/sainnhe/everforest

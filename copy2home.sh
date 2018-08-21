pushd ~
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf
cp .tmux/.tmux.conf.local .
popd
sudo apt-get install python-pip python-dev build-essential
sudo pip install powerline-shell
cp -a configs/. ~/
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

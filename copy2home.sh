#!/bin/bash

# install needed package
sudo apt-get install python-pip python-dev build-essential tmux automake pkg-config
sudo pip install powerline-shell
pushd ~
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf
cp .tmux/.tmux.conf.local .
popd

# copy my config
cp -a configs/. ~/

# install vim stuff
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim -c 'PluginInstall' -c 'qa!'

# install ctag
pushd /tmp
git clone https://github.com/universal-ctags/ctags.git
cd ctags
./autogen.sh
./configure
make
sudo make install
popd

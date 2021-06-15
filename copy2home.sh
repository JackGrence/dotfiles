#!/bin/bash

# install needed package
sudo apt-get update
sudo apt-get install python3-pip python-dev build-essential tmux automake pkg-config curl vim
sudo python3 -m pip install powerline-shell
sudo python3 -m pip install virtualenvwrapper
sudo apt-get install rxvt-unicode

read -p "Install tmux? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
	pushd ~
	git clone https://github.com/gpakosz/.tmux.git
	ln -s -f .tmux/.tmux.conf
	cp .tmux/.tmux.conf.local .
	popd
fi

# copy my config
echo "Copy my config to home..."
cp -a configs/. ~/

# install vim stuff
read -p "Install vim plugin? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	vim -c 'PluginInstall' -c 'qa!'
fi

# install ctag
read -p "Install ctag? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
	pushd /tmp
	git clone https://github.com/universal-ctags/ctags.git
	cd ctags
	./autogen.sh
	./configure
	make
	sudo make install
	popd
fi

pushd /tmp
git clone https://github.com/majutsushi/urxvt-font-size.git
mkdir -p ~/.urxvt/ext/
cp urxvt-font-size/font-size ~/.urxvt/ext/
popd

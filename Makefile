all: ubuntu_package tmux ctag urxvt conf2home vimplugin

ubuntu_package:
	sudo apt-get -y install vim python3-pip python-dev build-essential tmux automake pkg-config curl
	sudo python3 -m pip install powerline-shell
	sudo -H python3 -m pip install virtualenvwrapper
	sudo apt-get -y install rxvt-unicode

tmux:
	cd ~; \
	git clone https://github.com/gpakosz/.tmux.git; \
	ln -s -f .tmux/.tmux.conf; \
	cp .tmux/.tmux.conf.local .;

conf2home:
	cp -a configs/. ~/

home2conf:
	for i in `find configs/ -type f -printf "%P\n"`; do cp ~/$$i configs/$$i; done

vimplugin:
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim; \
	vim -E -c 'PluginInstall' -c 'qa!';

ctag:
	cd /tmp; \
	git clone https://github.com/universal-ctags/ctags.git; \
	cd ctags; \
	./autogen.sh; \
	./configure; \
	make; \
	sudo make install;

urxvt:
	cd /tmp; \
	git clone https://github.com/majutsushi/urxvt-font-size.git; \
	mkdir -p ~/.urxvt/ext/; \
	cp urxvt-font-size/font-size ~/.urxvt/ext/;

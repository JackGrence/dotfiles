#!/bin/bash

set -e

SUDO='sudo'
if [ "`id -u`" = "0" ]; then
  SUDO=''
fi

update () {
  mkdir -p ~/.config/nvim
  cp ./lua ~/.config/nvim/ -r
  cp ./init.lua ~/.config/nvim/init.lua
  cp ./plugin/jdtls.lua ~/.config/nvim/plugin/jdtls.lua
}

diff () {
  for fn in `find . -type f | grep -v 'setup\...$'`; do
    cp ~/.config/nvim/$fn $fn
  done
}

install () {
  case "`uname`" in
    Linux)
      $SUDO apt install -y git
      pushd /tmp/
      wget https://github.com/neovim/neovim/releases/download/v0.8.3/nvim-linux64.deb
      $SUDO apt install ./nvim-linux64.deb
      popd
      git clone --depth 1 https://github.com/wbthomason/packer.nvim \
         ~/.local/share/nvim/site/pack/packer/start/packer.nvim
      ;;
  esac
}

# change to script dir
cd $(dirname "$0")

case "$1" in
  install)
    install
    update
    ;;
  update)
    update
    ;;
  diff)
    diff
    ;;
  *)
    ;;
esac

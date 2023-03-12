#!/bin/bash

set -e

update () {
  cp ./lua ~/.config/nvim/ -r
  cp ./init.lua ~/.config/nvim/init.lua
}

diff () {
  for fn in `find . -type f | grep -v 'setup\...$'`; do
    cp ~/.config/nvim/$fn $fn
  done
}

install () {
  case "`uname`" in
    Linux)
      sudo apt install git
      sudo snap install --beta nvim --classic
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

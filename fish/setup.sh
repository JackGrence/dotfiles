#!/bin/bash

set -e

SUDO='sudo'
if [ "`id -u`" = "0" ]; then
  SUDO=''
fi

update () {
  mkdir -p ~/.config/fish
  cp ./config.fish ~/.config/fish/
  cp functions ~/.config/fish/ -r
}

diff () {
  cp ~/.config/fish/config.fish .
  for fn in `ls ~/.config/fish/functions | grep -v fzf | grep -v fish_user | grep -v fisher`; do
    cp ~/.config/fish/functions/$fn functions/
  done
}

install () {
  case "`uname`" in
    Linux)
      $SUDO apt install -y fish
      $SUDO chsh -s `which fish` `whoami`
      fish -c 'set -Ux EDITOR (which nvim)'
      fish -c 'set -Ux VIRTUAL_ENV_DISABLE_PROMPT 1'
      fish -c 'fish_add_path -U ~/.local/bin'
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

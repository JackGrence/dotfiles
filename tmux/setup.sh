#!/bin/bash

set -e

SUDO='sudo'
if [ "`id -u`" = "0" ]; then
  SUDO=''
fi

update () {
  cp ./.tmux.conf.local ~/
}

diff () {
  for fn in `find . -type f | grep -v 'setup\...$'`; do
    cp ~/$fn $fn
  done
}

install () {
  case "`uname`" in
    Linux)
      $SUDO apt install -y tmux git
      pushd ~
      git clone https://github.com/gpakosz/.tmux.git
      ln -s -f .tmux/.tmux.conf
      popd
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

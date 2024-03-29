#!/bin/bash

set -e

SUDO='sudo'
if [ "`id -u`" = "0" ]; then
  SUDO=''
fi

update () {
  cp ./.gitconfig ~/.gitconfig
}

diff () {
  cp ~/.gitconfig ./.gitconfig
}

install () {
  case "`uname`" in
    Linux)
      $SUDO apt install git
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

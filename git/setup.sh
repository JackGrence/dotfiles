#!/bin/bash

set -e

update () {
  cp ./.gitconfig ~/.gitconfig
}

diff () {
  cp ~/.gitconfig ./.gitconfig
}

install () {
  case "`uname`" in
    Linux)
      sudo apt install git
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

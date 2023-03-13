#!/bin/bash

set -e

SUDO='sudo'
if [ "`id -u`" = "0" ]; then
  SUDO=''
fi

update () {
  return
}

diff () {
  return
}

install () {
  case "`uname`" in
    Linux)
      $SUDO apt-get install -y autoconf pkg-config build-essential
      pushd /tmp
      git clone https://github.com/universal-ctags/ctags.git
      cd ctags
      ./autogen.sh
      ./configure
      make -j
      $SUDO make install
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

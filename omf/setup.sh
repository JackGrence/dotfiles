#!/bin/bash

set -e

SUDO='sudo'
if [ "`id -u`" = "0" ]; then
  SUDO=''
fi

update () {
  mkdir -p ~/.config/omf
  cp bundle channel theme ~/.config/omf/
}

diff () {
  for fn in `find . -type f | grep -v 'setup\...$'`; do
    cp ~/.config/omf/$fn $fn
  done
}

install () {
  case "`uname`" in
    Linux)
      git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
      ~/.fzf/install
      curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install > /tmp/omf.fish
      fish /tmp/omf.fish --noninteractive
      fish -c 'omf install bobthefish'
      fish -c 'omf install https://github.com/dracula/fish'
      fish -c 'set -U theme_color_scheme zenburn'
      fish -c 'curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher'
      fish -c 'fisher install PatrickF1/fzf.fish'
      pushd /tmp/
      wget 'https://github.com/sharkdp/bat/releases/download/v0.22.1/bat-musl_0.22.1_amd64.deb'
      $SUDO dpkg -i bat-musl_0.22.1_amd64.deb
      $SUDO apt install fd-find
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

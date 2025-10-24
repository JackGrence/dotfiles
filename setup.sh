#!/bin/bash
set -ex

# lazyvim
mv ~/.config/nvim{,.bak}
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git
cp ./lazyvim/colorscheme.lua ~/.config/nvim/lua/plugins/

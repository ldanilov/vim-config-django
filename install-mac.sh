#!/usr/bin/env bash

cd ~/
ln -s .vim/.vimrc
ln -s .vim/.ctags
ln -s .vim/.gitconfig

bash ~/.vim/update-mac.sh

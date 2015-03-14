#!/usr/bin/env bash

cd ~/
ln -s .vim/.vimrc
ln -s .vim/.ctags
ln -s .vim/.gitconfig

git submodule update --init --recursive

cd ~/.vim/bundle/YouCompleteMe
./install.sh --clang-completer

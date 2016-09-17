#!/usr/bin/env bash

######################
# Requirements check
for APP in pyenv brew vim git
do
    hash $APP 2>/dev/null || { echo >&2 "'$APP' must be installed. Aborting."; exit 1; }
done
######################
# Vim needs to compile with python support
# and 'system' version (OSX - I use pyenv) works best
pre_update_python_version="$(pyenv global)"
pyenv global 2.7
######################
# Update brew (to update vim)
brew update
###########
# This will pop stashed vim make configuration
# which was stashed during the brew update.
cd /usr/local && git stash pop
brew upgrade vim
# Here's a copy:
#    system "./configure", "--prefix=#{HOMEBREW_PREFIX}",
#                          "--enable-pythoninterp",
#                          "--mandir=#{man}",
#                          "--enable-multibyte",
#                          "--with-tlib=ncurses",
#                          "--enable-cscope",
#                          "--with-features=huge",
#                          "--with-compiledby=Homebrew",
#                          "--with-python-config-dir=/System/Library/Frameworks/Python.framework/Versions/2.6/lib/python2.6/config",
#                          *opts
######################
# Update submodules
cd ~/.vim && git submodule foreach "(git checkout master; git pull; git submodule update --init --recursive)"
######################
# Re-compile YouCompleteMe
cd ~/.vim/bundle/YouCompleteMe && sudo ./install.sh --clang-completer
######################
# Revert the pyenv python version
pyenv global $pre_update_python_version

echo "====================================================================="
echo
echo "Done! Now: git add . && git commit -m 'submodule updates' && git push"
echo

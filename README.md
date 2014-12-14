What is this?
===============================================

This is Lev's own vim set up so that he doesn't have to do 
it over again every time he needs to set up a new environment.

It's a git repo and it uses 'git submodule' to sync up with 
third party repo's.

To begin with, follow these steps.
===============================================

Once this repo is clones, get all the third-party packages. 

1. Make sure this repo is cloned to ~/.vim directory

2. Create a symlink in your home directory to .vimrc by:

```
cd ~/ \
ln -s .vim/.vimrc
```

3. Do this: 

```
git submodule update --init --recursive
```

4. To get YouCompleteMe working, do this:

On Mac (requires xcode and MacVim installed)
```
cd ~/.vim/bundle/YouCompleteMe
./install.sh --clang-completer
```

Otherwise, read 'bundle/YouCompleteMe/README.md'

Pathogen Setup
===============================================

This setup uses vim-pathogen. It's located in bundles directory
with all the other extensions. The 'autoload' is sym-linked
to the 'bundle/vim-pathogen/autoload'

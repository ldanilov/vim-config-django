What is this?
===============================================

This directly is Lev's own vim environment set up so that
he doesn't have to do it over again every time he needs to 
set up a new environment.

It's a git repo and it uses 'git submodule' to sync up with 
third party repo's.

To begin with, follow these steps.
===============================================

Once this repo is clones, get all the third-party packages. 

1. Do this: 

```
git submodule update --init --recursive
```

2. To get YouCompleteMe working, do this:

On Mac (requires xcode installed):
```
cd ~/.vim/bundle/YouCompleteMe
./install.sh --clang-completer
```

Otherwise, read 'bundle/YouCompleteMe/README.md'

Pathogen Setup
===============================================

This setup uses vom-pathogen. It's located in bundles dir
with all the other extensions. The 'autoload' is sym-linked
to the 'bundle/vim-pathogen/autoload'

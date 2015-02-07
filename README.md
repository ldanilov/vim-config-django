What is this?
===============================================

This is Lev's own vim set up so that he doesn't have to do 
it over again every time he needs to set up a new environment.

It uses `git submodule` to sync up with third party repo's.

To begin with, follow these steps.
===============================================

Once this repo is cloned, get all the third-party packages. 

1. Clone it to `~/.vim` directory

2. Create a symlink in your `~/` to `.vimrc` running:

```
cd ~/ \
ln -s .vim/.vimrc
```

3. Run this to clone all of the submodules I use: 

```
git submodule update --init --recursive
```

4. To get YouCompleteMe working, run this:

On Mac (requires xcode and MacVim installed)
```
cd ~/.vim/bundle/YouCompleteMe
./install.sh --clang-completer
```

Otherwise, read 'bundle/YouCompleteMe/README.md'

Want to add more plugins?
===============================================

Run something like this:
```
git submodule add https://path.to.git.repo.vim bundle/repo
```

Real life example:
```
git submodule add https://github.com/rizzatti/dash.vim bundle/dash
```

Commit it.

Pathogen Setup
===============================================

This setup uses vim-pathogen. It's located in bundles directory
with all the other extensions. The 'autoload' is sym-linked
to the 'bundle/vim-pathogen/autoload'

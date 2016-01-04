What is this?
===============================================

This is my own vim set up for mac so I would not have to do 
it over again every time I needs to set up a new environment.

It uses `git submodule` to sync up with third party repo's.

To begin with, follow these steps.
===============================================

Once this repo is cloned, get all the third-party packages. 

1. Clone it to `~/.vim` directory

2. Install on OSX with:

**Important: read through the file to see what it does.**
```
bash ~/.vim/install-mac.sh
```

3. Update on OSX with: (Skip this if you just did Step 2)

**Important: read through the file to see what it does.**
```
bash ~/.vim/update-mac.sh
```

### Note: To get YouCompleteMe working on Mac install xcode.

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

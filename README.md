# README

# Getting Started
```
$ git clone https://github.com/technetos/neovim_setup.git ~/.config/nvim
$ cd ~/.config/nvim
$ git submodule update --init
```

# Update a Specific Plugin
```
$ cd ~/.config/nvim/bundle/rust.vim
$ git pull origin master
```

# Update All Plugins
```
$ git submodule foreach git pull origin master
```

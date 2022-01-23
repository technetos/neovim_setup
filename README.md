# README

# Dependencies
<details>
<summary>neovim python3 library</summary>

```
pip3 install --user neovim
```
</details>

# Getting Started
```
git clone https://github.com/technetos/neovim_setup.git ~/.config/nvim
cd ~/.config/nvim
git submodule update --init
```

# Update a Specific Plugin
```
cd ~/.config/nvim/bundle/plugin
git pull origin master
```

# Update All Plugins
```
git submodule foreach git pull origin master
```

# Add a plugin
Navigate to the bundle directory
```
cd ~/.config/nvim/bundle
```

All plugins are stored as git submodules
```
git submodule add https://github.com/user/plugin.git
```

Add the plugin to `init.vim`
```
execute pathogen#interpose('bundle/plugin')
```

Commit the changes

# Remove a plugin
Remove the entry in `.gitmodules`, the entry will look something like the
following

```
[submodule "bundle/plugin"]
	path = bundle/plugin
	url = https://github.com/user/plugin.git
```

Remove the entry in `.git/config`, the entry will look something like the
following

```
[submodule "bundle/plugin"]
	url = https://github.com/user/plugin.git
	active = true
```

Remove the plugin from the index

```
git rm --cached bundle/plugin
```

Remove the untracked plugin
```
rm -rf bundle/plugin
```

Remove the plugin from `init.vim` and commit the changes

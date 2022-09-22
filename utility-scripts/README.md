# dotfiles - scripts - utils

This folder contains utility scripts made to be available in `$PATH` (without the `.sh` extension)

## Installing a new script
* Installer must be run from the `scripts` folder.
* Script name must be specified **without** `.sh`.
* This will create a `symlink` for the script in `~/bin`.
```
~/.config/dotfiles/utility-scripts $ ./_install.sh new_script_name
```

## Uninstalling a script
* Uninstaller must be run from the `scripts` folder.
* Script name must be specified **without** `.sh`.
* This will remove the `symlink` for the script in `~/bin`.
```
~/.config/dotfiles/utility-scripts $ ./_uninstall.sh some_script_name
```

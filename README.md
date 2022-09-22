# dotfiles

My personal configuration files and shell utils.

## Config files

The `config` folder contains all used config files.

Files and folders under `config/home` will be symlinked into the user's home folder.

## Utility scripts

The `scripts` folder contains all used scripts.

* To install all of them, use `setup/scripts/scripts-install.sh`.
* To individually install scripts, see the [utility scripts README](./scripts/README.md).


## Setup

Clone this repo into your `$HOME/.config` folder.


### Dotfiles install on a non-fresh install.

Call `dotfiles-install.sh` from the project folder:

```
~/.config/dotfiles $ setup/scripts/dotfiles-install.sh
```


### Utility scripts install on a non-fresh install.

Call `scripts-install.sh` from the project folder:

```
~/.config/dotfiles $ setup/scripts/scripts-install.sh
```

### Post setup after a fresh Debian install.

Call `debian-post-install.sh` from the project folder:

```
~/.config/dotfiles $ setup/scripts/debian-post-install.sh
```

This will automatically call `dotfiles-install` and `scripts-install`.

#### Change screen resolution

By default the setup process leaves a resolution of `1920x1080`.

If you want to change it, edit `/etc/profile.d/custom-screen-resolution.sh`.

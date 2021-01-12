
# moleFBSD

# Installation

Follow the installer.

# After installation

After installation, log in as root and install doas.
If package manager is not installed, do that (prompted, when installing first package).
Then run

```sh
echo "permit nopass <user>" > /usr/local/etc/doas.conf
```

After that log out of root user and log in as <user>.
First let's install some necessary packages.

```sh
doas -- pkg install <packages>
```

Packages:

* git
* zsh
* zsh-syntax-highlighting
* xorg
* xterm
* xf86-input-synaptics
* xf86-input-mouse
* vim/neovim
* openbox -- for this build
* tint2 -- for this build
* compton -- for this build
* vscode -- for this build
* pcmanfc -- for this build
* menumaker -- for this build -- cleans openbox menu
* obconf -- for this build -- confing openbox
* firefox
* nitrogen
* htop
* wget
* psearch
* portmaster
* zathura
* zathura-pdf-mupdf
* mpv
* redshift
* fd-find
* fzf
* ripgrep
* hermit-font -- my preffered font
* xclip
* xclipboard
* xbindkeys -- for this build
* keepassxc

So for example:

```sh
# packages for initial setup
doas -- pkg install git zsh zsh-syntax-highlighting xorg xterm \
	xf86-input-synaptics xf86-input-mouse \
	openbox vscode tint2 pcmanfc compton\ #for this build
	neovim firefox htop wget psearch portmaster \
	hermit-font ripgrep fd-find nitrogen
```

After installing the programs,
let's pull the current FreeBSD build from git.
Before that, we need to configure our git email and username.

```sh
git config --global user.name "<username>"
git config --global user.email "<email>"
```

Now let's pull the git repository.
Run the setup script, that copies the configuration files to the correct spot.

```sh
cd #go to <user> home directory
mkdir Documents
cd Documents
git clone https://github.com/moledoc/<current moleBSD build>
cd <build name>
sh .setup.sh #TODO: this script
```

Now let's change the shell to zsh

```sh
chsh -s zsh
# then insert the user password
```

#TODO

```sh
mmaker openbox -t xterm
```


# Notes 

## Poudriere

This section is taken from previous moleBSD build.

TODO: add this


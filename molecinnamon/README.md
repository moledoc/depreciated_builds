
# moleLinux

## Installation

* Select the distribution of choice.
* Download the .iso.
* Burn the iso
  
```sh
lsblk # show available devices
dd if=<path to iso> of=/dev/sdX status="progress"
```

* Run the installer. If it's commandline install, then use documentation or there are some documentation in older mole<distro> repositories.

## After installation

* Boot into system
* Change sudo/doas permissions for user. As root

```sh
EDITOR=vi;visudo # for sudo
# comment in line
# %wheel ALL=(ALL) NOPASSWD: ALL
# %sudo ALL=(ALL) NOPASSWD: ALL
echo "permit <user> nopass" > /usr/etc/doas.conf # for doas

# The above is the authors preference.
# If it is too unsecure for some, use
 
visudo # for sudo
# comment in line
# %wheel ALL=(ALL) ALL
echo "permit <user> pass" > /usr/etc/doas.conf # for doas (check doas manual for this option)
```

* Log out as root, log in as <user>.
* update package manager, eg

```sh
sudo pacman -Syu # Arch based
sudo apt update; sudo apt upgrade # Debian(/Ubuntu) based
```

* If git is not on the system, install it.

```sh
sudo pacman -S git # Arch based
sudo apt install git # Debian(/Ubuntu) based
```

* Go to $HOME/Documents/ and clone molelinux repository.

```sh
cd $HOME/Documents
git clone https://github.com/moledoc/molelinux.git
```

* Run the setup script.

	* includes downloading some programs;
	* changing user shell (to do it manually, check the script);
	* **CURRENTLY SET FOR DEBIAN BASED DISTRIBUTION!!!**

```sh
cd molelinux
sh .setup.sh
```

* check with package manager is used and make symbolic link to correct aliases file. For example

```sh
ln -s $HOME/.config/zsh/.zPmAliases $HOME/.config/zsh/.aptAliases # Debian based
ln -s $HOME/.config/zsh/.zPmAliases $HOME/.config/zsh/.pacmanAliases # Arch based
```

* The general setup should be done. Some tweaking might be necessary, but it is not covered in this readme.

## moleLinux setup

This subsection describes authors preferences in programs.
Also presents a list of most commonly used programs, fonts etc.

* doas over sudo, but if there is no doas option sudo works fine. Also, for doas and sudo both I use nopass option (using doas/sudo doesn\'t require password). Just my preference.
* program: default terminal (+ xterm just in case)

	* program: drop down terminal: guake (but tilda is ok too)

* program: zsh (zsh-syntax-highlighting)
* program: neovim(nvim)/vim (quick edits) / xed for GUI quick edits
* program: firefox
	
	* vim bindings pluggin
	* duckduckgo pluggin
	* addblock (eg ublock) pluggin
	* privacybadger plugin
	* change privacy settings

* program: fzf (also use as launcher -- see .scripts/open.zsh)
* program: keepassxc (password manager)
* program: redshift
* program: xbindkeys/sxhkd or WM/DE default keybindings editor.
* program: htop
* program: fd-find (replacement for find; faster)
* program: ripgrep (replacement for grep; faster)
* program: (any gui filemanager is fine (nemo,thunar,pcmanfm,dolphin))
* program: nitrogen (if there is no wallpaper handling in the DE or WM)
* program: zathura (zathura-pdf-mupdf/-poppler; for viewing pdf\'s)
* program: mpv (video and audio files); vlc for backup, explore mpd for music(?)
* program: IDE for development (corresponding to the language, eg RStudio,Intellij)
* program: tmux (multiplexer)

* font: fonts-hermit (might have different package name)
* colorscheme: gruvbox colorscheme
* options: swap caps and esc (not needed if programmable keyboard), setxkbmap -option caps:swapescape 
* options: have keybindings for different language, eg setxkbmap -layout us

## Main keybindings

Ground rules:

* Window managing is centered around **super** key
* nvim/vim managing is centered around **alt** key
* (drop down) terminal managing is centered around **ctrl** key


## Notes

### Cinnamon DE

* To import keyboard shortcuts, make sure dconf-cli package is installed.

```sh
dconf dump /org/cinnamon/desktop/keybindings/ > dconf-settings.conf # export
dconf dump /org/cinnamon/desktop/keybindings/ < dconf-settings.conf # import
```

### RStudio

* Get gruvbox theme from https://tmtheme-editor.herokuapp.com/#!/editor/theme/Gruvbox (should also be in repo)
* Under 'Tools > Global Options' change keybindings to vim, font to hermit and add gruvbox theme. On Debian/Ubuntu based distribution, package libxml2-dev is needed. Also install 'xml2' in RStudio (will put the necessary package into write place, so no manual intervention needed).

```r
install.packages('xml2')
```


## TODO

* improve this README
* make this build
* Keep this build up-to-date

## Author

Written by
Meelis Utt

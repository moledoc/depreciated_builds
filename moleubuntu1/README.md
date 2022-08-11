# molecurrent

## Installation

* Select the distribution of choice.
* Download the .iso.
* Burn the iso

```sh
lsblk # show available devices
dd if=<path to iso> of=/dev/sdX status="progress"
```

* Run the installer. If it's commandline install, then use documentation or there are some documentation in older depreciated_builds/mole<distro> repositories.

## After installation

* Boot into system
* Check that new user has right to elevate privileges.

**doas:**

```
# Allow <user> to use doas without password
echo "permit nopass <user>" > /usr/local/etc/doas.conf

## Allow user to use doas (asks password every time)
echo "permit <user>" > /usr/local/etc/doas.conf
```

**sudo:**

```sh
sudo visudo # for sudo
```

Add (preferred) lines

```
# Allow wheel group users to use sudo (asks password every time)
%wheel ALL=(ALL) ALL

# Allows sudo and wheel group users to use sudo (does not asks password)
%wheel ALL=(ALL) NOPASSWD: ALL
%sudo ALL=(ALL) NOPASSWD: ALL
```

or **as user**, one can do for doas

```sh
# example
echo "permit <user> nopass" | sudo tee /usr/local/etc/doas.conf
echo "<user> ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/<user>
```

* Log out as root, log in as <user>.
* update package manager, eg

```sh
sudo pacman -Syu # Arch based
sudo apt update; sudo apt upgrade # Ubuntu/Debian based
sudo eopkg upgrade # Solus
```

* If git is not on the system, install it.

```sh
sudo pacman -S git # Arch based
sudo apt install git # Ubuntu based
sudo eopkg install git # Solus
```

* Go to $HOME/Documents/ (if doesn't exist, make directory) and clone molecurrent repository.

```sh
cd $HOME/Documents
git clone https://github.com/moledoc/molecurrent.git
```

* Run the setup script.

	* includes downloading some programs;
	* changing user shell;
	* loading DE settings and other configurations;

```sh
cd $HOME/Documents/molecurrent
sh .setup.sh
```

* The general setup should be done.
Some tweaking might be necessary, but it is not covered in this readme.

## My build preferences

This subsection describes authors preferences in programs:

* **elevate privileges**: doas over sudo, but if there is no doas option, sudo works fine. Also, for doas and sudo both, I prefer to use nopass option (using doas/sudo doesn\'t require password).
* **shell**: zsh (zsh-syntax-highlighting)
* **terminal**: default terminal (gnome-terminal) + xterm for backup;
* **depr: terminal**: drop down terminal: guake
* **terminal editor**: neovim(nvim)/vim
* **version control**: git
* **IDE(-like)/editor for development**: VsCode+autosync settings (and RStudio for .R, .Rmd)
* **ecosystem**: link google account at ubuntu startup, because then I get my calendar, todo etc events/noticifations
* **browser**: ~~firefox~~ chrome

	* vim bindings pluggin
	* *depr*/*optional* duckduckgo pluggin
	* addblock (eg ublock) pluggin
	* privacybadger plugin
	* change privacy settings

* **password manager**: keepassxc
* **system monitoring (terminal)**: htop for system monitoring
* **file manager**: any GUI filemanager is fine
* **run launcher**: run launcher that comes with DE; if no runlauncher some good choices

  * dmenu

* **night light**: if not provided, then redshift
* **theme**:  currently Yaru-light
* **colorscheme**: solarized light
* **font**: the default font
* **document**: the default one is fine, but for scripting and more minimal viewer zathura-pdf-mupdf/-poppler
* **image viewer**: the default is fine (in ubuntu its eog (eye of gnome))
* **media**: VLC (video), but good alternatives Rythmbox (audio), mpv/mpd (terminal video/audio)
* **torrents**: transmission
* **multiplexer**: tmux **TODO:** need to learn to use
* **options**: swap caps and esc (not needed for programmable keyboard),gui option or run: setxkbmap -option caps:swapescape
* **options**: have keybindings to switch between different language (ie Alt+Shift), set in settings; in terminal run eg: setxkbmap -layout us

Replacements:

* fd(-find) (replacement for find; faster)
* ripgrep (replacement for grep; faster)
* exa (replacement for ls; nicer)
* nitrogen (if there is no wallpaper handling in the DE or WM)

other useful/good programs:

* wget: pull stuff from web
* curl: pull stuff from web; REST API
* fzf: fuzzy finder
* sxhkd: simple way to manage keybindings


## Notes

### Settings import/export

* for Gnome, Cinnamon and Budgie, dconf-cli package is necessary.
* Gnome DE (or anything that uses Gnome): to import/export all Gnome settings, run:

```sh
#import
dconf load /org/gnome/ < $HOME/.config/gnome/gnome-settings
#export
dconf dump /org/gnome/ > $HOME/.config/gnome/gnome-settings
```

* Cinnamon DE: to import/export keyboard shortcuts/themes, run:

```sh
# export
dconf dump /org/cinnamon/desktop/keybindings/ > $HOME/.config/cinnamonDE/wm-settings
dconf dump /org/cinnamon/theme/ < .config/cinnamonDE/theme-settings.conf
# import
dconf load /org/cinnamon/desktop/keybindings/ < $HOME/.config/cinnamonDE/wm-settings
dconf load /org/cinnamon/theme/ < $HOME/.config/cinnamonDE/theme-settings.conf
```

* Budgie DE: to import/export budgie-panel/-raven/-wm, run:

```sh
# export
dconf dump /com/solus-project/budgie-panel/ > $HOME/.config/budgieDE/panel-settings
dconf dump /com/solus-project/budgie-raven/ > $HOME/.config/budgieDE/raven-settings
dconf dump /com/solus-project/budgie-wm/ > $HOME/.config/budgieDE/wm-settings
# import
dconf load /com/solus-project/budgie-panel < $HOME/.config/budgieDE/panel-settings
dconf load /com/solus-project/budgie-raven < $HOME/.config/budgieDE/raven-settings
dconf load /com/solus-project/budgie-wm < $HOME/.config/budgieDE/wm-settings
```

* gnome-terminal: to import/export only gnome terminal settings, run (analogical for other settings):

```sh
# export
dconf dump /org/gnome/terminal/ > $HOME/.config/gnome-terminal/gnome-terminal-settings
# import
dconf load /org/gnome/terminal < $HOME/.config/gnome-terminal/gnome-terminal-settings
```

* guake terminal

```sh
# export
guake --save-preferences $HOME/.config/guake/.guakeconf &
# import
guake --restore-preferences $HOME/.config/guake/.guakeconf &
```

* RStudio

	* **depr (but for info will keep)**: Get gruvbox theme from https://tmtheme-editor.herokuapp.com/#!/editor/theme/Gruvbox (should also be in repo)
	* **depr (but for info will keep)**: Under 'Tools > Global Options' change keybindings to vim, add gruvbox theme. On Debian/Ubuntu based distribution, package libxml2-dev is needed. Also install 'xml2' in RStudio (will put the necessary package into right place, so no manual intervention needed).


## Author

Meelis Utt

#!/bin/sh

# README: setup my (ubuntu) system, after git pull or downloading the repo.

# should exit script, when it fails
set -e

notice()
{
  echo "\n--------------------------------------"
  echo $1
}

# set update, install, package manager etc variables
sleeping=2
updateCmd="sudo apt update -y && sudo apt upgrade -y"
installCmd="apt install -y"
pkg_manager="apt"
dryRun="--dry-run"
echo "Setup for Ubuntu will start in ${sleeping}sec (Ctrl+c to cancel)"

# Give user ${sleeping}sec to cancel setup
sleep ${sleeping}

# get user name
user=$(who)
user=${user%% *}

# Download packages (set for ubuntu atm).
packages="git gnome-terminal xterm vim-gtk zsh zsh-syntax-highlighting neovim vim firefox fzf wget curl keepassxc htop fd-find ripgrep zathura-pdf-poppler xclip dconf-cli gnome-tweaks zip unzip vlc transmission dash exuberant-ctags doas golang texlive-full pandoc guake" 
surf="libwebkit2gtk-4.0-dev libgcr-3-dev make"
#additional pkgs = gnome-boxes redshift tmux eog gnome-mpv libxtst-devel libpng-devel
forFun="cowsay"

# gnome-boxes = VM
# transmission = torrent
# eog - eye of gnome (image viewer)
# dconf-cli to load gnome settings
# wmctrl to list window processes
# libxtst-devel libpng-devel -- for some R packages
# gnome-tweak-tool -- extra tweaks in gnome DE
# programmingPkg= vscode  # rstudio 
# comms = discord
# vim-gtk is compiled with coping to system clipboard enabled
# exuberant-ctags is for ctags for vim (autocomplete)

notice "Update package manager"
eval $updateCmd
notice "Dry run package installation"
$installCmd $dryRun $packages $forFun $surf
notice "Installing packages: $packages $forFun $surf"
sudo $installCmd $packages $forFun $surf
notice "Packages installed"

## swap esc and caps
#notice "Swapping CapsLock and escape"
#setxkbmap -option caps:swapescape
#notice "CapsLock and escape swapped"

new_shell="zsh"
notice "Changing shell to $new_shell"
chsh -s /bin/$new_shell
notice "Shell changed to $new_shell"

# setup git
notice "Setting up git for user"
echo "Insert git --global user.name: " 
read varUsername
git config --global user.name "$varUsername"
echo "Insert git --global user.email: " 
read varEmail
git config --global user.email "$varEmail"
notice "Setup git aliases"
git config --global alias.s "status"
git config --global alias.a "add"
git config --global alias.c "commit -m"
git config --global alias.p "push"
git config --global alias.pu "pull"
git config --global alias.d "diff"
git config --global alias.l "log"
git config --global alias.co "checkout"
git config --global alias.b "branch"
git config --global alias.m "merge"
git config --global alias.r "reset"
git config --global alias.rh "reset --hard"
git config --global alias.d "fetch"
git config --global alias.orig "remote show origin"
git config --global alias.co- "checkout --"
git config --global alias.squash "merge --squash"
git config --global alias.uncommit "reset --soft HEAD^"
git config --global alias.back "checkout @{-1}"
git config --global alias.adog "log --all --decorate --oneline --graph"
notice "Git config set up"

# create ssh key for git
notice "Create ssh key for accessing git."
if [ ! -d "/home/$user/.ssh" ]; then mkdir -v /home/$user/.ssh; fi
ssh-keygen -t rsa -b 4096 -C "$varEmail" -f /home/$user/.ssh/git_key -P ""
# change git remote from https to ssh
notice "Change git remote from https to ssh"
if [ ! -d ".git" ]
then
    git init
    git remote add origin git@github.com:moledoc/molecurent.git
fi
#git remote -v set-url origin git@github.com:moledoc/molecurent.git  

notice "Copy repository to /home/$user"
curDir=$(readlink -f .)
cd /home/$user/.config
rm -f appearance.zip RStudio rstudio budgieDE cinnamonDE gnome gruvbox-xml nvim solarized.vim wallpaper.jpg zsh
cd /home/$user
rm -f README.md .scripts .vimrc .zprofile .zshrc
cd $curDir
ln -s "$curDir/README.md" "/home/$user/"
ln -s $curDir/.config/* "/home/$user/.config/"
ln -s "$curDir/.scripts" "/home/$user/.scripts"
ln -s "$curDir/.vimrc" "/home/$user/.vimrc"
ln -s "$curDir/.zprofile" "/home/$user/.zprofile"
ln -s "$curDir/.zshrc" "/home/$user/.zshrc"
tar -xvf .config/surf.tar
sudo cp surf/surf /usr/local/bin
rm -rf surf
export GDK_BACKEND=x11
notice "Repository contents copied to /home/$user"

# add symlink to package manager aliases
notice "Create symlink to correct package manager aliases"
rm -vf /home/$user/.config/zsh/.z_pm_aliases
ln -vs /home/$user/.config/zsh/.z_${pkg_manager}_aliases /home/$user/.config/zsh/.z_pm_aliases
notice "Symlink to package manager aliases created"

## install VimPlug (nvim/vim pluggin manager)
#notice "Install VimPlug to /home/$user/.config/nvim/plugged"
#mkdir -vp /home/$user/.config/nvim/plugged
#sh -c 'curl -fLo "${XDG_DATA_HOME:-/home/$user/.local/share}"/nvim/site/autoload/plug.vim --create-dirs\
#	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
#
#notice "Run PlugInstall, to install defined pluggins to neovim"
#nvim +PlugInstall +qa
#
## add gruvbox and solarized for vim (and nvim) as well
#notice "Add gruvbox colorscheme to vim colors"
#sudo cp -v /home/$user/.config/nvim/plugged/gruvbox/colors/gruvbox.vim /usr/share/vim/vim8*/colors
#sudo cp -v /home/$user/.config/solarized.vim /usr/share/vim/vim8*/colors
#sudo cp -v /home/$user/.config/solarized.vim /usr/share/nvim/runtime/colors

## load DE settings
notice "Load DE settings"
$new_shell /home/$user/.scripts/load_settings.sh
notice "DE settings loaded"

# Set up root passwd
notice "Set root password"
sudo passwd
notice "Root password changed"

# set up sudo and doas
notice "Make doas config (both in /etc and /user/local/etc)"
echo "permit nopass ${user}" | sudo tee /usr/local/etc/doas.conf
echo "permit nopass ${user}" | sudo tee /etc/doas.conf
notice "doas configured"

notice "Update sudo config"
echo "${user} ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/${user}
notice "sudo configured"

## set up Yaru
#notice "Add Yaru themes, icons and sounds to the system"
#unzip /home/$user/.config/appearance.zip -d /home/$user/.config/
#sudo cp -rv /home/$user/.config/appearance/* /usr/share/
#rm -r /home/$user/.config/appearance
#notice "Yaru added"

# Set up default wallpaper
gsettings set org.gnome.desktop.background picture-uri file:////home/$user/.config/wallpaper.jpg


notice "Copy github_key.pub to clipboard"
xclip -selection clipboard < /home/$user/.ssh/git_key.pub

notice "Opening firefox for \
    chrome, \
    vscode, \
    discord install; \ 
    github to add ssh key; \ 
    bazecor for DygmaRaise software; \
    appimage launcher for integrated appimage launching \ 
    (install .deb files, so those can be installed automatically afterwards)"
firefox "chrome.com" "https://code.visualstudio.com/" "https://discord.com/" "github.com/login" "gitlab.com/users/sign_in" "https://github.com/TheAssassin/AppImageLauncher/releases" "https://dygma.com/pages/bazecor" > /dev/null

# install the .deb files we just downloaded
printf "Press enter, when all wanted .deb files are downloaded to /home/$user/Downloads/ directory.\n" 
read null
if [ $(ls /home/$user/Downloads/ | grep 'deb' | wc -l) -gt 0 ]
then
    for filename in /home/$user/Downloads/*.deb
    do
      sudo dpkg -i ${filename}
    done
fi

# install digidoc
notice "Downloading and installing digidoc"
curl https://installer.id.ee/media/install-scripts/install-open-eid.sh > "/home/$user"/Downloads/install-open-eid.sh
chmod +x "/home/$user"/Downloads/install-open-eid.sh
sh "/home/$user"/Downloads/install-open-eid.sh

# golang
notice "Downloading and installing go specific tools"
go get -u golang.org/x/tools/cmd/goimports 
go get -u golang.org/x/tools/cmd/godoc
go get -u golang.org/x/lint/golint

cowsay -f bud-frogs "SETUP DONE!
Logging out in 5sec"

# Log user out
sleep 5
gnome-session-quit --force

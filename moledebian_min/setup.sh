#!/bin/sh
set -e

user=$(whoami)

# Script to make alternative setup
packages="xorg \
	libx11-dev \
	libxft-dev \
	libxinerama-dev \
	libxrandr-dev \
	clang \
	git \
	make \
	wget \
	curl \
	doas \
	alsa-utils \
	dunst \
	pulseaudio \
	libedit-dev \
	autotools-dev \
	automake \
	fzf \
	tmux \
	universal-ctags \
	chromium \
	libnotify-bin \
	xclip \
	xsel \
	desktop-file-utils \
	network-manager \
	zsh \
	zsh-syntax-highlighting \
	vim-gtk3 \
	mpv \
	keepassxc \
	xinput \
	xautolock \
	fuse \
	ntfs-3g \
	zathura \
	blueman \
	playerctl \
	scrot \
	htop \
	fonts-noto-color-emoji \
	fonts-hack"
su -c "apt install --dry-run $packages
apt update -y && apt upgrade -y; apt install -y $packages
echo \"permit nopass $user
permit nopass $user cmd /usr/bin/tee args /sys/class/backlight/*/brightness
\" > /etc/doas.conf"

# disable root password
doas -- sed -i 's/root:x:0:0:root:\/root:\/bin\/bash/root:x:0:0:root:\/root:\/sbin\/nologin/g' /etc/passwd

# suckless
git clone https://git.suckless.org/dwm
git clone https://git.suckless.org/st
git clone https://git.suckless.org/dmenu
git clone https://git.suckless.org/slock

cd dwm  ; cp config.def.h config.h; patch config.h ../.patches/dwm.patch  ; doas -- make clean install; cd ..
cd st   ; cp config.def.h config.h; patch config.h ../.patches/st.patch   ; doas -- make clean install; cd ..
cd slock; cp config.def.h config.h; patch config.h ../.patches/slock.patch; doas -- make clean install; cd ..
cd dmenu; cp config.def.h config.h; patch config.h ../.patches/dmenu.patch; doas -- make clean install; cd ..

# zsh as login shell
chsh -s /usr/bin/zsh

# keyboard default option
test -d /etc/default || doas -- mkdir -v /etc/default
test -f /etc/default/keyboard || echo 'XKBOPTIONS=""' | doas -- tee /etc/default/keyboard
doas -- sed -i 's/XKBOPTIONS=""/XKBOPTIONS="caps:swapescape"/g' /etc/default/keyboard
## add left alt toggle for xkb
# doas -- sed -i 's/XKBOPTIONS=""/XKBOPTIONS="caps:swapescape,grp:alt_shift_toggle"/g' /etc/default/keyboard
# doas -- sed -i 's/XKBLAYOUT="us"/XKBLAYOUT="us,ee"/g' /etc/default/keyboard

# disable ttys
doas -- sed -i 's/\[1-6\]/[1-2]/' /etc/default/console-setup

## set doas back to permit for user
#doas -- sed -i '1,1s/nopass/persist/' /etc/doas.conf

# clean files before linking
rm -fr "$HOME/.config" "$HOME/.scripts"
rm -f "$HOME/.xinitrc" "$HOME/.profile" "$HOME/.zprofile" "$HOME/.vimrc" "$HOME/.zshrc" "$HOME/.bashrc" "$HOME/.tmux.conf"

# link files
path=$(pwd)
ln -s "$path/.zshrc" "$HOME/.zshrc"
ln -s "$path/.vimrc" "$HOME/.vimrc"
ln -s "$path/.bashrc" "$HOME/.bashrc"
ln -s "$path/.config" "$HOME/.config"
ln -s "$path/.scripts" "$HOME/.scripts"
ln -s "$path/.xinitrc" "$HOME/.xinitrc"
ln -s "$path/.profile" "$HOME/.profile"
ln -s "$path/.zprofile" "$HOME/.zprofile"
ln -s "$path/.tmux.conf" "$HOME/.tmux.conf"

# manually install completion and vimwiki pluggins
mkdir -p ~/.vim/pack/bundle/start
git clone --depth 1 https://github.com/lifepillar/vim-mucomplete.git ~/.vim/pack/bundle/start/vim-mucomplete
git clone https://github.com/vimwiki/vimwiki.git ~/.vim/pack/plugins/start/vimwiki

# set up battery cronjob for backup
(crontab -l 2>/dev/null; echo "* * * * * low-battery.sh") | crontab -

# TODO:  remove unnecessary installed packages (eg notify-send <- verify this)

doas -- systemctl reboot

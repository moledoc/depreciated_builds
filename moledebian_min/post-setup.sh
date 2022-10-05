#!/bin/sh

set -e

printf "Insert git user: "
read gitUser
printf "Insert git email: "
read gitEmail
git config --global user.name "$gitUser"
git config --global user.email "$gitEmail"
repoLoc=$(find $HOME -type d -name "*molecurrent")
cd $repoLoc
git remote set-url origin git@github.com:moledoc/molecurrent.git
cd -

# wget "https://github.com/TheAssassin/AppImageLauncher/releases/download/v2.2.0/appimagelauncher_2.2.0-travis995.0f91801.bionic_amd64.deb"
# doas -- dpkg -i "appimagelauncher_2.2.0-travis995.0f91801.bionic_amd64.deb"
# wget "https://github.com/Dygmalab/Bazecor/releases/download/bazecor-0.3.3/Bazecor-0.3.3.AppImage"
# mkdir -p $HOME/Applications
# mv Bazecor-0.3.3.AppImage $HOME/Applications
# chmod +x $HOME/Applications/Bazecor-0.3.3.AppImage
# $HOME/Applications/Bazecor-0.3.3.AppImage &

# TODO:
mkdir -p $HOME/.ssh
ssh-keygen -t rsa -b 4096 -C "$gitEmail" -f $HOME/.ssh/git_key -P ""
xclip -selection clipboard < $HOME/.ssh/git_key.pub
$BROWSER "github.com/login" &

# install go and go tools
wget --show-progress https://go.dev/dl/go1.19.linux-amd64.tar.gz 
doas -- rm -rf /usr/local/go && doas -- tar -C /usr/local -xzf go1.19.linux-amd64.tar.gz
rm -f go1.19.linux-amd64.tar.gz
go install golang.org/x/tools/cmd/goimports@latest
go install golang.org/x/tools/cmd/godoc@latest
go install golang.org/x/lint/golint@latest
go install github.com/go-delve/delve/cmd/dlv@latest

# printf "Install digidoc\n"
wget https://installer.id.ee/media/install-scripts/install-open-eid.sh
sed -i 's/sudo/doas/g;s/^test_doas$//' $HOME/install-open-eid.sh
chmod +x install-open-eid.sh
$HOME/Downloads/install-open-eid.sh
rm -f install-open-eid.sh
doas -- apt autoremove

# set default programs
mimeopen -d .sh
mimeopen -d .txt
mimeopen -d .md
mimeopen -d .go
mimeopen -d .c
mimeopen -d .mp3
mimeopen -d .mp4
mimeopen -d .mkv
mimeopen -d .avi
mimeopen -d .html
doas -- update-desktop-database

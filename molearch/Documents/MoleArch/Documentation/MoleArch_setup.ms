.de BL
.IP \[bu] 2
..

.de rL
.IP # 0.2i
..

.de uL
.IP $ 0.2i
..

.TL
MoleArch
.AU
Meelis Utt
.LP
The purpose of this documentation:
.BL
have simplified installation documentation for ArchLinux,
so that I can reinstall Arch simply on any machine;
.BL
have documentation of how and what I set up for my system;
.BL
have documentation about the programs I use
(not complete documentation,
only functionalities that I use).
.NH
ArchLinux installation
.LP
After installation,
the machine has ArchLinux with already some MoleArch flavor.
There are no users, no GUI etc. 
Only root user, a command-line,
and the following programs: grub, man, sudo, vim, zsh.
.NH 2
Setup
.LP
I'll add how to diskdump an ISO to a USB from Linux.
.RS
.uL
dd if=<path to iso> of=/dev/sdX status="progress"
.RE
where sdX is the usb device (can be checked with lsblk)

Before starting the installation,
check if one has UEFI mode enabled on UEFI board.
If yes, then it's recommended to follow the official installation guide at
https://wiki.archlinux.org/index.php/Installation_guide.
Else follow this guide.

If the following command gives error, then the machine does not have UEFI mode enabled.
.RS
.rL
ls /sys/firmware/efi/efivars
.RE

Set up wifi (if one is using ethernet, then this is not necessary).
.RS
.rL
wifi-menu 
.RE
Check connection with 'ping <website>'.

(optional) If one wants to change keyboard settings, then check the available keymaps using
.RS
.rL
ls /usr/share/kbd/keymaps/**/*.map.tar.
.RE
Then use
.RS
.rL
loadkeys <keymap>
.RE
For example, loadkeys et.

Ensure system clock is accurate.
.RS
.rL
timedatectl set-ntp true
.RE

.NH 2
Partition, format and mount disk
.LP
In this documentation it is assumed,
that sda is partitioned.
If one wants to partition other disk,
then use that disk instead of sda

To check available disks use the following command.
.RS
.rL
fdisk -l
.RE
To enter into the mode, where one can partition the disks,
then use the command
.RS
.rL
fdisk /dev/sda
.RE
I got it to work normally (without grub error),
if I only did 1 partition.
The following commands are applicable in fdisk.
.RS
.IP ~ 0.2i
d (repeat until all the partitions are deleted; delete partitions)
.IP ~
n (then p <Enter> <Enter> <Enter>; make new partiton as primary and partiton takes up all the space)
.IP ~
w (write the partition)
.IP ~
exit
.RE

Format the partition.
.RS
.rL
mkfs.ext4 /dev/sda1
.RE

Mount the file system on root partition.
.RS
.rL
mount /dev/sda1 /mnt
.RE

If other partitions where made,
then make corresponding directories (eg /boot and /home)
and mount the corresponding partitions there.
Also, if swap was made,
then use mkswap and swapon commands on correct mounting point.
.NH 2
Install and setup essential and wanted packages; generate necessary files
.LP
First three are must.
.RS
.rL
pacstrap /mnt base linux linux-firmware vi vim-minimal man-db man-pages texinfo sudo grub
.RE

Generate fstab (check /mnt/etc/fstab for errors).
.RS
.rL
genfstab -U /mnt >> /mnt/etc/fstab.
.RE

Change into new system.
.RS
.rL
arch-chroot /mnt
.RE

Set timezone.
.RS
.rL
ln -sf /usr/share/zoneinfo/<Region>/<City> /etc/localtime
.RE

To generate /etc/adjtime, run
.RS
.rL
hwclock --systohc
.RE

Set locales.
Uncomment the necessary locales in /etc/locale.gen (for eg. en_US.UTF-8; ee_ET.UTF-8).
.RS
.rL
vim /etc/locale.gen
.RE

Generate locales.
.RS
.rL
locale-gen
.RE

Create locale.conf and set LANG variable (and keyboard layout, if wanted)
.RS
.rL
vim /etc/locale.conf 
.RS
LANG=en_US.UTF-8 
.RE
(# vim /etc/vconsole.conf) 
.RS
(KEYMAP=<keymap_value>; eg us, ee)
.RE
.RE
.NH 2
Network configuration, grub and root password
.LP
Create files /etc/hostname and /etc/hosts.
.RS
.rL
vim /etc/hostname
.RS
MoleArch
.RE
.rL
vim /etc/hosts
.RS
.IP
127.0.0.1	localhost
.IP
::1		localhost
.IP
127.0.0.1	MoleArch.localdomain MoleArch
.RE
.RE

Install network manager and iputils.
.RS
.rL
pacman -S iputils networkmanager
.IP #
systemctl enable NetworkManager
.RE

Set root password.
.RS
.rL
passwd
.RE

Set up grub.
We already installed it, but if one did not install it, then install it.
.RS
.rL
(pacman -S grub)
.IP #
grub-install --target=i386-pc /dev/sda
.RE
Make grub config file
.RS
.rL
grub-mkconfig -o /boot/grub/grub.cfg
.RE

Exit the chroot environment (optionally unmount) and reboot.
.RS
.rL
exit
.IP #
(umount -R /mnt)
.IP #
reboot
.RE
.NH
MoleArch setup
.NH 2
Wifi setup
.LP
Before I move on to adding a new user,
I need the Internet access. 
The reason for that is that I want MoleArch to use zsh right away.
One could install it later aswell,
but I think it is easier to set up basic zsh for new user this way.

If install was done over wifi,
then one can connect to that wifi (if available). To check which connections exists,
one can run the following command (here it's assumed, that NetworkManager is used).
.RS
.rL
nmcli connection
.RE
If found the connection, then we can run the following command
.RS
.rL
nmcli connection up uuid <UUID>
.RE
where UUID could be obtained from the nmcli connection command. 
One could type the UUID in manually, however we can use the following command to do that for us.
.RS
.rL
nmcli connection | grep <SSID> | awk '{print $2}' | xargs -I {} nmcli connection up uuid '{}'
.RE
Add -a flag, to be asked a password.
This is necessary when there is no connection file in the directory /etc/NetworkManager/system-connections (need to be the root user).
The mentioned flag can be used in the commands we are about to mention aswell.

If one wants to connect to undefined wifi network, then to check available networks one can use the following command.
.RS
.rL
nmcli device wifi list
.RE
To connect, one can use the following command.
.RS
.rL
nmcli device wifi connect <SSID> password <password>
.RE
If one does not want to type password,
so that everyone can see,
then use the -a flag.
.RS
.rL
nmcli -a device wifi connect <SSID>
.RE
.NH 2
Add new user
.LP
As mentioned at the beginning,
I want the new user to have zsh.
Let's install zsh.
.RS
.rL
pacman -S zsh
.RE
Add new user to the group wheel (usual practice),
with default zsh as the default shell.
.RS
.rL
useradd -s /bin/zsh -m -g wheel <new user>
.RE
Add password to the new user.
.RS
.rL
passwd <new user>
.RE
Now we need to uncomment the sudo capabilities of the wheel group in the /etc/sudoers file.
.RS
.rL
vim /etc/sudoers
.RS
If one does not want to type in password after logging in, then uncomment (MoleArch choice):
.RS
%wheel ALL=(ALL) NOPASSWD: ALL
.RE
If one wants to have to type in password every time, then uncomment:
.RS
%wheel ALL=(ALL) ALL
.RE
.RE
.RE

Now it is reasonable to log out of root and login in as the new user.
If there is further interest in modifing the user in any way, then check 
https://wiki.archlinux.org/index.php/Users_and_groups password <password>.
.NH 2
ZSH (and dash)
.LP
Since I set zsh as the default shell for the user,
then when logging into the new user for the first time,
zsh config function is prompted.
Follow that.
Most settings were set on and command history is saved into ~/.config/zsh/.histfile

After zsh basic configuration, 
let's log into the new user.

(At first dash was intended to be used instead of bash.
However, for the time being, MoleArch will use bash.
Still, the way to make system use dash instead of bash (and vise versa)
is still left here.

To check what is used for running scripts run the following command.
.RS
$ ls -l /bin/sh
.RE
Use dash instead of bash.
.RS
$ ln -sf dash /bin/sh
.RE
)
.NH 2
Setting up and configuring
.LP
At the moment, we have installed vim-minimal.
This probably does not support copy/paste from/to system clipboard.
For this we will install gvim (graphical vim; not going to use the graphical vim, but it is compiled with clipboard functionality).
.RS
.uL
sudo pacman -S gvim
.RE

.B
!!!!!!!! NEED TO SET UP SOME NEOVIM CONFIGS,
SOME THINGS BROKE ( py self funs eg) and SOME IS ANNOYING
(file~ eg). CURRENTLY zsh_aliases the vim = nvim has been turned off
and I'm using gvim until I have time to tinker and config nvim.

I'm trying Neovim out.
Install neovim.
.RS
.uL
sudo pacman -S neovim
.RE
Neovim can be call out with command
.RS
.uL
nvim
.RE
and uses init.vim as a config.
However, we can use the current vimrc.
To check how,
in nvim type 
.RS
:help nvim-from-vim
.RE

Let's install some plugins for zsh.
The .zshrc file we end up using is in the git repository.
But more on that soon.
.RS
.uL
sudo pacman -S zsh-syntax-highlighting
.RE

Install and setup git so we can access the existing
MoleArch dotfiles, scripts, documentation etc (git pull to the $HOME folder).
Also, git allows to download from AUR, use git etc.
.RS 
.uL
sudo pacman -S git
.RE
Config the git global user.
.RS
.uL
git config --global user.name "<username>"
.IP $
git config --global user.email "<email>"
.RE

Since there are no folders in the home directory,
let's make the basic folders automatically
(can be done manually).
First install the package.
.RS 
.uL
sudo pacman -S xdg-user-dirs
.RE
Then run the following command.
.RS 
.uL
xdg-user-dirs-update
.RE
Additionally, let's add following hidden folders.
.RS 
.uL
mkdir ~/.scripts
.uL
mkdir ~/.suckless
.RE
Also, let's make some additional directories in Documents.
.RS
.uL
cd ~/Documents
.uL
mkdir Testing
.uL
mkdir Projects
.uL
Rolling_files
.RE

Let's install a display server.
We are going to install Xorg.
.RS 
.uL
sudo pacman -S xorg-server xorg-xinit
.RE 

Install fonts.
.RS 
.uL
sudo pacman -S noto-fonts
.RE

Let's install a driver.
Check the driver with the following command.
.RS 
.uL
lspci | grep -e VGA -e 3D
.RE

Install the driver.
.RS 
.uL
sudo pacman -S xf86-video-<driver>
.RE

Since we did not install base-devel previously,
but we want to be able to install from the AUR, 
then let's install base-devel
(--needed flag only installs the packages that are missing).
.RS 
.uL
sudo pacman -S --needed base-devel
.RE

For sound,
let's install alsa-utils.
.RS 
.uL
sudo pacman -S alsa-utils
.RE
To get the CLI sound mixer, use the following command.
.RS
.uL
alsamixer
.RE

Install acpid and acpi,
which helps to handle different events.
.RS 
.uL
sudo pacman -S acpi acpid
.RE
Enable systemctl service.
.RS
.uL
systemctl enable acpid.service
.RE
Now let's set up a configuration to handle screen brightness and volume events (if necessary).
For this run the command
.RS
.uL
acpi_listen
.RE
and push the button (compinations),
to get the acpi button identity.
For now we check the following buttons: volume up, volume down, mute, brightness up, brightness down.
Let's enable volume control. For that we do the following.
.RS
.uL
sudo vim /etc/acpi/events/vol-u
.RS
.IP
event=button/volumeup <acpi_identity>
.IP
action=amixer set Master 1+
.RE
.uL
sudo vim /etc/acpi/events/vol-d
.RS
.IP
event=button/volumedown <acpi_identity>
.IP
action=amixer set Master 1-
.RE
.uL
sudo vim /etc/acpi/events/vol-m
.RS
.IP
event=button/mute <acpi_identity>
.IP
action=amixer set Master toggle
.RE
.RE
New let's enable brightness control. For that we will use a script.
.RS
.uL
sudo mkdir /etc/acpi/handler
.uL
sudo vim /etc/acpi/handler/bl
.RS
.IP
#!/bin/sh
.IP
bl_dev=/sys/class/backlight/<correct_folder_to_working_backlight>
.IP
step=5
.IP
case $1 in
.IP
      -) echo $(($(< $bl_dev/brightness) - $step)) >$bl_dev/brightness;;	
.IP
      +) echo $(($(< $bl_dev/brightness) + $step)) >$bl_dev/brightness;;	
.IP
esac
.RE
.uL
sudo chmod +x /etc/acpi/handler/bl
.uL
sudo vim /etc/acpi/events/bl_u
.RS
.IP
event=video/brightnessup <acpi_identity>
.IP
action=/etc/acpi/handlers/bl +
.RE
.uL
sudo vim /etc/acpi/events/bl_d
.RS
.IP
event=video/brightnessdown <acpi_identity>
.IP
action=/etc/acpi/handlers/bl -
.RE
.RE
.RS
.uL
systemctl restart acpid.service
.RE
Let's add an event for when there is a screenlock function key on the computer.
.RS
.uL
sudo vim /etc/acpi/events/scr_lck
.RS
.IP
event=button/screenlock <acpi_identity>
.IP
action=slock
.RE
.RE
Now we need to restart acpid.service.
Also, in the future I might add other event handlers aswell.

Install utility to manage/have a simple firewall.
Also, enable the service with systemctl (TODO: study the utility more).
.RS
.uL
sudo pacman -S nftables
.uL
systemctl enable nftables.service
.RE

Install utility to be able to see the what are the keyboard and mouse values sent to xorg.
.RS
sudo pacman -S xorg-xev
.RE
The program can be run with the following command.
.RS
.uL
xev
.RE

Before installing suckless utilities,
we need to install make,
so we could compile the programs.
(The package fontconfig was also needed 
when trying to make st,
but I have to test,
if it's needed when dmenu is installed first).
.RS
.uL
sudo pacman -S make (fontconfig)
.RE
For terminal we are going to install simple terminal (st) from suckless.
Before installing st,
let's install dmenu,
since it seems it solves some problems further down the road when making st.
.RS
.uL
sudo pacman -S dmenu
.RE
Since one might not be in a graphical environment yet,
then we go with the git version.
.RS
.uL
cd ~/.suckless
.uL
git clone https://git.suckless.org/st
.uL
cd st
.uL
sudo make clean install
.RE
Let's install some patches.
Under suckless.org->st->patches, 
select the following patches, download them and move them to directory ~/.suckless/st.
.RS
.BL
scrollback- allows to scroll back in st.
.uL
cd ~/suckless/st
.uL
patch -p<nr of patch> < <patch>
.RS
.BL
Add the first (scrollback) patch. For this one needs to add two lines manually to config.h. For example:
.IP
	{ XK_ANY_MOD,           XK_Page_Up,     kscrollup,      {.i = -1} },
.IP
	{ XK_ANY_MOD,           XK_Page_Down,   kscrolldown,    {.i = -1} },
.IP
In this case, we allow scrolling in terminal with just PgUp and PgDn keys.
The corresponding keynames might be different in different machines and can/should be changed for personal preference. 

Another example what to do:
.IP
	{ ShiftMask,           	XK_Page_Up,     kscrollup,      {.i = -1} },
.IP
	{ ShiftMask,          	XK_Page_Down,   kscrolldown,    {.i = -1} },
.IP
	{ XK_ANY_MOD,           XK_Prior,	kscrollup,      {.i =  1} },
.IP
	{ XK_ANY_MOD,           XK_Next,	kscrolldown,    {.i =  1} },

One can add analogically scrolling with a mouse. I haven't figured it out yet how to scroll with a trackpoint.
.RE
.uL
sudo make clean install
.RE

The following suckless utilities can be installed later.

Install coping CLI tool sselp or xclip.
.RS
.uL
sudo pacman -S xclip
.uL
cd ~/.suckless
.uL
wget https://dl.suckless.org/tools/sselp-0.2.tar.gz
.uL
tar -xvzf <tar.gz name>
.uL
cd sselp
.uL
sudo make clean install
.RE

Install suckless utility for locking screen.
.RS
.uL
cd ~/.suckless
.uL
git clone https://git.suckless.org/slock
.RE
Now let's change the values for user and group.
The group will be 'wheel' (if not chosen otherwise) and the user will be the current user.
Then run the commands.
.RS
.uL
sudo make clean install
.RE
If wanted, change the color of init, input and failed.
One possiblity is to keep the default colors and git pull already configured slock.
Let's create a service that locks screen when the lid is closed.
.RS
.uL
sudo vim /etc/systemd/system/slock@.service
.IP
[Unit]
.IP
Description=Lock X session using slock for user %i
.IP
Before=sleep.target

[Service]
.IP
User=<user>
.IP
Environment=DISPLAY=:0
.IP
ExecStartPre=/usr/bin/xset dpms force suspend
.IP
ExecStart=/usr/bin/slock

[Install]
.IP
WantedBy=sleep.target
.RE
If this does not work,
then locate the slock machine code and change the ExecStart value accordingly.
Example
.RS
.BL
ExecStart=/usr/locale/bin/slock
.RE
One can use the commend
.RS
.uL
whereis slock
.RE
to locate the correct path.

It is recommended to make file /usr/share/X11/xorg.conf.d/xorg.conf,
to block tty access when in an X and prevent a user from killing when it is running.
.RS
.uL
sudo vim /usr/share/X11/xorg.conf.d/xorg.conf
.RS
.IP
Section "ServerFlags"
.IP
	Option "DontVTSwitch" "True"
.IP
	Option "DontZap"      "True"
.IP
EndSection
.RE
.RE
Now lets enable the slock service (if enable does not work, do a restart aswell).
.RS
.uL
systemctl enable slock@<user>.service
.RE

Install suckless browser and enable it to have tabbed window.
On suckless's page, it is recommended to build ones own WebKitGTK.
First go to https://webkitgtk.org/releases/ and take the latest stable version.
Let's download it to the Downloads directory at the moment.
.RS
.uL
cd ~/Downloads
.uL
wget <url of the tar>
.uL
tar -xf webkitgtk-<version>.tar.xz
.uL
cd webkitgtk-<version>
.IP
(resolve all deficiencies, meaning install all necessary packages)
.uL
cmake -DPORT=GTK -DCMAKE_BUILD_TYPE=RelWithDebInfo -GNinja
.uL
ninja
.uL
sudo ninja install
.RE
.RS
.uL
cd ~/.suckless
.uL
git clone https://git.suckless.org/surf
.uL
cd surf
.uL
sudo pacman -S gcr (webkit2gtk) (needed for make install; gcr is a  crypto tool I think; webkit2gtk is the engine)
.uL
sudo make clean install
.uL
git clone https://git.suckless.org/tabbed
.uL
cd tabbed
.uL
sudo make clean install
.uL
sudo pacman -S gstreamer gst-libav gst-plugins-good (for video support in surf; however, if not installed, eg yt runs faster for me, I anyway youtube-dl them and use mpv)
.RE
the last line for video support, did not solve the problem with video audio.

To make surf bit more functional,
then we will apply some patches.
Under suckless.org->surf->patches, 
select the following patches, download them and move them to directory ~/.suckless/surf.
.RS
.BL
modal - allows to use vim keys without Ctrl.
.BL
playexternal plays video in external program (mpv)
.BL
(searchengine - allows to set shortcuts to search engines)
.BL
(web search - gives duckduckgo search bar functionality)
.uL
cd ~/suckless/surf
.uL
patch -p<nr of patch> < <patch>
.uL
sudo make clean install
.RE
If there are any errors when patching,
then manually include the lines from .rej file to the corresponding file.
Now let's add some scripts from suckless.org->surf->files. Let's copy the following script files to ~/.surf/scripts.js.
.RS
.BL
link hints
.BL
easy links
.RE

.B
TODO: Install other suckless utilities.
.LP

.B
The parts inside parenthesis are important,
if there is no access to MoleArch git repository
(is effective unitl the end of the document).

.LP
(
Let's copy the default config files to / directory.
.RS
.uL
cp /etc/X11/xinit/xinitrc ~/.xinitrc
.uL
cp /etc/X11/xinit/xserverrc ~/.xserverrc 
.RE

Change the ~/.serverrc file as following.
.RS
exec /usr/bin/Xorg -nolisten tcp "$@" vt$XDG_VTNR
.RE
To make sure that "startx" is autostarted at login,
add the following to ~/.zprofile.
.RS
if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
.RS
exec startx
.RE
fi
.RE
)

Now let's install chosen tiling window manager,
which in this case is bspwm and sxhkd manages the hotkeys.
.RS 
.uL
sudo pacman -S bspwm sxhkd
.RE

(
Now let's add the following lines to ~/.zprofile.
.RS
.IP
XDG_CONFIG_HOME="$HOME/.config"
.IP
export XDG_CONFIG_HOME
.RE
Make directories.
.RS
.uL
mkdir ~/.config/bspwm
.uL
mkdir ~/.config/sxhkd
.RE
Copy the bspwmrc and sxhkdrc to / directory.
.RS
.uL
cp /usr/share/doc/bspwm/examples/bspwmrc ~/.config/bspwm/bspwmrc
.uL
cp /usr/share/doc/bspwm/examples/sxhkdrc ~/.config/sxhkd/sxhkdrc
.RE
Now add the following line to .xinitrc (take note to add it before other exec's).
.RS
exec bspwm
.RE
)

Now let's install status bar.
We are currently installing lemonbar (from AUR).
.RS 
.uL
mkdir .lemonbar
.uL 
cd lemonbar
.uL
git clone https://aur.archlinux.org/lemonbar-git.git
.uL
cd lemonbar-git
.uL
makepkg -sirc
.RE

(Now let's add a line to bspwmrc,
that runs lemonbar, 
when bspwm is ran
(assumes, that panel is a script,
that does all necessary to make a bar;
furthermore, it seems my current implementation is different from what I found on the Internet,
but it works for now).
.RS 
.uL
vim ~/.config/bspwm/bspwmrc
.RS
panel &
.RE
.RE
)

Now let's install all the other wanted programs.
The config files are going to end up in the MoleArch git repository.
.RS 
.uL
sudo pacman -S htop fzf keepassxc youtube-dl zathura zathura-pdf-mupdf mpv redshift sxiv scrot (nitrogen) firefox transmission-cli wget newsboat cronie texlive-most texlive-lang biber pandoc xorg-xrandr
.RE
Lastly, let's pull MoleArch git files to $HOME directory.
.RS
.uL
cd
.uL
git pull
.RE

Some more useful programs.
.RS
.BL
ntfs-3g -- ables easily mount ntfs partitions.
.RS
.uL
sudo mount -t ntfs-3g /dev/sdX <mount point>
.RE
.RE

Let's pull the MoleArch git repository to the / folder.
If MoleArch is not in the condition yet,
I would suggest not pulling to root directory and instead to other directory.
Then move/use the good bits of code, configs, scripts etc.
Also, the following commands show briefly how to do git init.
.RS
.uL
git init
.IP $
git remote add origin https://meelis_utt@bitbucket.org/meelis_utt/molearch.git
.IP $
git pull --set-upstream origin master
.RE

.NH
Some last setups
.LP
Let's add a cronjob to update newsboat every <x> minutes.
.RS
.uL
crontab -e
.RS
.IP
*/<x> * * * * /usr/bin/newsboat -x reload
.RE
.BL
If this is the first cronjob and cronie service is not enabled in systemctl yet,
then do the following.
.uL
(sudo) systemctl enable cronie.service
.RE
The following part is setting up a VGA1 monitor.
.RS
.uL
xrandr --output LVDS1 --auto --output VGA1 --auto --left-of LVDS1
.RE
Let's download Arch wiki docs into the local machine.
.RS
.uL
sudo pacman -S arch-wiki-docs
.RE
The documentation are located in /usr/share/doc/arch-wiki/.
.NH
For programming
.LP
Now we install programs necessary for programming tasks.

Install R (package tk is necessary to be able to install other packages in R)
.RS
.uL
sudo pacman -S r tk
.RE
In R run the following commands to install some most used libraries.
.RS
.BL
install.packages("tidyverse") - dplyr, plyr, etc
.BL
install.packages("rmarkdow") - to be able to run and compile Rmd files.
.RE
Let's make a .Rprofile file in the home directory.
In that we specify what we want to run when .R file is opened.
For example, we source the rolling files and functions. An example:
.RS
.uL
vim ~/.Rprofile
.RS
.IP
# Load rolling functions and other files
.IP
source(<path of rolling file>)
.IP
.IP
library(dplyr)
.RE
.RE

Install compilators for C/C++/C#.
The compilator g++ is probabily already installed.
Also install doxygen for automated documentation.
The smoother for g++ is gdb and for clang it's lldb.
.RS
.uL
sudo pacman -S clang doxygen
.RE

Install python, pip and jupyter notebook.
.RS
.uL
sudo pacman -S python python-pip jupyter-notebook
.RE
Let's add the directory ~/Documents/Rolling_files/Python_files (if the last directory does not exist, make it) to python path,
we can import the modules in that folder easily into python scripts.
.RS
.uL
cd /usr/lib/python3.8/site-packages
.uL
sudo vim self_paths.pth
.RS
.IP
/home/<user>/Documents/Rolling_files/Python_files/
.RE
.RE
If the directory to site-packages is different (python version 2.x eg),
then find correct path to that directory.
Now let's install some extra modules.
.RS
.uL
sudo pip install numpy scipy pandas dfply
.RE
Short explanation of the packages:
.RS
.BL
numpy - vector and math operators.
.BL
scipy - 
.BL
pandas - data frames in python
.BL
dfply - simulates dplyr in python (similar/same function name; piping). Only works with data.frames. See example in ~/Documents/Testing/piping_dfply_example.py
.BL
pipeop - can use pipes with other data types aswell. See example in ~/Documents/Testing/piping_dfply_example.py
.RE

.NH
A little help from a friend
.NH 2 
Programs
.LP
.RS
.BL
gim/vim - Text editor
.BL
git - git
.BL
alsa-utils - Sound
.BL
acpi, acpid - Different event handler
.BL
dmenu - program launcher essentially, but it's very extensible
.BL
st (simple terminal) - terminal emulator
.BL
sselp (&| xclip) - commandline clipboard tool (eg $(sselp) runs the primary selection in terminal)
.BL
slock - simple screenlock
.BL
tabbed - enables tabbed surf browser or terminal etc
.BL
surf - simple web browser
.BL
firefox - web browser
.BL
bspwm - binart space partition windom manager (tiling window manager)
.BL
sxhkd - simple x hotkey daemon (hotkey daemon)
.BL
lemonbar - status bar
.BL
zathura. zathura-pdf-mupdf - extensible document viers, pdf viewer
.BL
mpv - media player (music, movies)
.BL
redshift - night light essentially
.BL
sxiv - simple x image viewer
.BL
youtube-dl - downloads content from youtube
.BL
fzf - fuzzy finder (searching program)
.BL
transmission-cli - commandline torrent client
.BL
keepassxc - password manager
.BL
pass - terminal password manager (not set up yet)
.BL
wget - get's content from the web
.BL
htop - shows all active processes
.BL
nnn - terminal file manager
.BL
neomutt - terminal email client (not set up yet)
.BL
newsboat - RSS reader
.BL
w3m - terminal browser
.BL
texlive-most biber pandoc - LaTex packages and TeX for Rmd
.BL
xrandr - monitor setup
.RE

.NH 2 
Commands
.RS
.BL
pacman -<flag(s)> <program>
.RS
.IP
S -- install a program
.IP
Q -- check if installed
.RE
.RE

.NH 2
TODO
.LP
.IP
nm-applet (wifi settings)/stalonetray
.IP
neomutt
.IP
config zathurarc
.IP
firewall? (nftables)
.IP
config bspwmrc
.IP
manage dotfiles, clean .zshrc/.zprofile etc
.IP
Backup (setting up).
Do a backup script
.IP
connect android, usb, smart card reader - scripts
.IP
useful commands doc (eg pacman -Q, pacman -Syu, grep, sed etc)
.IP
power management (hibernate, sleep)
.IP
Camera, mic management
.IP
block ad & other sites
.IP
git password asking.
.IP
Virtual machine
.IP
st config/patches
.IP
password manager pass
.IP
screenshots (scrot(/imagemagick?))
.IP
esc to caps lock and caps lock to menu/alt_gr orsth
.IP
Config R for  vim (.Renviron, showing plots, installing packages in script (.Renviron point again))
.IP 
config C++ for vim
.IP
more cool VIM PLUGINS, configs etc
.IP 
lemon bar config even more optimal (bspc subscribe (Brodie vid)) + FIFO system instead of while
.IP
reinstall and path surf. Config surf. tabbed+surf
.IP
CLEAN DOCUMENTATION and add explanations to commands and programs.
.IP
CONFIG and add urls to newsboat
.IP 
Explore w3m - terminal web browser
.IP
cron vs systemd .timer
.IP
Clean vim config (also, it seems that compiling and opening to pdf might be able to compress into single command with multiple file types)
.IP
config scrot, document scrot
.IP
map lockscreen to LCKSCRN button. document process.
.IP
rsync to replace cp and mv or as an alternative ??
.IP
automatic mount/umount scripts
.IP
SETUP BACKUP AND DO BACKUPS.
.IP
xrandr document!!!!! (monitor)
.IP
setup shortcuts so they can be usable with monitor and keyboard
.IP
autorun monitor scripts (through acpi event??)
.IP
able to sleep computer, when monitor attached, with a keybinding
.IP
scroll terminal with mouse.
.IP
battery (and other) from acpi to /sys/ based 
(lukes video Using and scripting battery information)
like monitors script.
.IP
(See last point)
explore /sys/ directory.
.IP
REPEATING MYSELF, but re-organize different program conf and rc files.
look into xorg.conf. 
.RS
.BL
Xorg :0 -configure (xorg.conf.new in /root/)
.RE
for skeleton to copy to 
.IP
Monitors script run when logged in properly (smth broke)
.IP
panel not hardcoded monitors
.IP
If no monitors attached, desktops in status bar needs fix.
.IP 
config nnn and ls
.IP
zsh_env -> zshenv,
clean other files.
.IP
vimrc
.IP
learn troff/groff (for man and other stuff)
.IP
Assign eg ctrl to vim and alt to sxhkd.
.IP
Document xprop command (to get the program name x uses (and other info))

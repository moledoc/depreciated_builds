# molecurrent

## Setup

TBD

## Wifi issues

I had some issues with wifi. Made 2 sections: one for quick commands and second to expand on those commands and actions.

### TLDR;

* [get iso w/ non-free drivers](https://cdimage.debian.org/cdimage/unofficial/non-free/cd-including-firmware/11.4.0+nonfree/amd64/iso-cd/)
* [get tarbal](https://cdimage.debian.org/cdimage/unofficial/non-free/firmware/bookworm/20220801/firmware.tar.gz) and extract it to `/firmware/` on a separate USB
	* when installing connect the USB and select 'load firmware -> yes'
* Run commands:
```sh
% PATH=$PATH:/sbin
% wpa_passphrase <WifiName> | tee /etc/wpa_supplicant.conf
% wpa_supplicant -c /etc/wpa_supplicant.conf -i wlp2s0
% dhclient wlp2s0
% apt install network-manager
% nmcli --ask dev wifi connect <WifiName>
```

### With some comments

* [helpful article](https://linuxhint.com/remove_characters_string_bash/)

At first it seemed that programs related to setting up wifi are not included in the just 'system utilities' version of debian install.
Furthermore, my laptop needed some non-free drivers.
So I resolved this by:
* install the firmware iso version (normal iso might also work, I got mine setup working with the firmware-netinst.iso)
	* firmware-netinst.iso for debian 11.4 https://cdimage.debian.org/cdimage/unofficial/non-free/cd-including-firmware/11.4.0+nonfree/amd64/iso-cd/
* install firmware tarbal (https://cdimage.debian.org/cdimage/unofficial/non-free/firmware/bookworm/20220801/firmware.tar.gz) and extract it to root folder named 'firmware' on a separate USB-stick.
	* this solved my missing driver issues after which the installation contained programs to get the wifi running
* the necessary binaries are in `/sbin`, which for me was **not** in `PATH`. To type less, I assume `/sbin` is added to the `PATH`
```sh
% PATH=$PATH:/sbin
```
* The way I got my wifi running:
	* switch to root (didn't have sudo nor doas at that point)
```sh
% wpa_passphrase <WifiName> | tee /etc/wpa_supplicant.conf
% wpa_supplicant -c /etc/wpa_supplicant.conf -i wlp2s0
```
	* switch to new tty
	* switched to root
```sh
% dhclient wlp2s0
```
	* installed `network-manager`
```sh
% apt install network-manager
```
	* switched back to first tty and killed the `wpa_supplicant` command
	* bring up wifi with `nmcli`
```sh
% nmcli --ask dev wifi connect <WifiName>
```


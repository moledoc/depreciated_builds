# moleOBSD

My experiences, notes, build, documentation for OpenBSD.

## Documentation

For official documentation, check

* https://www.openbsd.org/faq/
* https://man.openbsd.org/

Install info can also be found at

* https://ftp.openbsd.org/pub/OpenBSD/<version>/<architecture>/INSTALL.<architecture>

For example: https://ftp.openbsd.org/pub/OpenBSD/6.8/amd64/

Good pages to also visit are:

* https://www.openbsd.org/faq/faq4.html#FilesNeeded
* https://ftp.openbsd.org/pub/OpenBSD/6.8/amd64/INSTALL.amd64

The second one is for a 64-bit computer specifically.

## Pre-installation

These notes are done using OpenBSD 6.8 and amd64 architecture.
When ever they are mentioned, then the person following this documentation may need to replace them according to his/her specifications.

When already running OpenBSD system, then bsd.rd is necessary for reinstall/upgrade to a newer version. General idea is changing boot kernel from /bsd to /bsd.rd
Taken from [ https://www.openbsd.org/faq/faq4.html#Download ]:

```text
  Using drive 0, partition 3.
  Loading......
  probing: pc0 com0 com1 mem[638K 1918M a20=on]
  disk: hd0+ hd1+
  >> OpenBSD/amd64 BOOT 3.33
  boot> bsd.rd
```

For different drive/partition, prefix the location to the kernel.

```text
  Using drive 0, partition 3.
  Loading......
  probing: pc0 com0 com1 mem[638K 1918M a20=on]
  disk: hd0+ hd1+
  >> OpenBSD/amd64 BOOT 3.33
  boot> boot hd1d:/bsd.rd
```

For fresh install, install and burn an OpenBSD image on an USB stick.
To verify the \*.img/\*.iso file,
download SHA256 and/or SHA256.sig from https://ftp.openbsd.org/pub/OpenBSD/6.8/amd64/
and public key from https://ftp.openbsd.org/pub/OpenBSD/6.8/openbsd-68-base.pub  
and run

```sh
# for SHA256 on OpenBSD
sha256 -C SHA256 install*.img

# for SHA256 on OS with GNU utils
sha256sum -c --ignore-missing SHA256 install*.img
```

This checks, that the files were not mangled with during the download.
To check for other corruption, use signify(1) to cryptographically verify the downloaded image.

```sh
# on OpenBSD
signify -Cp /etc/signify/openbsd-XX-base.pub -x SHA256.sig install*.img

# on GNU/linux
signify -Cp openbsd-XX-base.pub -x SHA256.sig install*.img
```

where openbsd-XX-base.pub is the downloaded public key.

Then burn the USB.
Burning an USB stick

```sh
# GNU/linux
dd if=install*.img of=/dev/sdX status="progress" bs=1M

# OpenBSD  
dd if=install*.img of=/dev/rsd6c bs=1m
```

## Installation

Follow the installer, when booting from the USB disk.
The set defaults are reasonable.
But some notes:

* when selecting HTTP server (when downloading sets through http), then '?' gives list of hostnames. The hostname can be inserted as eg. ftp.eenet.ee
* to de-select games from sets, enter -game*, when 'Set name(s)' is presented.

## After installation

As a root user, make doas config file (doas is sudo replacement; written by OpenBSD guys).

```sh
echo "permit nopass <user>" > /etc/doas.conf
```

I choose to use this doas setup (currently).
If this is bit insecure for some, consult the doas man page.

First read the default mail sent after installation is done.
It can be accessed with command 'mail'.

After that 'afterboot' man page is recommended reading.
It contains references to different help material categorized by topics.




## Notes

* System can be shut down with 
    
  ```sh
  doas -- shutdown -p now
  ```

## Author

Written by
Meelis Utt

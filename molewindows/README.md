# molewindows

## Keybindings

* alt as modkey in windows terminal

## After installation

First thing: **CREATE TWO ACCOUNTS: ONE ADMIN, ONE USER**

Go through each Settings subcategory.
Change privacy settings and personalize looks.

**LOOK AT TODO: WANT TO IMPROVE**

## Programs

* Terminals
    * windows terminal
    * powershell
    * wsl2 w/ ubuntu

* Browser 
    * firefox
        * change privacy settings
        * pluggins: duckduckgo; vim vixen; ublock; privacy badger; https everywhere

* Coding 
    * Rstudio
    * VScode
    * notepad++
    * git
    * miktex

* Comms
    * Signal
    * Skype
    * Teams

* Other
    * Keepass
    * Steam
    * AutoHotkey
    * Bazecor
    * Malwarebytes
    * Transmission
    * Toggl track

## WSL2 install
 
In PowerShell

```sh
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
wsl --set-default-version 2
```

From MS store select wanted distro (in this case ubuntu) and

* get

* install

Run WSL2 and create a user.

## Windows terminal

Install Windows terminal from MS store.
From molewindows git repository copy settings.json to C:\Users\<user>\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState

## Visual Studio Code

Install from https://code.visualstudio.com/

Install pluggins

* gruvbox material
* vim
* wsl
* python
* jupyter
* c/c++

If/when I set up sync via github, then I can get my vscode setup more easily (I suppose)

## Hyper-V

Docs to start or some other helpful links (some covered below as well):

* https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/quick-start/quick-create-virtual-machine
* https://rbwilson.ca/changing-screen-resolution-of-linux-vms-on-hyper-v/
* https://arcanecode.com/2020/12/28/adjust-the-screen-resolution-of-an-ubuntu-hyper-v-virtual-machine/
* https://win10.guru/hyper-v-virtual-machine-use-host-vpn-connection/#:~:text=Simple%3A%20just%20set%20up%20your,host%2C%20connect%20to%20a%20VPN

Using the preset linux (ubuntu) in the Hyper-V gave me pretty good performance. However, installing that took a lot of time.

Another way is to use your own specified iso. In that case I've noticed worse performance (noticable lag). Also, resizing is a bit of a hassle (at least my experience).
To resize, run this command in PowerShell with elevated privileges

```powershell
set-vmvideo -vmname debian -horizontalresolution:2560 -verticalresolution:1440 -resolutiontype single
```

and edit line `/etc/default/grub` to 
```sh
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash video=hyperv_fb:2560x1440" 
```

**NOTE:** change resolution to your liking, ie to your monitor size.

## Notes

* change font: make a new file <filename>.reg with contents

```txt
Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts]
"Segoe UI (TrueType)"=""
"Segoe UI Bold (TrueType)"=""
"Segoe UI Bold Italic (TrueType)"=""
"Segoe UI Italic (TrueType)"=""
"Segoe UI Light (TrueType)"=""
"Segoe UI Semibold (TrueType)"=""
"Segoe UI Symbol (TrueType)"=""

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\FontSubstitutes]

"Segoe UI"="<NEW-FONT-NAME>"
```

Suitable <NEW-FONT-NAME> would be "Source Code Pro".
Then right click and **merge** -> Yes -> OK

To restore font, then do the previous steps, but the file contents is 

```txt
Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts]
"Segoe UI (TrueType)"="segoeui.ttf"
"Segoe UI Black (TrueType)"="seguibl.ttf"
"Segoe UI Black Italic (TrueType)"="seguibli.ttf"
"Segoe UI Bold (TrueType)"="segoeuib.ttf"
"Segoe UI Bold Italic (TrueType)"="segoeuiz.ttf"
"Segoe UI Emoji (TrueType)"="seguiemj.ttf"
"Segoe UI Historic (TrueType)"="seguihis.ttf"
"Segoe UI Italic (TrueType)"="segoeuii.ttf"
"Segoe UI Light (TrueType)"="segoeuil.ttf"
"Segoe UI Light Italic (TrueType)"="seguili.ttf"
"Segoe UI Semibold (TrueType)"="seguisb.ttf"
"Segoe UI Semibold Italic (TrueType)"="seguisbi.ttf"
"Segoe UI Semilight (TrueType)"="segoeuisl.ttf"
"Segoe UI Semilight Italic (TrueType)"="seguisli.ttf"
"Segoe UI Symbol (TrueType)"="seguisym.ttf"
"Segoe MDL2 Assets (TrueType)"="segmdl2.ttf"
"Segoe Print (TrueType)"="segoepr.ttf"
"Segoe Print Bold (TrueType)"="segoeprb.ttf"
"Segoe Script (TrueType)"="segoesc.ttf"
"Segoe Script Bold (TrueType)"="segoescb.ttf"

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\FontSubstitutes]

"Segoe UI"=-
```

## Rstudio

Install Rstudio https://rstudio.com/products/rstudio/download/.

If it already exitst, then one can update Rstudio and its packages (in windows), when running the following in R console:

```r
install.packages("installr")
library(installr)
updateR()
```

Add gruvbox theme and enable vim emulation in Rstudio: Tools -> Global Options
Gruvbox theme filename in the repository is gruvbox.tmTheme.

## WSL2

Pull corresponding/suitable linux build from git to /home/<user>.

## AutoHotKey

Run CapsLockCtrlEscape.ahk to swap caps for escape.

From https://superuser.com/questions/954950/run-a-script-on-start-up-on-windows-10

```txt
The startup folder is still there and functions as normal.

To access it, press Windows+R, then type shell:startup.
```

To run CapsLockCtrlEscape.ahk at login, make a shortcut of the script and move it to directory C:\Users\<user>\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup,
which can be reached by running ```sh shell:startup``` at run prompt (Win+R).

## SSH

One way to generate ssh keypairs is to use gpg in wsl.
For that, consult molecurrent documentation or setup.sh.

How to add ssh keys in windows from https://stackoverflow.com/questions/18683092/how-to-run-ssh-add-on-windows

```txt
Original answer using git's start-ssh-agent

Make sure you have Git installed and have git's cmd folder in your PATH. For example, on my computer the path to git's cmd folder is C:\Program Files\Git\cmd

Make sure your id_rsa file is in the folder c:\users\yourusername\.ssh

Restart your command prompt if you haven't already, and then run start-ssh-agent. It will find your id_rsa and prompt you for the passphrase

Update 2019 - A better solution if you're using Windows 10: OpenSSH is available as part of Windows 10 which makes using SSH from cmd/powershell much easier in my opinion. It also doesn't rely on having git installed, unlike my previous solution.

    * Open Manage optional features from the start menu and make sure you have Open SSH Client in the list. If not, you should be able to add it.
    * Open Services from the start Menu
    * Scroll down to OpenSSH Authentication Agent > right click > properties
    * Change the Startup type from Disabled to any of the other 3 options. I have mine set to Automatic (Delayed Start)
    * Open cmd and type ```sh where ssh``` to confirm that the top listed path is in System32. Mine is installed at C:\Windows\System32\OpenSSH\ssh.exe. If it's not in the list you may need to close and reopen cmd.

Once you've followed these steps, ssh-agent, ssh-add and all other ssh commands should now work from cmd. To start the agent you can simply type ssh-agent.

    * Optional step/troubleshooting: If you use git, you should set the GIT_SSH environment variable to the output of where ssh which you ran before (e.g C:\Windows\System32\OpenSSH\ssh.exe). This is to stop inconsistencies between the version of ssh you're using (and your keys are added/generated with) and the version that git uses internally. This should prevent issues that are similar to this

Some nice things about this solution:

   * You won't need to start the ssh-agent every time you restart your computer
   * Identities that you've added (using ssh-add) will get automatically added after restarts. (It works for me, but you might possibly need a config file in your c:\Users\User\.ssh folder)
   * You don't need git!
   * You can register any rsa private key to the agent. The other solution will only pick up a key named id_rsa
```

If one is in a user that has no admin privileges, then open powershell in admin privileges and run

```sh
Get-Service -Name ssh-agent | Set-Service -StartupType Automatic
```

Generating ssh keys in powershell

```sh
 ssh-keygen -t rsa -b 4096 -C "<email>" -f $HOME/.ssh/<key_name>
```

In powershell ssh-agent, ssh-add should also work similarly to linux.


## Git

If file path is too long when cloning, run 

```sh
git config --system core.longpaths true
# or for specific repo
git clone -c core.longpaths=true <repo-url>
```

## MinGW

Install MinGW from https://osdn.net/projects/mingw/downloads/68260/mingw-get-setup.exe/.
Do the installation (default settings are ok).
Open MinGW Manager and under Basic Setup choose atleast mingw-developer-toolkit-bin, mingw32-gcc-g++-bin, mingw32-base-bin, msys-base-bin.
With right click mark them "Mark for installation".
If thats done, then choose "Apply Changes" from the "Installation" menu.
Run MinGW (C:/MinGW/msys/1.0/msys.bat) and test

```sh
g++ -v
make -v
```

## TODO

* learn scripting in cmd and powershell
* windows settings backup, so that there is no need for manual setup.
* make setup script/file for wsl specifically.

## Author

Written by
Meelis Utt

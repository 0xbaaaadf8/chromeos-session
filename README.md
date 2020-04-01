# chromeos-desktop

## Please read this file carefully before using this! Some features are not present or are not working properly. You should not use the lock function, as anybody can type in something random to get in.

Basically, this is lightdm-login-chromeos... reborn.

This project is a fork of a fork of the now-archived lightdm-login-chromeos project: https://github.com/FrobtheBuilder/lightdm-login-chromeos

I consider this project to be pre-release until I can get the Chromium binary to get information from the system, such as network connections. This is probably going to be a long time, as I don't know where to start. 

Additionally, this fork no longer downloads the lastest chromium builds; It downloads a stable build. This change was made because the latest versions might bring some changes which prevent the build from running properly. I'll revert my decision when this becomes a problem.

## What does this package do, exactly?

This project will install the GUI of Chromium OS on "traditional" GNU/Linux sytems, allowing you to get a basic and rough experience of what Chromium OS (and Chrome OS) feels like (with a lot of missing features.) I'm saying "traditional" because Chromium OS is quite different than most GNU/Linux distributions (Ubuntu, Debian, PureOS, Fedora, openSUSE, etc.)

(Screenshots are on the way!)

## What does this package install?

When you install this pacakge, a script is run that downloads a stable version of the Chromium browser as a zip archive. However, it has a special twist; It's a build of chromium for Chromium OS, which means it contains the GUI you'll see on Chromebooks (and the like.) Once the package has been downloaded, it is extracted into /opt/chromeos. This is where the Chrome browser resides on a Chromebook (and again, the like.) As of writing, three more files are extracted: A script extracted to /usr/bin, an xsesison (desktop environment) file extracted to /usr/share/xsessions, and a application file extracted to /usr/share/applications. The first is what gets the Chromium binary properly started for use, and it can be executed by the terminal. The second allows the Chromium binary to function as a desktop environment (albeit a lot of problems,) and the third enables starting the Chromium binary without a terminal.

## There's a "chromeos" directory in my home folder... why is that?

This is where the Chromium binary stores data, such as Downloads. You can safely delete it if you've uninstalled this project.

## How do I update the Chromium binary?

Just install a new version of the package.

## What is working properly?
 
* Hardware acceleration... I guess that's it.

## What features aren't working properly?

* Setting up the lock screen (Anybody can log in with a random password or PIN when you use the lock function; use "continue where you left off" and close the browser instead!)
* Accessing other disks (missing dbus service, mtp deamon)
* Controlling sound volume, networks, and various other system-related stuff (again, missing dbus services, and fake data)
* Using the shutdown button or restarting from the Chromium OS GUI (It behaves just like the Sign Out button)
* Using chrome://flags (It'll appear as working when you select flags to enable, but it wont. The only way to use flags is to modify the chromeos script for now.)
* Automatic Updates (Checking and updating feels smooth, but once you log out, it's still on the same Chromium version. Install a new version of this package on modify the postinst script to get another version.)
* Dictation & Select to speak
* Adobe Flash (But it shouldn't matter, as websites are moving away from it)
* Widevine... No protected content for now.
* Android apps (Missing ARC container)
* Crostini (I'm considering whether or not to make a replacement. I'm considering about forking the crouton project https://github.com/dnschneid/crouton and using the xiwi target to provide traditional GNU/Linux applications inside Chromium.)
* Crosh (but you can still have a shell via openSSH; see the "Get a shell with openSSH" section below for more details)

### Get a shell with openSSH 

First, install openSSH if it wasn't installed.
Next, download the Secure Shell App in the Chromium OS GUI here: https://chrome.google.com/webstore/detail/secure-shell-app/pnhechapfaindjhompbnflcldabbghjo?hl=en
Then, open it and login with your username, your computer's hostname, and your user account's password. Afterwards, you're good to go!

### Odd behavior

* If you resize the Chromium OS GUI window, the wallpaper will run amok. Applying a new wallpaper can help fix this.
* Oddly enough, there were three more download folders in the default download folder, at least in my own virtual machine.

## Deprecated stuff

* Booting directly to Chromium OS (The grub and init files are seven years old, and unmaintained. I'll try reworking this.)
* The chromeos-dm and chromeos-plain scripts
* Plugins like Adobe Flash, Icedtea, Google Talk. These pieces of software are outdated by now.

## Compatability with the host GNU/Linux system

The plan is to port most functionality from ChromeOS (picture import, volume control etc.) However, in order to do this, someone needs to write d-bus services (this is how the binary communicates with system). As I don't know a thing about d-bus, and trying to learn how to write said services, I'm leaving the example files alone.However, the prebuilt binaries have stubbed data (fake Wi-Fi networks, fake Bluetooth devices, fake sound outputs and inputs, and so on,) so I (probably) need to get the binaries from a Chromium OS build: https://arnoldthebat.co.uk/wordpress/chromium-os/

I've tried running the binaries from ArnoldTheBat's "Camd64OS_R74-11895.B-Vanilla" build, but these cause a segmentation fault, even with all the requested library files. I suspect it's because of various missing files.
The binary didn't want to give me a log, so I'm left with a binary with stubbed data for now.

## How do I change what Chromium binary is being downloaded during installation?

1. Clone this repository
2. Change directory into this project, and then into ./debian
3. Open the "postinst" file and look for a variable named "BASE". Next to it is a number; change it to the base position that you want.
4. Save it, change directory to "..", and then follow the build instructions below, jumping to part 3.

## How do I build this package myself?
Before you begin, you must have a GNU/Linux distribution with dpkg such as Debian, Ubuntu, Elementary OS, etc.

1. Clone this repository
2. Change directory into this project
3. Run this without quotes: "dpkg-buildpackage -F -us -uc"
Note that building the package will result in some warnings (and some errors if you omit some of the modifiers,) but they usually can be ignored.
Also, you will not only generate the .deb package, but you will also build tar archives and other stuff. Those can be safely removed.

## A list of GNU/Linux distributions that were tested
All distributions listed here are in amd64 variations.

* Ubuntu MATE 19.04
(There's more on the way, I promise.)
 
## Why does the project only support the amd64/x86_64 architecture?

Google doesn't build 32-bit binaries. Poor x86.

## Credits

I would like to thank dz0zy for the original project (https://github.com/dz0ny/lightdm-login-chromeos,) and I would like to thank frobthebuilder for forking and ironing out some errors. (https://github.com/FrobtheBuilder/lightdm-login-chromeos)

My thanks also go to JVApen for helping me to run the actual Chromium binaries, and figure out for myself why the project wouldn't work. (http://chromiumosonlinux.blogspot.com/2015/12/getting-started-with-chromium-os.html)

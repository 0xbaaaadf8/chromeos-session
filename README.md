# chromeos-session

## This project isn't abandoned (yet,) but it's still not done.

## Please read this file carefully before using this! Many features are not present or are not working properly. Do not use the lock function, as anybody can type in something random to get in. Additionally, do not store any sensitive data on the Chromium OS environment.

In layman's terms, this is [lightdm-login-chromeos](https://github.com/dz0ny/lightdm-login-chromeos) updated.

As I'm clueless when in comes to the internals of Chromium OS, I consider this to be pre-release until I gain more experience with it.

Additionally, this fork no longer downloads the lastest Chromium builds; It downloads a build that is stable (or a beta build that is fairly close to stable.) This change was made because the latest versions might bring some changes which prevent the build from running properly. I'll revert my decision when this becomes a problem.

## What does this package do, exactly?

This project will install the GUI of Chromium OS on "traditional" GNU/Linux sytems, allowing you to get a basic and (very) rough experience of what Chromium OS (and Chrome OS) feels like (with a lot of missing features.) I'm saying "traditional" because Chromium OS is quite different than most GNU/Linux distributions (Ubuntu, Debian, PureOS, Fedora, openSUSE, etc.)

## What does this package install?

When you install this pacakge, a script is run that downloads the last known good revision of the Chromium browser as a zip archive. However, it has a special twist; It's a build of Chromium for Chromium OS, which means it contains the GUI you'll see on Chromebooks (and the like.) Once the package has been downloaded, it is extracted into /opt/chromeos. This is where the Chrome browser resides on a Chromebook (and again, the like.) As of writing, three more files are extracted: A script extracted to /usr/bin, an xsesison (desktop environment) file extracted to /usr/share/xsessions, and a application file extracted to /usr/share/applications. The first is what gets the Chromium binary properly started for use, and it can be executed by a user via a terminal. The second allows the Chromium binary to function as a desktop environment (albeit with a lot of problems,) and the third enables starting the Chromium binary from common desktop environments.

## There's a "chromeos" directory in my home folder... why is that?

This is where the Chromium binary stores data, such as Downloads. You can safely delete it if you've uninstalled this project.

## How do I update the Chromium binary?

Just reconfigure or reinstall the package.

## What is working properly?
 
* Hardware acceleration... I guess that's it.

## What features aren't working properly?

* Setting up the lock screen (Anybody can log in with a random password or PIN when you use the lock function; don't be tempted to use it when you're using Chromium OS as a desktop environment!)
* Accessing other disks (A problem with the build downloaded)
* Controlling sound volume, networks, and various other system-related stuff (again, this has to do with the build downloaded)
* Using the shutdown button or restarting from the Chromium OS GUI (It behaves just like the Sign Out button on real Chrome OS devices)
* Using chrome://flags (It'll appear as working when you select flags to enable, but it wont. The only way to use flags is to modify the chromeos script for now.)
* Automatic Updates (Checking and updating feels smooth, but once you log out, it's still on the same Chromium version. Install or reconfigure this package to get another version.)
* Dictation & Select to speak
* Adobe Flash (But it shouldn't matter, as Adobe has killed it)
* Widevine... No protected content for now.
* Android apps (Missing ARC container)
* Crostini (This is not a high priority, as you probably are able to do what Crostini offers already)
* Crosh (You can still have a shell via OpenSSH; see the "Get a shell with OpenSSH" section below for more details)

### Get a shell with OpenSSH 

First, install OpenSSH if it wasn't installed.
Next, download the Secure Shell App in the Chromium OS GUI here: https://chrome.google.com/webstore/detail/secure-shell-app/pnhechapfaindjhompbnflcldabbghjo?hl=en
Then, open it and login with your username, your computer's hostname, and your user account's password. Afterwards, you're good to go!

### Odd behavior

* If you resize the Chromium OS GUI window, the wallpaper will run amok. Applying a new wallpaper can help fix this.
* Oddly enough, there were three more download folders in the default download folder, at least in my own virtual machine.

## Deprecated stuff

* Booting directly to Chromium OS (The grub and init files are seven years old, and unmaintained.)
* The chromeos-dm and chromeos-plain scripts
* Plugins like Adobe Flash, Icedtea, Google Talk (They are all dead)

## Compatability with the host GNU/Linux system

The plan *was* to enable adjusting system settings and fixing many bugs. However, the prebuilt binaries have stubbed data (fake Wi-Fi networks, fake Bluetooth devices, fake sound outputs and inputs, and so on,) so I (probably) need to get the binaries from a Chromium OS build, [such as builds from ArnoldThebat.](https://arnoldthebat.co.uk/wordpress/chromium-os/)

I've tried running the binaries from ArnoldTheBat's "Camd64OS_R74-11895.B-Vanilla" build, but these cause a segmentation fault, even with all the requested library files. I suspect it's because of various missing files.
The binary didn't want to give me a log, so I'm left with a binary with stubbed data for now.

## How do I change what Chromium binary is being downloaded during installation?

1. Clone this repository
2. Change directory into this project, and then into ./debian
3. Open the "postinst" file and look for a variable named "LKGR". Change it to a revision you'd like (and be careful as older revisions might not work.)
4. Save it, change directory to "..", and then follow the build instructions below, jumping to part 3.

## How do I build this package myself?
Before you begin, you must have a GNU/Linux distribution with dpkg such as Debian, Ubuntu, Elementary OS, etc.

1. Clone this repository
2. Change directory into this project
3. Run this without quotes: "dpkg-buildpackage -F -us -uc"
Note that building the package will result in some warnings (and some errors if you omit some of the modifiers,) but they usually can be ignored.
Also, you will not only generate the .deb package, but you will also build tar archives and other stuff. Those can be safely removed.

## Why does the project only support the amd64/x86_64 architecture?

Google doesn't build 32-bit binaries.

## Credits

I would like to thank dz0zy for the original project (https://github.com/dz0ny/lightdm-login-chromeos,) and I would like to thank frobthebuilder for forking and ironing out some errors. (https://github.com/FrobtheBuilder/lightdm-login-chromeos)

My thanks also go to JVApen for helping me to run the actual Chromium binaries, and figure out for myself why the project wouldn't work. (http://chromiumosonlinux.blogspot.com/2015/12/getting-started-with-chromium-os.html)

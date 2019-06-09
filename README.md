# chromeos-desktop

Basically, this is lightdm-login-chromeos... reborn.

This project is a fork of a fork of the now-archived lightdm-login-chromeos project: [https://github.com/FrobtheBuilder/lightdm-login-chromeos]

I consider this project to be pre-release until I can get (almost) all of the features working.

Additionally, this fork no longer downloads the lastest chromium builds; It downloads a stable-ish (probably beta) build.

## Warning - DO NOT use the lock function in the Chromium OS GUI! Anybody can sign in, even if they don't know the password of PIN that you set! See the "What doesn't work" section of this README for more details.

## What is working properly?
 
* Hardware acceleration... I guess that's it.

## What features aren't working properly?

* Setting up the lock screen (Anybody can log in with a random password or PIN when you use the lock function; use "continue where you left off" and sign out instead!)
* Accessing other disks (missing dbus service, mtp deamon)
* Controlling sound volume, networks, and various other system-related stuff (again, missing dbus services, and fake data)
* Booting directly to the Chromium OS GUI (outdated files)
* Using the shutdown button or restarting from the Chromium OS GUI (It behaves just like the Sign Out button)
* Using flags (it will appear enabled, but it won't acutally do a thing
* Automatic Updates (Checking and updating feels smooth, but once you log out, it's still on the same Chromium version)
* Dictation & Select to speak
* Adobe Flash (But it's kicking the bucket in 2020, so...)
* Widevine... No protected content for now.
* Android apps (Missing container files)
* Crostini (I'm considering whether or not to make a replacement; see the "A crostini replacement?" section below for more details)
* Crosh (but you can still have a shell via openSSH; see the "Get a shell with openSSH" section below for more details)

### Odd behavior

* If you resize the Chromium OS GUI window, the wallpaper will run amok. Applying a new wallpaper can help fix this.
* Oddly enough, there were three more download folders in the default download folder, at least in my own virtual machine.

### A Crostini replacement?

I'm considering about forking the crouton project [https://github.com/dnschneid/crouton] and using the xiwi target to bring traditional GNU/Linux programs to the Chromium OS GUI.
 
### Get a shell with openSSH 

Download the Secure Shell App in the Chromium OS GUI here: [https://chrome.google.com/webstore/detail/secure-shell-app/pnhechapfaindjhompbnflcldabbghjo?hl=en]
Then, open it and login with your username, your computer's hostname, and your user account's password. Afterwards, you're good to go!

## Deprecated stuff (for now)

* Booting directly to Chromium OS (The grub and init files are seven years old, and unmaintained)
* The chromeos-dm and chromeos-plain scripts
* Plugins (Adobe Flash, Icedtea, Google Talk)

## Compatability with traditional GNU/Linux systems

The plan is to port most functionality from ChromeOS (picture import, volume control etc.) However, in order to do this, someone needs to write d-bus services (this is how the binary communicates with system). As I don't know a thing about d-bus, and trying to learn how to write said services, I'm leaving the example files alone.
However, I believe the prebuilt binaries have stubbed data (fake Wi-Fi networks, fake Bluetooth devices, fake sound outputs and inputs, and so on,) so I might need to get the binaries from a Chromium OS build: [https://arnoldthebat.co.uk/wordpress/chromium-os/]

I've tried running the binaries from ArnoldTheBat's "Camd64OS_R74-11895.B-Vanilla" build, but these cause a segmentation fault, even with all the requested library files. I suspect it's because of various missing files (like not copying /usr/share/chromeos-assets.)
The binary didn't want to give me a log, so I'm left with a binary with stubbed data for now.

## How do I change what Chromium binary is being downloaded during installation?

1. Clone this repository
2. Change directory into this project, and then into ./debian
3. Open the "postinst" file and look for a variable named "BASE". Next to it is a number; change it to the base position that you want.
4. Save it, change directory to "..", and then follow the build instructions below, jumping to part 3.

## How do I build this package myself?
You must have a GNU/Linux distribution with dpkg (Debian, Ubuntu, Elementary OS, etc.)

1. Clone this repository
2. Change directory into this project
3. Run this without quotes: "dpkg-buildpackage -F -us -uc"
Note that building the package will result in some warnings (and some errors if you omit some of the modifiers,) but they usually can be ignored.
Also, you will not only generate the .deb package, but you will also build tar archives and other stuff. Those can be safely removed.

## A list of GNU/Linux distributions that were tested
All distributions listed here are in amd64 variations.

* Ubuntu MATE 19.04
 
## Why does the project only support the amd64 architecture?

Google doesn't build 32-bit binaries.

## There's a "chromeos" directory in my home folder... why is that?

This is where the Chromium binary stores data, such as Downloads. You can safely delete it if you've uninstalled this project.

## Credits

I would like to thank dz0zy for the original project ([https://github.com/dz0ny/lightdm-login-chromeos],) and I would like to thank frobthebuilder for forking and ironing out some errors. ([https://github.com/FrobtheBuilder/lightdm-login-chromeos])

My thanks also go to JVApen for helping me to run the actual Chromium binaries, and figure out for myself why the project wouldn't work. ([http://chromiumosonlinux.blogspot.com/2015/12/getting-started-with-chromium-os.html])

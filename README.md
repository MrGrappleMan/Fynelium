
Best works with [Ventoy](https://www.ventoy.net/en/download.html) on regular ARM64 Laptops.

For [ARM64 Laptops](https://fedoraproject.org/atomic-desktops/silverblue/download/) & [Any M2 Macbook with Asahi installed](https://alx.sh):

```sudo curl https://raw.githubusercontent.com/MrGrappleMan/Fynelium/main/start.bash | sudo bash```

## Steps for ARM64 Laptops:
### 1. Disable secure boot
Enter your UEFI setup screen. You may want to know how to do so by searching about your laptop's model from external sources.
### 2. Downloading the OS
[Here](https://openqa.fedoraproject.org/nightlies.html), download the file that matches with the criteria of being in the section of Fedora Rawhide, Kinoite dvd-ostree, ARM64. It is not necessary for you to download from last known good unless the main option is highlighted in red.
### 3. Making the installation medium
[Here](https://sourceforge.net/projects/ventoy/files/), go to the latest version and download the file for Linux, ending in linux.tar.gz

Extract the file

Run VentoyGUI.aarch64

Enter your password

Show all devices

Disable secure boot support

Ensure you have a spare USB drive plugged in and yoy have cloned its contents, if any

Install

Go past the confirmation prompt

Move the downloaded OS file onto the partitiin simply named as Ventoy


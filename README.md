
Best works with [Ventoy](https://www.ventoy.net/en/download.html) on regular ARM64 Laptops.

For [ARM64 Laptops](https://fedoraproject.org/atomic-desktops/silverblue/download/) & [Any M2 Macbook with Asahi installed](https://alx.sh):
##
## Steps for ARM64 Laptops:
CAUTION: You will NOT be able to multi boot, but I have not tested it extensively.
### 1. Disable secure boot
Enter your UEFI setup screen. You may want to know how to do so by searching about your laptop's model from external sources.

### 2. Downloading the OS
[Here](https://openqa.fedoraproject.org/nightlies.html), download the file that matches with the criteria of being in the section of Fedora Rawhide, Kinoite dvd-ostree, ARM64. It is not necessary for you to download from last known good unless the last built option is highlighted in red.

### 3. Making the installation medium
[Here](https://sourceforge.net/projects/ventoy/files/), go to the latest version and download the file for your host or currenly running OS.

Extract the file

Run the binary or executable file suited for ARM64.

A sudo or admin prompt may be asked, so input your password or accept the UAC prompt. 

Show all devices.

Disable secure boot support.

Ensure you have a spare USB drive plugged in and yoy have cloned its contents, if any.

Install

Go through the confirmation prompts.

Move the downloaded OS file onto the partition simply named as Ventoy.

### 4. Starting the installation

Select the alternate boot device where you have moved the file. The manufacturer provides information on this as well.

Go through the generic steps

Your username should be "a", use any password that you want to.

Automatic partitioning, free up space with delete all and encrypt your drive with the same password as your username.

Connect to the internet and make your connection unmetered.

Begin installation.

Do NOT turn off your device amidst the installation.

After the installation is complete, reboot and make sure to boot to Silverblue and not your installation medium.

### 5. Setting up Fynelium

Run this script in a terminal

```sudo curl https://raw.githubusercontent.com/MrGrappleMan/Fynelium/main/start.bash | sudo bash```

Enter the password that you had set up.

Do NOT close the terminal.
##
## Steps for M2/1 Macbooks

### 1. Get your data backed up

### 2. Install Asahi Linux

Simply run

```curl https://alx.sh | sh```

and follow subsequent steps.
Resize the MacOS partition as min and Linux as max.

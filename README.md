##
## Steps:
### 1. Disable secure boot
Enter your UEFI setup screen. You may want to know how to do so by searching about your device's model from external sources.

### 2. Downloading the base OS

[Bazzite](https://bazzite.gg)
Only use the GNOME version

### 3. Making the installation medium
[Here](https://etcher.io), go to the latest version and download the file for your host or currenly running OS.

Run the binary

A sudo or admin prompt may be asked, so input your password or accept the UAC prompt. 

Pick the image

Pick the device

Ensure you have a USB drive plugged in. It will be wiped.

Flash!

### 4. Starting the installation

Select the alternate boot device where you have moved the file. The manufacturer provides information on this as well.

Go through the generic steps.

Automatic partitioning, free up space with delete all. Encryption is optional for servers.

Begin installation.

Do NOT turn off your device amidst the installation.

After the installation is complete, reboot and make sure to boot to Silverblue and not your installation medium.

### 5. Setting up Fynelium

Connect to the internet

Run this script in a terminal

```sudo curl https://raw.githubusercontent.com/MrGrappleMan/Fynelium/main/start.bash | sudo bash```

Enter the password that you had set up for the user you are on.

Your device should reboot automatically once the procedure is done. Do not use your device or even close the terminal as it will interfere with the installation process. Ensure internet connection is stable.

After the reboot you may use the device normally.

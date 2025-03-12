##
## Steps:
CAUTION: You will NOT be able to multi boot, but I have not tested it extensively.
### 1. Disable secure boot
Enter your UEFI setup screen. You may want to know how to do so by searching about your laptop's model from external sources.

### 2. Downloading the OS
[x86_64/x64/amd64/intel64](https://kojipkgs.fedoraproject.org/compose/rawhide/Fedora-Rawhide-20250312.n.0/compose/Silverblue/x86_64/iso/Fedora-Silverblue-ostree-x86_64-Rawhide-20250312.n.0.iso)

[aarch64/arm64](https://kojipkgs.fedoraproject.org/compose/rawhide/Fedora-Rawhide-20250312.n.0/compose/Silverblue/aarch64/iso/Fedora-Silverblue-ostree-aarch64-Rawhide-20250312.n.0.iso)

[Base site](https://bit.ly/FdrNightly)

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

Go through the generic steps.

Automatic partitioning, free up space with delete all. Encryption is optional for servers.

Begin installation.

Do NOT turn off your device amidst the installation.

After the installation is complete, reboot and make sure to boot to Silverblue and not your installation medium.

### 5. Setting up Fynelium

Connect to the internet

Run this script in a terminal

```sudo curl https://raw.githubusercontent.com/MrGrappleMan/Fynelium/main/start.bash | sudo bash >/dev/null```

Enter the password that you had set up for the user you are on.

You may close the terminal. 

Your device should restart automatically, so ensure that you don't do any important work. Don't interfere with package management till reboot

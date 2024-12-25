#!/bin/bash

# Homebrew for both:
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bash_profile
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Recognize:
uname=$(uname);
case "$uname" in
    (*Linux*) scriptFile='LX.bash'; ;;
    (*Darwin*) scriptFile='DW.bash'; ;;
    (*) echo 'error: unsupported platform.'; exit 2; ;;
esac;

# Git install:
homebrew install git
rpm-ostree install git
rpm-ostree apply-live --allow-replacement

# Cloning:
cd ~
rm -rf /tmp/Fynelium
git clone https://github.com/MrGrappleMan/Fynelium.git /tmp/Fynelium
chmod -R 755 /tmp/Fynelium
cd /tmp/Fynelium

/bin/bash "$scriptFile"
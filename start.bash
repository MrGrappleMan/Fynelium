#!/bin/bash

install_homebrew() {
    if ! command -v brew &>/dev/null; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        if [[ "$(uname)" == "Linux" ]]; then
            echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bash_profile
            eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
        elif [[ "$(uname)" == "Darwin" ]]; then
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.bash_profile
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
    fi
}

# Recognize:
uname=$(uname);
case "$uname" in
    (*Linux*) scriptFile='LX.bash'; ;;
    (*Darwin*) scriptFile='DW.bash'; ;;
    (*) echo 'error: unsupported platform.'; exit 2; ;;
esac;

# Git install:
install_git() {
    if ! command -v git &>/dev/null; then
        if command -v rpm-ostree &>/dev/null; then
            rpm-ostree install git
            rpm-ostree apply-live --allow-replacement
        else
            brew install git
        fi
    fi
}

# Cloning:
cd ~
rm -rf /tmp/Fynelium
git clone https://github.com/MrGrappleMan/Fynelium.git /tmp/Fynelium
chmod -R 755 /tmp/Fynelium
cd /tmp/Fynelium

/bin/bash "$scriptFile"
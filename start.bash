#!/bin/bash

# Recognize:
uname=$(uname);
case "$uname" in
    (*Linux*) /bin/bash LX.bash; ;;
    (*Darwin*) /bin/bash DW.bash; ;;
    (*) echo 'error: unsupported platform.'; exit 2; ;;
esac;

# Homebrew
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

# Git:
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
clone_repository() {
    cd ~ || exit 1
    rm -rf /tmp/Fynelium
    git clone https://github.com/MrGrappleMan/Fynelium.git /tmp/Fynelium || { echo "Error: Failed to clone repository."; exit 1; }
    chmod -R 755 /tmp/Fynelium
    cd /tmp/Fynelium || exit 1
}

# Procedure:
install_homebrew
install_git
clone_repository
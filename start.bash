#!/bin/bash

# Platform Recognition:
uname=$(uname)
case "$uname" in
    Linux) scriptFile='LX.bash' ;;
    Darwin) scriptFile='DW.bash' ;;
    *) echo "($uname) unsupported"; exit 2 ;;
esac

# Homebrew Installation:
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Git Installation:
rpm-ostree install git
rpm-ostree apply-live --allow-replacement

# Clone Repository:
    cd ~ || exit 1
    rm -rf /tmp/Fynelium
    git clone https://github.com/MrGrappleMan/Fynelium.git /tmp/Fynelium || {
        echo "Error: Failed to clone repository."
        exit 1
    }
    chmod -R 755 /tmp/Fynelium
    cd /tmp/Fynelium
}

/bin/bash $scriptFile
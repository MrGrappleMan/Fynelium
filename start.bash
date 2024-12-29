#!/bin/bash

# Script Recognition:
uname=$(uname)
case "$uname" in
    Linux) scriptFile='LX.bash' ;;
    Darwin) scriptFile='DW.bash' ;;
    *) echo "($uname) unsupported"; exit 2 ;;
esac

# Homebrew Installation:
case "$uname" in
    Darwin) /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" ;;
esac

# Git Installation:
case "$uname" in
    Linux) rpm-ostree install git; rpm-ostree apply-live --allow-replacement ;;
    Darwin) brew install git ;;
esac

# Clone Repository:
rm -rf /tmp/Fynelium
git clone https://github.com/MrGrappleMan/Fynelium.git /tmp/Fynelium
chmod -R 755 /tmp/Fynelium
cd /tmp/Fynelium

/bin/bash $scriptFile
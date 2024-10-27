#!/bin/bash
# Cloning:
rm -rf /tmp/Fynelium
git clone https://github.com/MrGrappleMan/Fynelium.git /tmp/Fynelium
chmod -R 755 /tmp/Fynelium
cd /tmp/Fynelium

# Prepare for main script:
rpm-ostree cancel -q
rpm-ostree reload -q
rpm-ostree install fish
rpm-ostree apply-live --allow-replacement
sudo /bin/fish -c "./main.fish">/dev/null

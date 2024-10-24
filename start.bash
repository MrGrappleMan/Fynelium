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
curl -s https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish -c "source; exit"
sudo /bin/fish -c "./main.fish"

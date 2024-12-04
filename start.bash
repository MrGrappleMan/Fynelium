#!/bin/bash
# Cloning:
rm -rf /tmp/Fynelium
git clone https://github.com/MrGrappleMan/Fynelium.git /tmp/Fynelium
chmod -R 755 /tmp/Fynelium
cd /tmp/Fynelium
alias rqe="rpm-ostree -q --peer"

# Prepare for main script:
rqe cancel
rqe reload
rqe install fish
rqe apply-live --allow-replacement
sudo /bin/fish -c "./main.fish">/dev/null

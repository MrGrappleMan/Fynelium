#!/usr/bin/fish

sudo rm -rf /tmp/Fynelium
sudo git clone sudo https://github.com/MrGrappleMan/Fynelium.git /tmp/Fynelium
sudo chmod -R 777 /tmp/Fynelium/
sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target shutdown.target reboot.target poweroff.target halt.target
sudo fish /tmp/Fynelium/main.fish
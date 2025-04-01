1. Install Bazzite. Pick the KDE version. Choose the correct support of your PC
2. Run this in Konsole:

sudo bash

3. Run this all together:

systemctl stop rpm-ostreed rpm-ostreed-automatic rpm-ostreed-automatic.timer
rpm-ostree cancel -q --peer
rpm-ostree reload -q --peer
rpm-ostree install --peer --allow-inactive --idempotent -y fish

4. Reboot
5. Run this all together in Konsole:

sudo git clone https://github.com/MrGrappleMan/Fynelium.git /
sudo systemctl enable refyne.timer

You may use your system normally now. Tweaks will be applied daily.

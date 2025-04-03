1. Install Bazzite. Pick the KDE version. Choose the correct support of your PC
2. Run this in Konsole:

sudo bash

3. Run this all together:

systemctl stop rpm-ostreed rpm-ostreed-automatic rpm-ostreed-automatic.timer
rpm-ostree cancel -q --peer
rpm-ostree reload -q --peer
rpm-ostree install --peer --allow-inactive --idempotent -y fish

4. Reboot
5. Run this in Konsole

sudo fish

6. Run this all together in Konsole:

rm -rf /tmp/Fynelium
mkdir /tmp/Fynelium
git clone https://github.com/MrGrappleMan/Fynelium.git /tmp/Fynelium/
cp -r /tmp/Fynelium/* /
systemctl daemon-reload
systemctl enable --now refyne.timer
systemctl start refyne

You may use your system normally now. Tweaks will be applied automatically.

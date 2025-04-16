1. Install Bazzite GNOME. Choose the correct parameters for your setup.
2. Run this in a terminal:

sudo fish

3. Run this all together:

rpm-ostree cancel -q --peer
rpm-ostree reload -q --peer
rm -rf /tmp/Fynelium
mkdir /tmp/Fynelium
git clone https://github.com/MrGrappleMan/Fynelium.git /tmp/Fynelium/
cp -r /tmp/Fynelium/etc/. /etc/
cp -r /tmp/Fynelium/var/. /var/
cp -r /tmp/Fynelium/root/. /root/
systemctl daemon-reload
systemctl enable --now weekly-fyne.timer hourly-fyne.timer

You may use your system normally now. Tweaks will be applied automatically.

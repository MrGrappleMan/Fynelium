1. Install Bazzite GNOME. Choose the correct parameters for your setup while downloading from the website.
2. Run this in a terminal:

sudo fish

3. Run this all together:

if test (id -u) -ne 0
echo "Not root user"
exit 1
end
if not ping -c 1 -W 2 1.1.1.1 > /dev/null
echo "No internet"
exit 1
end
rpm-ostree cancel -q --peer
rpm-ostree reload -q --peer
rm -rf /tmp/Fynelium
mkdir /tmp/Fynelium
git clone https://github.com/MrGrappleMan/Fynelium.git /tmp/Fynelium/
cp -r /tmp/Fynelium/etc/* /etc/
cp -r /tmp/Fynelium/var/* /var/
systemctl daemon-reload
systemctl enable weekly-fyne.timer hourly-fyne.timer
systemctl reboot

Once rebooted, you may use your system normally. Explore it. My rice attempts to add some utilites that are useful, as well as a backup desktop environment. With improved system configuration and automated updates, you may have a better experience using Linux :)

1. Install Bazzite GNOME. Choose the correct parameters for your setup while downloading from the website.
2. Run this in a terminal:

sudo fish

3. Run this:

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
sudo curl https://raw.githubusercontent.com/MrGrappleMan/Fynelium/refs/heads/main/etc/redneck-bin/hourly-fyne.fish | sudo fish
systemctl enable weekly-fyne.timer hourly-fyne.timer
systemctl reboot

Once rebooted, you may use your system normally. Explore it. My rice attempts to add some utilites that are useful, as well as a backup desktop environment. With improved system configuration and automated updates, you may have a better experience using Linux :)
Do not dual boot, as KVM and other similar utilities allow you to have 0.9998:1 performance, or performance similar to native execution.
I have added BOINC, which automatically uses your idle computing time and for benefitting science. This will not slow down your system, as tasks run in the background with the lowest priority, parallel to even when you are using your computer.
I expect that you have read this paragraph carefully and I claim no responsibilty to any damage done to your system, but I can try helping!

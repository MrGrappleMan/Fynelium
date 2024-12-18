#!/bin/bash
# Execution verity:
sudo journalctl --user --flush --rotate --vacuum-time=1s
sudo systemd-cat -p emerg echo "--English text for other vernacular language users-- Do not panic. No unexpected event has occured. This is just to bring to your attention that the script is working. Do not turn off your device. You may continue using it normally till another message like this appears. Avoid package installation and system component modification. Press any key to exit this."
sudo /usr/lib/systemd/systemd-bsod -c

# Cloning:
cd ~
rm -rf /tmp/Fynelium
git clone https://github.com/MrGrappleMan/Fynelium.git /tmp/Fynelium
chmod -R 755 /tmp/Fynelium
cd /tmp/Fynelium

# Prepare for main script:
systemctl stop rpm-ostreed-automatic rpm-ostreed-automatic.timer
rpm-ostree -q --peer cancel
rpm-ostree -q --peer reload
rpm-ostree -q --peer upgrade # Fix dependancies left broken by goofy maintainance quality.
rpm-ostree -q --peer --allow-inactive --idempotent install fish # This is arguably better. To those who cannot adjust to this  modern script, grow up...
rpm-ostree apply-live --allow-replacement
fish -c "./main.fish" >/dev/null 2>/tmp/Fynelium/errors.log

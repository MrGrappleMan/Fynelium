#!/bin/fish

function rqe
	rpm-ostree -q --peer $argv
end
function listedexec
    set -l contents $argv[1]
    set -l command_template $argv[2]

    for item in (echo "$contents" | string split "\n")
        set -l command (string replace '$crntval' "$item" "$command_template")
        eval "$command"
    end
end

chmod -R 755 /etc/
cp -r LXroot/etc/* /etc/
systemctl daemon-reload
systemctl enable --now systemd-resolved systemd-networkd
systemctl disable --now rpm-ostreed-automatic rpm-ostreed-automatic.timer

# RPM-OSTree:-
# Configuration:
rqe cancel
rqe reload
rqe install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-rawhide.noarch.rpm
# Packages:
listedexec "tlp tlp-rdw
cosmic-desktop cosmic-session" "rqe install --allow-inactive --idempotent \$crntval"
listedexec "power-profiles-daemon" "rqe remove --allow-inactive --idempotent \$crntval"

# Flatpak:-
# Configuration:
listedexec "--subset=floss flathub-floss https://dl.flathub.org/repo/flathub.flatpakrepo
flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo
gnome-nightly https://nightly.gnome.org/gnome-nightly.flatpakrepo
fedora oci+https://registry.fedoraproject.org
fedora-testing oci+https://registry.fedoraproject.org/#testing
rhel https://flatpaks.redhat.io/rhel.flatpakrepo
webkit-sdk https://software.igalia.com/flatpak-refs/webkit-sdk.flatpakrepo
eclipse-nightly" "flatpak remote-add --if-not-exists --system \$crntval"
flatpak remote-delete --if-not-exists --system flathub
flatpak update --noninteractive --system
# Packages:
listedexec "flathub com.gopeed.Gopeed
flathub net.nokyan.Resources
flathub io.github.flattool.Warehouse
flathub org.torproject.torbrowser-launcher
flathub com.vscodium.codium-insiders
flathub org.octave.Octave
flathub org.bluej.BlueJ
flathub io.github.zen_browser.zen" "flatpak install --system --noninteractive --or-update \$crntval"

# System:-
# Finalize Ostree pkgs:
listedexec "systemd-rfkill
systemd-rfkill.socket" "systemctl mask \$crntval"
listedexec "tlp
rpm-ostreed-automatic.timer
swappity" "systemctl enable \$crntval"
# Boot:
plymouth-set-default-theme spinner
rqe kargs --append-if-missing="threadirqs \
rhgb \
sysrq_always_enabled=1 \
consoleblank=0 \
quiet \
loglevel=3 \
preempt=full"
rqe initramfs --disable

systemctl poweroff

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
systemctl enable rpm-ostreed-automatic.service rpm-ostreed-automatic.timer
systemctl stop rpm-ostreed-automatic.service rpm-ostreed-automatic.timer

# RPM-OSTree:-
# Configuration:
rqe cancel
rqe reload
if echo $base | grep -q "bazzite"
	set base (echo $base | sed 's/stable/unstable/g; s/testing/unstable/g')
	rqe rebase --experimental "$base"
end
listedexec "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-rawhide.noarch.rpm
https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-rawhide.noarch.rpm" "rqe install \$crntval"
# Packages:
listedexec "tlp
tlp-rdw
tor
cosmic-desktop
cosmic-session
sddm" "rqe install --allow-inactive --idempotent \$crntval"
listedexec "power-profiles-daemon" "rqe install --allow-inactive --idempotent \$crntval"

# Flatpak:-
# Configuration:
listedexec "flathub=https://dl.flathub.org/repo/flathub.flatpakrepo
flathub-beta=https://flathub.org/beta-repo/flathub-beta.flatpakrepo
gnome-nightly=https://nightly.gnome.org/gnome-nightly.flatpakrepo
fedora=oci+https://registry.fedoraproject.org
fedora-testing=oci+https://registry.fedoraproject.org/#testing
rhel=https://flatpaks.redhat.io/rhel.flatpakrepo
webkit-sdk=https://software.igalia.com/flatpak-refs/webkit-sdk.flatpakrepo
eclipse-nightly=https://download.eclipse.org/linuxtools/flatpak-I-builds/eclipse.flatpakrepo
xwaylandvideobridge-nightly=https://cdn.kde.org/flatpak/xwaylandvideobridge-nightly/xwaylandvideobridge-nightly.flatpakrepo" "flatpak remote-add --if-not-exists --system \$crntval"
flatpak update --noninteractive
# Packages:
listedexec "flathub=com.github.d4nj1.tlpui" "flatpak install --noninteractive --or-update \$crntval"

# System:-
# Finalize Ostree pkgs:
listedexec "systemd-rfkill
systemd-rfkill.socket
gdm" "systemctl mask \$crntval"
listedexec "tlp
boinc-client
docker
rpm-ostreed-automatic
rpm-ostreed-automatic.timer
sddm" "systemctl enable \$crntval"
# Boot:
rqe kargs --append-if-missing="threadirqs,sysrq_always_enabled=0,consoleblank=1,quiet,loglevel=3,preempt=full"
rqe initramfs --disable

systemctl poweroff

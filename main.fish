#!/bin/fish

function rqe
    rpm-ostree -q --peer $argv
end

# System:-
chmod -R 755 /etc/
cp -r LXroot/etc/* /etc/
plymouth-set-default-theme spinner
rqe kargs --append-if-missing="rhgb,threadirqs,sysrq_always_enabled=0,consoleblank=0,quiet,loglevel=3,preempt=full"
rqe initramfs --enable
systemctl enable --now systemd-resolved systemd-networkd

# RPM-OSTree:-
# Configuration:
rqe cancel
rqe reload
set base (rqe status | grep '● ' | awk '{print $2}')
if echo $base | grep -q "fedora:fedora"
    rqe rebase --experimental fedora:fedora/rawhide/x86_64/silverblue
end
if echo $base | grep -q "bazzite"
    set base (echo $base | sed 's/stable/unstable/g; s/testing/unstable/g')
    rqe rebase --experimental "$base"
end
rqe install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-rawhide.noarch.rpm \
    https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-rawhide.noarch.rpm

systemctl enable \
    rpm-ostreed-automatic.service \
    rpm-ostreed-automatic.timer

# Packages:
# GUI Applications
rqe install --allow-inactive \
boinc-manager
# Background Daemons
rqe install --allow-inactive \
boinc-client \
tor \
tlp \
tlp-rdw \
fwupd
rqe uninstall \
power-profiles-daemon
# Package based configuration in current session
rqe apply-live --allow-replacement
usermod -aG boinc root
systemctl enable --now \
tlp \
tor \
boinc-client
systemctl mask \
systemd-rfkill.service \
systemd-rfkill.socket

# Flatpak:-
# Repo Management:
set flatpak_repos "flathub=https://dl.flathub.org/repo/flathub.flatpakrepo \
                  flathub-beta=https://flathub.org/beta-repo/flathub-beta.flatpakrepo \
                  gnome-nightly=https://nightly.gnome.org/gnome-nightly.flatpakrepo \
                  fedora=oci+https://registry.fedoraproject.org \
                  fedora-testing=oci+https://registry.fedoraproject.org/#testing \
                  rhel=https://flatpaks.redhat.io/rhel.flatpakrepo \
                  webkit-sdk=https://software.igalia.com/flatpak-refs/webkit-sdk.flatpakrepo \
                  eclipse-nightly=https://download.eclipse.org/linuxtools/flatpak-I-builds/eclipse.flatpakrepo \
                  xwaylandvideobridge-nightly=https://cdn.kde.org/flatpak/xwaylandvideobridge-nightly/xwaylandvideobridge-nightly.flatpakrepo"

for repo in $flatpak_repos
    set name (echo $repo | cut -d '=' -f 1)
    set url (echo $repo | cut -d '=' -f 2)
    flatpak remote-add --if-not-exists --system $name $url
end

flatpak update --assumeyes --noninteractive
# Packages:
flatpak install flathub com.github.d4nj1.tlpui

systemctl poweroff
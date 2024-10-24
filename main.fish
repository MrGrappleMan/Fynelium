#!/bin/fish

# System:-
chmod -R 755 /etc/
cp -r LXroot/etc/* /etc/
plymouth-set-default-theme spinner
rpm-ostree kargs \
--append-if-missing=rhgb \
--append-if-missing=threadirqs \
--append-if-missing=sysrq_always_enabled=0 \
--append-if-missing=consoleblank=0 \
--append-if-missing=quiet \
--append-if-missing=loglevel=3 \
--append-if-missing=preempt=full
rpm-ostree initramfs --enable
systemctl enable --now systemd-resolved systemd-networkd
gnome-software --prefs --autoupdate

# RPM-OSTree:-
# Configuration:
rpm-ostree cancel -q
rpm-ostree reload -q
set base (rpm-ostree status | grep '● ' | awk '{print $2}')
if echo $base | grep -q "fedora:fedora"
rpm-ostree rebase fedora:fedora/rawhide/x86_64/silverblue --experimental
end
if echo $base | grep -q "bazzite"
set base (echo $base | sed 's/stable/unstable/g; s/testing/unstable/g')
rpm-ostree rebase "$base" --experimental
end
rpm-ostree install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-rawhide.noarch.rpm \
https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-rawhide.noarch.rpm
systemctl enable --now \
rpm-ostreed-automatic.service \
rpm-ostreed-automatic.timer \
# Packages:
# GUI Applications
rpm-ostree install \
boinc-manager
# Background Daemons
rpm-ostree install \
boinc-client \
tor
#tlp tlp-rdw
#rpm-ostree uninstall power-profiles-daemon
# Package based configuration in current session
rpm-ostree apply-live --allow-replacement
#systemctl enable --now tlp
#systemctl mask systemd-rfkill.service systemd-rfkill.socket
systemctl enable --now tor boinc-client
usermod -aG boinc root

# Flatpak:-
# Repo Management:
flatpak remote-add --if-not-exists --system flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak remote-add --if-not-exists --system flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo
flatpak remote-add --if-not-exists --system gnome-nightly https://nightly.gnome.org/gnome-nightly.flatpakrepo
flatpak remote-add --if-not-exists --system fedora oci+https://registry.fedoraproject.org
flatpak remote-add --if-not-exists --system fedora-testing oci+https://registry.fedoraproject.org/#testing
flatpak remote-add --if-not-exists --system rhel https://flatpaks.redhat.io/rhel.flatpakrepo
flatpak remote-add --if-not-exists --system webkit-sdk https://software.igalia.com/flatpak-refs/webkit-sdk.flatpakrepo
flatpak remote-add --if-not-exists --system eclipse-nightly https://download.eclipse.org/linuxtools/flatpak-I-builds/eclipse.flatpakrepo
flatpak remote-add --if-not-exists --system xwaylandvideobridge-nightly https://cdn.kde.org/flatpak/xwaylandvideobridge-nightly/xwaylandvideobridge-nightly.flatpakrepo
# Packages:
flatpak install flathub com.github.d4nj1.tlpui

systemctl shutdown now
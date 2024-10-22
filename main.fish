#!/bin/fish

# Files:-
chmod -R 755 /etc/
cp -r LXroot/etc/* /etc/

# RPM-OSTree:-
# Repo Management:
rpm-ostree cancel -q
rpm-ostree reload -q
rpm-ostree upgrade --allow-downgrade -q
rpm-ostree apply-live --allow-replacement
# Packages:
# System Background Services
rpm-ostree install tlp tlp-rdw -A
rpm-ostree install boinc-client -A
rpm-ostree install tor -A
# User Applications
rpm-ostree install boinc-manager


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
flatpak update --noninteractive
# Packages:
#flatpak install https://gitlab.com/projects261/firefox-nightly-flatpak/-/raw/main/firefox-nightly.flatpakref
#flatpak install https://gitlab.com/projects261/thunderbird-nightly-flatpak/-/raw/main/thunderbird-nightly.flatpakref

# System:-
# Kernel Arguments:
plymouth-set-default-theme spinner
rpm-ostree kargs --append-if-missing=rhgb --append-if-missing=threadirqs --append-if-missing=sysrq_always_enabled=0 --append-if-missing=consoleblank=0 --append-if-missing=quiet --append-if-missing=loglevel=3 --append-if-missing=preempt=voluntary
rpm-ostree initramfs --enable
# SystemD Services:
systemctl enable tor
systemctl enable tlp
systemctl enable rpm-ostreed-automatic.service rpm-ostreed-automatic.timer
systemctl mask systemd-rfkill.service systemd-rfkill.socket

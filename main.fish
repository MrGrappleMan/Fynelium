#!/bin/fish

# RPM-OSTree:-
# Repo Management:
rpm-ostree cancel
rpm-ostree reload
set base (rpm-ostree status | grep '● ' | awk '{print $2}')
rpm-ostree rebase "$base" --experimental
rpm-ostree reload
rpm-ostree upgrade --allow-downgrade -q
systemctl enable rpm-ostreed-automatic.service
systemctl enable rpm-ostreed-automatic.timer
rpm-ostree install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-rawhide.noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-rawhide.noarch.rpm
# Packages:
rpm-ostree install intel-media-driver libva-intel-driver libva-nvidia-driver mesa-va-drivers-freeworld mesa-vdpau-drivers-freeworld gstreamer1-plugin-libav gstreamer1-plugins-bad-free-extras gstreamer1-plugins-bad-freeworld gstreamer1-plugins-ugly gstreamer1-vaapi

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
# rpm-ostree kargs --append-if-missing=mitigations=off
rpm-ostree kargs --delete-if-present=rhgb --append-if-missing=sysrq_always_enabled=0 --append-if-missing=consoleblank=0 --append-if-missing=quiet
rpm-ostree initramfs --enable
# Files:
chmod -R 755 /etc/
cp -r LXetc/* /etc/

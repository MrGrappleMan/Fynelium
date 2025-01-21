#!/bin/fish
source /etc/fish/config.fish
fyn-functions

listedexec "flatpak remote-delete --force --system \$crntval"  "flathub
eos-sdk
igalia
dragon-nightly
xwaylandvideobridge-nightly
eos-apps
webkit
flathub-beta
gnome-nightly
webkit-sdk
fedora
fedora-testing
rhel
eclipse-nightly
elementaryos
pureos
kde-runtime-nightly"

listedexec "flatpak remote-add --if-not-exists --system \$crntval" "flathub https://flathub.org/repo/flathub.flatpakrepo
eos-sdk https://ostree.endlessm.com/ostree/eos-sdk
igalia https://software.igalia.com/flatpak-refs/igalia.flatpakrepo
dragon-nightly https://cdn.kde.org/flatpak/dragon-nightly/dragon-nightly.flatpakrepo
xwaylandvideobridge-nightly https://cdn.kde.org/flatpak/xwaylandvideobridge-nightly/xwaylandvideobridge-nightly.flatpakrepo
eos-apps https://ostree.endlessm.com/ostree/eos-apps
webkit https://software.igalia.com/flatpak-refs/webkit-sdk.flatpakrepo
flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo
gnome-nightly https://nightly.gnome.org/gnome-nightly.flatpakrepo
webkit-sdk https://software.igalia.com/flatpak-refs/webkit-sdk.flatpakrepo
fedora oci+https://registry.fedoraproject.org
fedora-testing oci+https://registry.fedoraproject.org/#testing
rhel https://flatpaks.redhat.io/rhel.flatpakrepo
eclipse-nightly https://download.eclipse.org/linuxtools/flatpak-I-builds/eclipse.flatpakrepo
elementaryos https://flatpak.elementary.io/repo.flatpakrepo
pureos https://store.puri.sm/repo/stable/pureos.flatpakrepo
kde-runtime-nightly https://cdn.kde.org/flatpak/kde-runtime-nightly/kde-runtime-nightly.flatpakrepo"

listedexec "flatpak remote-modify --system --subset=floss \$crntval" "flathub
flathub-beta" 

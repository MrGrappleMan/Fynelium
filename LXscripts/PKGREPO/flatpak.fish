#!/bin/fish
source /etc/fish/config.fish

listedexec "flatpak remote-add --if-not-exists --system \$crntval" "flathub https://flathub.org/repo/flathub.flatpakrepo
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

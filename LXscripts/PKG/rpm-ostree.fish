#!/bin/fish
source /etc/fish/config.fish
fyn-functions

# RQE pkg+:
listedexec "rpm-ostree -q --peer install --allow-inactive --idempotent \$crntval
dnf install" "tlp tlp-rdw
cosmic-desktop cosmic-session niri
kernel-modules-extra grubby
dnf dnf-repo
ghostty
rustup rust
golang
distcc
ostree-devel 
zen-browser torbrowser-launcher
boinc-client
topgrade
gnome-software
flatseal flatpak-selinux flatpak-session-helper xdg-desktop-portal flatpak-libs libportal host-spawn
beep"

# RQE pkg-:
listedexec "rpm-ostree -q --peer uninstall --allow-inactive --idempotent \$crntval" "power-profiles-daemon
firefox
xwaylandvideobridge"

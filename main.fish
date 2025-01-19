#!/bin/fish

function rqe
        rpm-ostree -q --peer $argv
end

function listedexec
    set -l command_template $argv[1]
    set -l contents $argv[2]

    for subcommand in (echo "$command_template" | string split "\n")
        for item in (echo "$contents" | string split "\n")
            set -l command (string replace '$crntval' "$item" "$subcommand")
            eval "$command"
        end
    end
end

# System:
rm -rf /etc/yum.repos.d/*
chmod -R 755 /etc/
cp -r LXroot/etc/* /etc/
chmod -R 755 /var/
cp -r LXroot/var/* /var/

# Package management:-
# FPK cfg:

flatpak update --noninteractive --system

# RQE cfg:


# FPK pkg+:
listedexec "flatpak install --system --noninteractive --or-update \$crntval" "flathub com.gopeed.Gopeed
flathub io.github.flattool.Warehouse
flathub com.vscodium.codium-insiders
flathub org.cubocore.CoreStats
flathub org.octave.Octave"

# RQE pkg+:
listedexec "rqe install --allow-inactive --idempotent \$crntval
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
protontricks bottles
topgrade gnome-software flatseal flatpak-selinux flatpak-session-helper xdg-desktop-portal flatpak-libs libportal host-spawn
beep"
# RQE pkg-:
listedexec "rqe uninstall --allow-inactive --idempotent \$crntval" "power-profiles-daemon
firefox
xwaylandvideobridge"

rpm-ostree apply-live --allow-replacement
usermod -aG boinc root

systemctl unmask hybrid-sleep.target shutdown.target reboot.target poweroff.target sleep.target
echo Script executed successfuly

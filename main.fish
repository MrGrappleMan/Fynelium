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

systemctl daemon-reload
systemctl mask systemd-rfkill systemd-rfkill.socket
systemctl enable tlp \
rpm-ostreed-automatic.timer \
boinc-client \
fyn-zram \
fyn-refyne.timer \
systemd-bsod
plymouth-set-default-theme spinner
rqe kargs --append-if-missing="threadirqs \
rhgb \
sysrq_always_enabled=1 \
consoleblank=0 \
quiet \
loglevel=3 \
preempt=full"
rqe initramfs --disable

grubby --args="threadirqs" --update-kernel=ALL
grub2-mkconfig

# Package management:-
# RQE cfg:
rqe rebase fedora:fedora/rawhide/aarch64/silverblue
rqe install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-rawhide.noarch.rpm

# FPK cfg:
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
flathub-beta
gnome-nightly
webkit-sdk
fedora
fedora-testing
rhel
eclipse-nightly
elementaryos
kde-runtime-nightly"
flatpak update --noninteractive --system

# RQE pkg+:
listedexec "rqe install --allow-inactive --idempotent \$crntval" "tlp tlp-rdw
cosmic-desktop cosmic-session
kernel-modules-extra
ghostty
rustup rust
distcc
zen-browser torbrowser-launcher
boinc-client virtualbox
protontricks bottles
topgrade gnome-software flatseal flatpak-selinux flatpak-session-helper xdg-desktop-portal flatpak-libs libportal host-spawn
beep"
# ROT pkg-:
listedexec "rqe uninstall --allow-inactive --idempotent \$crntval" "power-profiles-daemon
firefox
xwaylandvideobridge"

# FPK pkg+:
listedexec "flatpak install --system --noninteractive --or-update \$crntval" "flathub com.gopeed.Gopeed
flathub io.github.flattool.Warehouse
flathub com.vscodium.codium-insiders
flathub org.cubocore.CoreStats
flathub org.octave.Octave"

rpm-ostree apply-live --allow-replacement
usermod -aG boinc root

systemctl unmask hybrid-sleep.target shutdown.target reboot.target poweroff.target sleep.target

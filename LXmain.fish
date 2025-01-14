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

# System:
chmod -R 755 /etc/
cp -r LXroot/etc/* /etc/
chmod -R 755 /var/
cp -r LXroot/var/* /var/

systemctl daemon-reload
listedexec "systemd-rfkill
systemd-rfkill.socket
greetd" "systemctl mask \$crntval"
listedexec "tlp
rpm-ostreed-automatic.timer
boinc-client
fyn-zram
fyn-refyne.timer
systemd-bsod" "systemctl enable \$crntval"
plymouth-set-default-theme spinner
rqe kargs --append-if-missing="threadirqs \
rhgb \
sysrq_always_enabled=1 \
consoleblank=0 \
quiet \
loglevel=3 \
preempt=full"
rqe initramfs --disable
It's better to use grubby for this. It'll do the right thing regardless of Fedora release version, and whether UEFI or BIOS. Whereas there's constant confusion with grub2-mkconfig. The grub.cfg is static now since Fedora 30, with all kernels having drop-in scripts in /boot/loader/entries.

grubby --args="threadirqs" --update-kernel=ALL
grub2-mkconfig

# Package management:-
# RQE cfg:
rqe rebase fedora:fedora/rawhide/aarch64/silverblue
rqe install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-rawhide.noarch.rpm

# FPK cfg:
listedexec "flathub https://flathub.org/repo/flathub.flatpakrepo
flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo
gnome-nightly https://nightly.gnome.org/gnome-nightly.flatpakrepo
webkit-sdk https://software.igalia.com/flatpak-refs/webkit-sdk.flatpakrepo
fedora oci+https://registry.fedoraproject.org
fedora-testing oci+https://registry.fedoraproject.org/#testing
rhel https://flatpaks.redhat.io/rhel.flatpakrepo
eclipse-nightly https://download.eclipse.org/linuxtools/flatpak-I-builds/eclipse.flatpakrepo
elementaryos https://flatpak.elementary.io/repo.flatpakrepo
pureos https://store.puri.sm/repo/stable/pureos.flatpakrepo
kde-runtime-nightly https://cdn.kde.org/flatpak/kde-runtime-nightly/kde-runtime-nightly.flatpakrepo" "flatpak remote-add --if-not-exists --system \$crntval"
listedexec "flathub
flathub-beta
gnome-nightly
webkit-sdk
fedora
fedora-testing
rhel
eclipse-nightly
elementaryos
kde-runtime-nightly" "flatpak remote-modify --system --subset=floss \$crntval"
flatpak update --noninteractive --system

# RQE pkg+:
listedexec "tlp tlp-rdw
cosmic-desktop cosmic-session⁵
kernel-modules-extra
ghostty
rustup rust
distcc
zen-browser torbrowser-launcher
boinc-client virtualbox
protontricks bottles
topgrade gnome-software flatseal flatpak-selinux flatpak-session-helper xdg-desktop-portal flatpak-libs libportal host-spawn
beep" "rqe install --allow-inactive --idempotent \$crntval"
# ROT pkg-:
listedexec "power-profiles-daemon
firefox
xwaylandvideobridge" "rqe uninstall --allow-inactive \$crntval"

# FPK pkg+:
listedexec "flathub com.gopeed.Gopeed
flathub io.github.flattool.Warehouse
flathub com.vscodium.codium-insiders
flathub org.cubocore.CoreStats
flathub org.octave.Octave" "flatpak install --system --noninteractive --or-update \$crntval"

rpm-ostree apply-live --allow-replacement
usermod -aG boinc root

systemctl unmask hybrid-sleep.target shutdown.target reboot.target poweroff.target sleep.target
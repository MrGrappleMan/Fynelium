#!/bin/env fish

#Checks
 if test (id -u) -ne 0
  echo "Not root user"
  exit 1
 end
 if not ping -c 1 -W 2 1.1.1.1 > /dev/null
    echo "No internet"
    exit 1
 end

#RepoClone
 rm -rf /tmp/Fynelium
 mkdir /tmp/Fynelium
 git clone https://github.com/MrGrappleMan/Fynelium.git /tmp/Fynelium/
 if test $status -ne 0
  echo "Repo clone failed"
  exit 1
 end
cp -r /tmp/Fynelium/etc/* /etc/
cp -r /tmp/Fynelium/var/* /var/
##cp -r /tmp/Fynelium/root/* /root/

#RefreshX1
rpm-ostree -q --peer reload
rpm-ostree -q --peer upgrade --allow-downgrade
rpm-ostree apply-live
rpm-ostree apply-live --allow-replacement

#Flatpak
 #Repos
  flatpak remote-add --if-not-exists --system flathub https://flathub.org/repo/flathub.flatpakrepo
  flatpak remote-add --if-not-exists --system flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo
  flatpak remote-add --if-not-exists --system eos-sdk https://ostree.endlessm.com/ostree/eos-sdk
  flatpak remote-add --if-not-exists --system igalia https://software.igalia.com/flatpak-refs/igalia.flatpakrepo
  flatpak remote-add --if-not-exists --system dragon-nightly https://cdn.kde.org/flatpak/dragon-nightly/dragon-nightly.flatpakrepo
  flatpak remote-add --if-not-exists --system xwaylandvideobridge-nightly https://cdn.kde.org/flatpak/xwaylandvideobridge-nightly/xwaylandvideobridge-nightly.flatpakrepo
  flatpak remote-add --if-not-exists --system eos-apps https://ostree.endlessm.com/ostree/eos-apps
  flatpak remote-add --if-not-exists --system webkit https://software.igalia.com/flatpak-refs/webkit-sdk.flatpakrepo
  flatpak remote-add --if-not-exists --system flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo
  flatpak remote-add --if-not-exists --system gnome-nightly https://nightly.gnome.org/gnome-nightly.flatpakrepo
  flatpak remote-add --if-not-exists --system webkit-sdk https://software.igalia.com/flatpak-refs/webkit-sdk.flatpakrepo
  flatpak remote-add --if-not-exists --system fedora oci+https://registry.fedoraproject.org
  flatpak remote-add --if-not-exists --system fedora-testing oci+https://registry.fedoraproject.org/#testing
  flatpak remote-add --if-not-exists --system rhel https://flatpaks.redhat.io/rhel.flatpakrepo
  flatpak remote-add --if-not-exists --system eclipse-nightly https://download.eclipse.org/linuxtools/flatpak-I-builds/eclipse.flatpakrepo
  flatpak remote-add --if-not-exists --system elementaryos https://flatpak.elementary.io/repo.flatpakrepo
  flatpak remote-add --if-not-exists --system pureos https://store.puri.sm/repo/stable/pureos.flatpakrepo
  flatpak remote-add --if-not-exists --system kde-runtime-nightly https://cdn.kde.org/flatpak/kde-runtime-nightly/kde-runtime-nightly.flatpakrepo
#RefreshX2
systemctl daemon-reload
rpm-ostree -q --peer reload
rpm-ostree -q --peer upgrade --allow-downgrade
rpm-ostree apply-live
rpm-ostree apply-live --allow-replacement
#RPM-OSTree
 #Base
  brh rebase unstable -y
 #Repos
  ##rpm-ostree -q --peer install --allow-inactive --idempotent -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-rawhide.noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-rawhide.noarch.rpm
 #Packages
  #Add
   rpm-ostree -q --peer install --allow-inactive --idempotent -y \
    tlp tlp-rdw \
    openssh openssh-server mosh \
    rust cargo clippy \
    distcc distcc-server distcc-gnome \
    kernel-modules-extra \
    cosmic-epoch cosmic-desktop cosmic-greeter \
    gnome-shell gnome-shell-common gnome-software gnome-software-rpm-ostree gdm \
    boinc-client \
    flatseal flatpak-selinux flatpak-session-helper xdg-desktop-portal flatpak-libs libportal host-spawn \
    podman
#RefreshX2
systemctl daemon-reload
rpm-ostree apply-live
rpm-ostree apply-live --allow-replacement
#Systemd
  systemctl mask \
   systemd-rfkill systemd-rfkill.socket
  systemctl unmask \
   hybrid-sleep.target shutdown.target reboot.target sleep.target poweroff.target suspend.target hibernate.target halt.target
  systemctl enable \
   tlp \
   refyne.timer \
   boinc-client \
   mem-mgr \
   systemd-bsod \
   sshd
  timedatectl set-ntp true --no-ask-password
  timedatectl set-local-rtc true --no-ask-password
#GSettings
for user_path in (ls -d /home/*)
 set username (basename $user_path)
 set user_commands '
  gsettings set org.gnome.desktop.interface clock-show-seconds false;
  gsettings set org.gnome.desktop.interface enable-animations false;
  gsettings set org.gnome.desktop.peripherals.mouse accel-profile 'flat';
  gsettings set org.gnome.software allow-updates false;
  gsettings set org.gnome.desktop.peripherals.mouse speed 1.0;
  gsettings set org.gnome.shell.app-switcher current-workspace-only true;
 '
  runuser -l $username -c "fish -c '$user_commands'"
  echo ""
end

#Kernel
 rpm-ostree -q --peer kargs \
  --append-if-missing=threadirqs \
  --append-if-missing=sysrq_always_enabled=1 \
  --append-if-missing=consoleblank=0 \
  --append-if-missing=quiet \
  --append-if-missing=loglevel=3 \
  --append-if-missing=preempt=full \
  --delete-if-present=rhgb
 rpm-ostree -q --peer initramfs --enable
exit

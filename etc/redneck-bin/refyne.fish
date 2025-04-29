#!/bin/env fish

#BasicChecks
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

#flatpak
 #remote-add
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

#rpm-ostree
 #reload
  rpm-ostree reload
 #rebase
  brh rebase unstable -y
 #install
   rpm-ostree install --allow-inactive --idempotent -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-rawhide.noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-rawhide.noarch.rpm
   rpm-ostree install --allow-inactive --idempotent -y gh
   rpm-ostree install --allow-inactive --idempotent -y tlp tlp-rdw
   rpm-ostree install --allow-inactive --idempotent -y ollama
   rpm-ostree install --allow-inactive --idempotent -y pipewire
   rpm-ostree install --allow-inactive --idempotent -y mcpelauncher-manifest mcpelauncher-ui-manifest msa-manifest
   rpm-ostree install --allow-inactive --idempotent -y openssh openssh-server mosh
   rpm-ostree install --allow-inactive --idempotent -y rust cargo clippy
   rpm-ostree install --allow-inactive --idempotent -y distcc distcc-server distcc-gnome
   rpm-ostree install --allow-inactive --idempotent -y kernel-modules-extra
   rpm-ostree install --allow-inactive --idempotent -y cosmic-epoch cosmic-desktop cosmic-greeter
   rpm-ostree install --allow-inactive --idempotent -y gnome-shell gnome-shell-common gnome-software gnome-software-rpm-ostree gdm
   rpm-ostree install --allow-inactive --idempotent -y btop neohtop
   rpm-ostree install --allow-inactive --idempotent -y ghostty-nightly ghostty-nightly-fish-completion ghostty-nightly-shell-integration
   rpm-ostree install --allow-inactive --idempotent -y boinc-client boinc-client-static boinc-manager
   rpm-ostree install --allow-inactive --idempotent -y dnf dnf-repo dnf-data dnfdaemon dnfdaemon-selinux
   rpm-ostree install --allow-inactive --idempotent -y flatseal flatpak-selinux flatpak-session-helper xdg-desktop-portal flatpak-libs libportal host-spawn
   rpm-ostree install --allow-inactive --idempotent -y steam steam-devices extest-steam
   rpm-ostree install --allow-inactive --idempotent -y podman podman-docker podman-tui
   ##rpm-ostree install --allow-inactive --idempotent -y msa-dri-drivers mesa-va-drivers mesa-vdpau-drivers mesa-vulkan-drivers
   ##rpm-ostree install --allow-inactive --idempotent -y nvidia-gpu-firmware libva-nvidia-driver envytools gwe nvidia-patch
  #upgrade
   rpm-ostree upgrade --allow-downgrade
  #apply-live
   rpm-ostree apply-live
   rpm-ostree apply-live --allow-replacement

#Systemd
 #daemon-reload
  systemctl daemon-reload
 #mask 
  systemctl mask systemd-rfkill systemd-rfkill.socket
 #unmask 
  systemctl unmask hybrid-sleep.target shutdown.target reboot.target sleep.target poweroff.target suspend.target hibernate.target halt.target
 #disable 
  systemctl disable systemd-resolved
  systemctl disable tlp
  systemctl disable refyne.timer
  systemctl disable boinc-client
  systemctl disable mem-mgr
  systemctl disable systemd-bsod
  systemctl disable sshd
 #enable
  systemctl enable systemd-resolved
  systemctl enable tlp
  systemctl enable refyne.timer
  systemctl enable boinc-client
  systemctl enable mem-mgr
  systemctl enable systemd-bsod
  systemctl enable sshd
  
timedatectl set-ntp true --no-ask-password
  timedatectl set-local-rtc true --no-ask-password
  systemd-resolve --flush-caches

#Per-User
for user_path in (ls -d /home/*)
 set username (basename $user_path)
 set user_commands '
  gsettings set org.gnome.desktop.interface clock-show-seconds false;
  gsettings set org.gnome.desktop.interface enable-animations false;
  gsettings set org.gnome.desktop.peripherals.mouse accel-profile 'flat';
  gsettings set org.gnome.software allow-updates false;
  gsettings set org.gnome.desktop.peripherals.mouse speed 1.0;
  gsettings set org.gnome.shell.app-switcher current-workspace-only true;
  usermod -a -G boinc $username
 '
  runuser -l $username -c "fish -c '$user_commands'"
  echo ""
end

#Kernel
 plymouth-set-default-theme details
 rpm-ostree kargs \
  --append-if-missing=threadirqs \
  --append-if-missing=sysrq_always_enabled=1 \
  --append-if-missing=consoleblank=0 \
  --append-if-missing=quiet \
  --append-if-missing=loglevel=3 \
  --append-if-missing=preempt=full \
  --delete-if-present=rhgb
 rpm-ostree initramfs --enable

#BOINC
 usermod -a -G boinc boinc
 usermod -a -G boinc root
 chmod 744 /var/lib/boinc/cc_config.xml
 chmod 777 /var/lib/boinc/acct_mgr_url.xml
 chmod 777 /var/lib/boinc/acct_mgr_login.xml
 chmod 744 /etc/boinc-client/cc_config.xml
 chmod 777 /etc/boinc-client/acct_mgr_url.xml
 chmod 777 /etc/boinc-client/acct_mgr_login.xml

exit

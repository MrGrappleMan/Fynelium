#!/bin/env /bin/fish
### This script is like a template for your system ###
### Some preferences might not meet your requirements ###
### Adjusting some userspace settings and apps yourself is recommended after the reboot ###

# Aliases
 alias rot "rpm-ostree -q --peer"
 alias fpkremadd "flatpak remote-add --if-not-exists --system"

# Functions, actions, loops. Reserved for future use.

# Filesystem
 rm -rf /tmp/Fynelium
 mkdir /tmp/Fynelium
 git clone https://github.com/MrGrappleMan/Fynelium.git /tmp/Fynelium/
 cp -r /tmp/Fynelium/etc/* /etc/
 cp -r /tmp/Fynelium/var/* /var/
 cp -r /tmp/Fynelium/opt/* /opt/
 ##cp -r /tmp/Fynelium/root/* /root/
 mkdir -p /etc/playit
 mkdir -p /opt/playit

#InformTheUser
 clear
 echo "Fynelium - Setup started"

#snap

#fwupdmr
 #repos
  fwupdmgr enable-remote lvfs -y
  fwupdmgr enable-remote lvfs-testing -y

#flatpak
 #remote-add
  fpkremadd flathub https://flathub.org/repo/flathub.flatpakrepo
  fpkremadd flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo
  ###fpkremadd eos-sdk https://ostree.endlessm.com/ostree/eos-sdk
  fpkremadd igalia https://software.igalia.com/flatpak-refs/igalia.flatpakrepo
  fpkremadd dragon-nightly https://cdn.kde.org/flatpak/dragon-nightly/dragon-nightly.flatpakrepo
  ###fpkremadd eos-apps https://ostree.endlessm.com/ostree/eos-apps
  fpkremadd webkit https://software.igalia.com/flatpak-refs/webkit-sdk.flatpakrepo
  fpkremadd gnome-nightly https://nightly.gnome.org/gnome-nightly.flatpakrepo
  fpkremadd webkit-sdk https://software.igalia.com/flatpak-refs/webkit-sdk.flatpakrepo
  fpkremadd fedora oci+https://registry.fedoraproject.org
  fpkremadd fedora-testing oci+https://registry.fedoraproject.org/#testing
  fpkremadd rhel https://flatpaks.redhat.io/rhel.flatpakrepo
  fpkremadd eclipse-nightly https://download.eclipse.org/linuxtools/flatpak-I-builds/eclipse.flatpakrepo
  fpkremadd elementaryos https://flatpak.elementary.io/repo.flatpakrepo
  fpkremadd pureos https://store.puri.sm/repo/stable/pureos.flatpakrepo
  fpkremadd kde-runtime-nightly https://cdn.kde.org/flatpak/kde-runtime-nightly/kde-runtime-nightly.flatpakrepo
 #install
  flatpak install -y --noninteractive --system --include-sdk --or-update flathub-beta \
   org.freedesktop.Platform \
   org.gnome.Platform
  flatpak install -y --noninteractive --system --include-sdk --or-update flathub \
   io.github.celluloid_player.Celluloid \
   io.github.flattool.Warehouse
  flatpak install -y --noninteractive --system --include-sdk --or-update flathub-beta \
   com.visualstudio.code.insiders

#brh
 brh rebase unstable -y

#ujust - Recommended
 ujust setup-decky prerelease
 ujust get-decky-bazzite-buddy
 ujust get-framegen install-decky-plugin
 ujust get-framegen install
 ujust get-lsfg install
 ujust get-lsfg install-decky-plugin
 ujust toggle-password-feedback off
 ujust configure-grub show
 ujust enable-automounting
 ujust enable-steamos-automount
 ujust get-media-app "YouTube" # This looks smooth even on a 60Hz monitor.

#rpm-ostree
 #install
   rot install --allow-inactive --idempotent -y \
    rust-zram-generator-devel preload \
    tlp tlp-rdw \
    pipewire wireplumber wireplumber-libs \
    kernel-modules-extra uutils-coreutils util-linux \
    cosmic-epoch cosmic-desktop xdg-desktop-portal-cosmic initial-setup-gui-wayland-cosmic cosmic-greeter cosmic-comp cosmic-app-library cosmic-applets cosmic-edit cosmic-idle cosmic-osd cosmic-session cosmic-settings cosmic-settings-daemon cosmic-store fedora-release-cosmic-atomic cosmic-config-fedora greetd \
    gdm \
    boinc-client boinc-client-static boinc-manager \
    flatseal flatpak-selinux flatpak-session-helper xdg-desktop-portal flatpak-libs libportal host-spawn \
    fish \
    libei libei-utils \
    btop fastfetch \
    zstd
    
    ## System Boosters ##
    ## Power management ##
    ## User environment ##
    ## Kernel mods ##
    ## COSMIC ##
    ## GDM ##
    ## Science United ##
    ## Flatpak ##
    ## Snap ##
    ## Fish ##
    ## Libei ##
    ## TTY Shows ##
    ## Compression ##
    ## Zen Browser ##

    ## GhosTTY ## ghostty-nightly ghostty-nightly-fish-completion ghostty-nightly-shell-integration

    ### Developer Specific:-
     ## Version Control Systems:
      # git gh
     ## Rust:
      # rust cargo clippy
     ## C stuff:
      # cpp
     ## Java:
      # java-latest-openjdk
     ## Compilation:
      # distcc distcc-server gcc gcc-c++
     ## Containerization / Orchestration:
      # podman podman-docker
     ## Penetration testing / Hacking:
      # aircrack-ng turbo-attack golang-github-redteampentesting-monsoon
     ## Artificial Intelligence:
      # ollama

    ### Gaming:-
     ## Steam:
      # steam steam-devices
     ## Vavoom:
      # vavoom vavoom-engine

    ### Graphics:-
     ## Mesa:
      # mesa-va-drivers-freeworld mesa-vdpau-drivers-freeworld mesa-vulkan-drivers-freeworld
      # mesa-dri-drivers
      # mesa-va-drivers mesa-vdpau-drivers mesa-vulkan-drivers
      # mesa-libOSMesa mesa-compat-libOSMesa
     ## AMD: amd-gpu-firmware amd-ucode-firmware amdsmi am-utils
     ## Nvidia: nvidia-gpu-firmware libva-nvidia-driver envytools nvidia-patch

   ### Multipurpose:-
    ## Remote access
     # openssh openssh-server mosh
    ## PKGMGR Snap
     # snapd snapd-selinux

#System
 #Policies and permissions
  chmod a+x /opt/playit/playit
  chmod a+x /opt/mc-server/mc-server
 #refresh
  nohup systemctl daemon-reload &
  nohup timedatectl set-ntp true --no-ask-password &
 #Services 
  systemctl mask \
   systemd-rfkill systemd-rfkill.socket \
   tracker-store \
   rpm-ostree-countme rpm-ostree-countme.timer
  systemctl unmask \
   gdm \
   shutdown.target reboot.target poweroff.target halt.target
  systemctl reenable \
   systemd-resolved systemd-networkd systemd-networkd-wait-online NetworkManager-wait-online systemd-timesyncd \
   boinc-client \
   tlp \
   uupd uupd.timer \
   systemd-bsod \
   sshd playit tailscaled \
   preload systemd-zram-setup@zram0 \
   gdm \
   mc-server

### For the inbuilt Minecraft server service, switch to Java edition by running and exploring it,
### systemctl edit mc-server

#gsettings
 gsettings set org.gnome.desktop.interface clock-show-seconds false;
 gsettings set org.gnome.desktop.interface enable-animations false;
 gsettings set org.gnome.desktop.peripherals.mouse accel-profile 'flat';
 gsettings set org.gnome.software download-updates false;
 gsettings set org.gnome.desktop.peripherals.mouse speed 1.0;
 gsettings set org.gnome.shell.app-switcher current-workspace-only true;
 gsettings set org.gnome.system.location max-accuracy-level 'exact';
 gsettings set org.gnome.system.location enabled true;
 gsettings set org.gnome.login-screen allowed-failures 15;
 gsettings set org.gnome.SessionManager auto-save-session true;
 gsettings set org.gnome.SessionManager logout-prompt true;
 gsettings set org.gnome.SessionManager auto-save-session-one-shot true;
 gsettings set org.gnome.mutter dynamic-workspaces true;
 gsettings set org.gnome.desktop.sound allow-volume-above-100-percent true;
 gsettings set org.gnome.desktop.thumbnail-cache maximum-size 128;
 gsettings set org.gnome.desktop.thumbnail-cache maximum-age 3;
 gsettings set org.gnome.desktop.background picture-options 'none';
 gsettings set org.gnome.desktop.background primary-color '#000000';
 gsettings set org.gnome.desktop.background secondary-color '#000000';
 gsettings set org.gnome.desktop.background picture-uri '';
 gsettings set org.gnome.desktop.background picture-uri-dark '';
 gsettings set org.gnome.desktop.background picture-opacity 0;
 gsettings set org.gnome.desktop.interface cursor-blink false;
 gsettings set org.gnome.software allow-updates true;
 gsettings set org.gnome.software download-updates true;
 gsettings set org.gnome.software download-updates-notify false;
 gsettings set org.gnome.software show-ratings true;
 gsettings set org.gnome.software show-upgrade-prerelease true;
 gsettings set org.gnome.software show-nonfree-ui true;
 gsettings set org.gnome.software show-only-free-apps false;
 gsettings set org.gnome.software show-only-verified-apps false;
 gsettings set org.gnome.software prompt-for-nonfree true;
 gsettings set org.gnome.software refresh-when-metered false;
 gsettings set org.gnome.desktop.interface clock-show-weekday true;
 gsettings set org.gnome.desktop.interface clock-show-date true;
 gsettings set org.gnome.desktop.lockdown disable-lock-screen false;
 gsettings set org.gnome.login-screen fallback-logo '';
 gsettings set org.gnome.login-screen logo '';
 gsettings set org.gnome.system.location enabled true;
 gsettings set org.gnome.system.location max-accuracy-level 'exact';
 gsettings set org.gnome.online-accounts whitelisted-providers ['all'];
 gsettings set org.gnome.mutter center-new-windows true;
 gsettings set org.gnome.mutter auto-maximize true;
 gsettings set org.gnome.desktop.interface cursor-blink false;
 gsettings set org.gnome.desktop.interface font-hinting 'full';
 gsettings set org.gnome.desktop.interface font-antialiasing 'grayscale';
 gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark';
 gsettings set org.gnome.desktop.interface locate-pointer false;
 gsettings set org.gnome.desktop.a11y.interface high-contrast false;
 gsettings set org.freedesktop.Tracker3.Miner.Files crawling-interval -2;
 gsettings set org.freedesktop.Tracker3.Miner.Files enable-monitors false;
 gsettings set org.freedesktop.Tracker3.Miner.Files ignored-directories ['all'];
 gsettings set org.freedesktop.Tracker3.Miner.Files ignored-directories-with-content ['all'];
 gsettings set org.freedesktop.Tracker3.Miner.Files ignored-files ['all'];
 gsettings set org.freedesktop.Tracker3.Miner.Files index-on-battery false;
 gsettings set org.freedesktop.Tracker3.Miner.Files index-on-battery-first-time false;
 gsettings set org.freedesktop.Tracker3.Miner.Files index-removable-devices false;
 gsettings set org.freedesktop.Tracker3.Miner.Files index-recursive-directories [];
 gsettings set org.freedesktop.Tracker3.Miner.Files index-single-directories [];
 gsettings set org.freedesktop.Tracker3.Miner.Files initial-sleep 1000;
 gsettings set org.freedesktop.Tracker3.Miner.Files throttle 20;
 gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'hibernate';
 gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing';
 gsettings set org.gnome.settings-daemon.plugins.power power-saver-profile-on-low-battery true;
 gsettings set org.gnome.settings-daemon.plugins.power idle-dim true;
 gsettings set org.gnome.desktop.session idle-delay 60;
 gsettings set org.gnome.desktop.screensaver idle-activation-enabled false;
 gsettings set org.gnome.desktop.screensaver lock-delay 300;
 gsettings set org.gnome.desktop.peripherals.keyboard remember-numlock-state true;
 gsettings set org.gnome.desktop.break-reminders.eyesight fade-screen true;
 gsettings set org.gnome.desktop.break-reminders.eyesight notify true;
 gsettings set org.gnome.desktop.break-reminders.eyesight interval-seconds 1200;
 gsettings set org.gnome.desktop.break-reminders.eyesight countdown false;
 gsettings set org.gnome.desktop.break-reminders.eyesight delay-seconds 10;
 gsettings set org.gnome.desktop.break-reminders.eyesight duration-seconds 20;
 gsettings set org.gnome.desktop.remote-desktop.vnc enable false;
 gsettings set org.gnome.desktop.remote-desktop.rdp enable true;
 gsettings set org.gnome.desktop.remote-desktop.rdp negotiate-port true;
 gsettings set org.gnome.desktop.remote-desktop.rdp port 3389;
 gsettings set org.gnome.desktop.remote-desktop.rdp view-only false;

# Kernel
 rot initramfs --enable
 plymouth-set-default-theme spinner
 rot kargs \
  --append-if-missing=rhgb \
  --append-if-missing=threadirqs \
  --append-if-missing=sysrq_always_enabled=1 \
  --append-if-missing=consoleblank=0 \
  --append-if-missing=quiet \
  --append-if-missing=profile \
  --append-if-missing=loglevel=3 \
  --append-if-missing=preempt=full \
  --append-if-missing=zswap.enabled=0

# Reboot
 systemctl reboot

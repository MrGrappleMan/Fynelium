#!/bin/env /bin/fish
### This file ensures a form of standardization across your system ###
### Some preferences might not meet your requirements ###
### Adjusting or adapting yourself to them is recommended ###

#BasicChecks
 if test (id -u) -ne 0
  echo "Not root user"
  exit 1
 end
 if not ping -c 1 -W 2 8.8.8.8 > /dev/null
    echo "No access to internet or Google DNS"
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
 cp -r /tmp/Fynelium/opt/* /opt/
 ##cp -r /tmp/Fynelium/root/* /root/
 mkdir -p /etc/playit
 mkdir -p /opt/playit
 
#FileMod
 for file in (find /opt -type f)
	set info (file $file)
	if string match -q '*executable*' $info; or string match -q '*script*' $info
		chmod +x $file
		echo "Marked +x: $file"
	end
end
 chmod a+x /opt/playit/playit
 chmod a+x /opt/mcbe-server/bedrock_server
 chmod a+x /opt/mcje-server/server.jar
 usermod -a -G boinc boinc
 usermod -a -G boinc root

#clear
 clear
 echo "fn.fish started"
#snap
#flatpak
 #remote-add
  flatpak remote-add --if-not-exists --system flathub https://flathub.org/repo/flathub.flatpakrepo
  flatpak remote-add --if-not-exists --system flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo
  flatpak remote-add --if-not-exists --system eos-sdk https://ostree.endlessm.com/ostree/eos-sdk
  flatpak remote-add --if-not-exists --system igalia https://software.igalia.com/flatpak-refs/igalia.flatpakrepo
  flatpak remote-add --if-not-exists --system dragon-nightly https://cdn.kde.org/flatpak/dragon-nightly/dragon-nightly.flatpakrepo
  flatpak remote-add --if-not-exists --system eos-apps https://ostree.endlessm.com/ostree/eos-apps
  flatpak remote-add --if-not-exists --system webkit https://software.igalia.com/flatpak-refs/webkit-sdk.flatpakrepo
  flatpak remote-add --if-not-exists --system gnome-nightly https://nightly.gnome.org/gnome-nightly.flatpakrepo
  flatpak remote-add --if-not-exists --system webkit-sdk https://software.igalia.com/flatpak-refs/webkit-sdk.flatpakrepo
  flatpak remote-add --if-not-exists --system fedora oci+https://registry.fedoraproject.org
  flatpak remote-add --if-not-exists --system fedora-testing oci+https://registry.fedoraproject.org/#testing
  flatpak remote-add --if-not-exists --system rhel https://flatpaks.redhat.io/rhel.flatpakrepo
  flatpak remote-add --if-not-exists --system eclipse-nightly https://download.eclipse.org/linuxtools/flatpak-I-builds/eclipse.flatpakrepo
  flatpak remote-add --if-not-exists --system elementaryos https://flatpak.elementary.io/repo.flatpakrepo
  flatpak remote-add --if-not-exists --system pureos https://store.puri.sm/repo/stable/pureos.flatpakrepo
  flatpak remote-add --if-not-exists --system kde-runtime-nightly https://cdn.kde.org/flatpak/kde-runtime-nightly/kde-runtime-nightly.flatpakrepo
 #install
  flatpak install -y --noninteractive --system --include-sdk --or-update flathub-beta \
   org.freedesktop.Platform \
   org.gnome.Platform
  flatpak install -y --noninteractive --system --include-sdk --or-update flathub \
   io.neovim.nvim \
   io.github.celluloid_player.Celluloid \
   org.vinegarhq.Sober org.vinegarhq.Vinegar \
   io.github.flattool.Warehouse
  flatpak install -y --noninteractive --system --include-sdk --or-update flathub-beta \
   com.visualstudio.code.insiders
#rpm-ostree
 #rebase
    brh rebase unstable -y
 #install
   rpm-ostree install --allow-inactive --idempotent -y --peer \
    git gh \
    rust cargo clippy \
    cpp \
    distcc distcc-server gcc gcc-c++ \
    java-latest-openjdk \
    rust-zram-generator-devel preload \
    tlp tlp-rdw \
    pipewire wireplumber wireplumber-libs \
    kernel-modules-extra uutils-coreutils util-linux \
    openssh openssh-server mosh \
    cosmic-epoch cosmic-desktop xdg-desktop-portal-cosmic initial-setup-gui-wayland-cosmic cosmic-greeter cosmic-comp cosmic-app-library cosmic-applets cosmic-edit cosmic-idle cosmic-osd cosmic-session cosmic-settings cosmic-settings-daemon cosmic-store fedora-release-cosmic-atomic cosmic-config-fedora greetd \
    gdm \
    boinc-client boinc-client-static \
    flatseal flatpak-selinux flatpak-session-helper xdg-desktop-portal flatpak-libs libportal host-spawn \
    snapd snapd-selinux \
    podman podman-docker \
    fish \
    libei libei-utils \
    btop fastfetch \
    steam steam-devices \
    zstd \
    mcpelauncher-manifest mcpelauncher-ui-manifest msa-manifest \
    zen-browser

    ## VCS ##
    ## RustLang ##
    ## C Lang ##
    ## Compiling ##
    ## Java ##
    ## System Boosters ##
    ## Power management ##
    ## PipeWire WirePluber ##
    ## Kernel mods ##
    ## Remote access ##
    ## COSMIC ##
    ## GDM ##
    ## Science United ##
    ## Flatpak ##
    ## Snap ##
    ## Podman ##
    ## Fish ##
    ## Libei ##
    ## TTY Shows ##
    ## Steam ##
    ## Compression ##
    ## MC Bedrock ##
    ## Zen Browser ##

    ## Mesa ## mesa-dri-drivers mesa-va-drivers mesa-vdpau-drivers mesa-vulkan-drivers
    ## NVIDIA ## nvidia-gpu-firmware libva-nvidia-driver envytools gwe nvidia-patch
    ## AMD ## amd-gpu-firmware amd-ucode-firmware amdsmi am-utils
    ## GhosTTY ## ghostty-nightly ghostty-nightly-fish-completion ghostty-nightly-shell-integration
    ## Hecking ## aircrack-ng turbo-attack golang-github-redteampentesting-monsoon
    ## Quake Engine ## vavoom vavoom-engine
    ## AI ## ollama

#Systemd
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
  # systemctl disable \
  #  plymouth-halt plymouth-kexec plymouth-poweroff plymouth-quit-wait plymouth-quit plymouth-read-write plymouth-reboot plymouth-start plymouth-switch-root-initramfs plymouth-switch-root
  systemctl reenable \
   systemd-resolved systemd-networkd systemd-networkd-wait-online systemd-timesyncd \
   tlp \
   uupd.timer \
   systemd-bsod \
   sshd playit tailscaled \
   preload systemd-zram-setup@zram0 \
   gdm \
   mcbe-server mcje-server

#Per-User
for user_path in (ls -d /home/*)
 set username (basename $user_path)
 set user_commands '
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
  ujust setup-sunshine ACTION="Enable"
 '
  runuser -l $username -c "fish -c '$user_commands'"
  echo ""
end

#Kernel
 rpm-ostree initramfs --enable
 rpm-ostree kargs \
  --append-if-missing=threadirqs \
  --append-if-missing=sysrq_always_enabled=1 \
  --append-if-missing=consoleblank=0 \
  --delete-if-present=quiet \
  --append-if-missing=profile \
  --append-if-missing=loglevel=3 \
  --append-if-missing=preempt=full \
  --append-if-missing=zswap.enabled=0

exit

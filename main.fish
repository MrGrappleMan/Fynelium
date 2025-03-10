#!/bin/fish

#Initialize:-
chmod -R 755 /etc/
cp -r /tmp/Fynelium/LXroot/etc/* /etc/
chmod -R 755 /var/
cp -r /tmp/Fynelium/LXroot/var/* /var/

#Packaging
 #Flatpak
  #Repos
   flatpak remote-delete --force --system flathub
   flatpak remote-delete --force --system eos-sdk
   flatpak remote-delete --force --system igalia
   flatpak remote-delete --force --system dragon-nightly
   flatpak remote-delete --force --system xwaylandvideobridge-nightly
      flatpak remote-delete --force --system eos-apps
      flatpak remote-delete --force --system webkit
      flatpak remote-delete --force --system flathub-beta
      flatpak remote-delete --force --system gnome-nightly
      flatpak remote-delete --force --system webkit-sdk
      flatpak remote-delete --force --system fedora
      flatpak remote-delete --force --system fedora-testing
      flatpak remote-delete --force --system rhel
      flatpak remote-add --if-not-exists --system flatpak remote-delete --force --system eclipse-nightly
			flatpak remote-delete --force --system elementaryos
			flatpak remote-delete --force --system pureos
      flatpak remote-delete --force --system kde-runtime-nightly

			flatpak remote-add --if-not-exists --system flathub https://flathub.org/repo/flathub.flatpakrepo
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

flatpak remote-modify --system --subset=floss flathub
flatpak remote-modify --system --subset=floss flathub-beta
		#Pkgs
flatpak install --system --noninteractive --or-update flathub com.gopeed.Gopeed
flatpak install --system --noninteractive --or-update flathub io.github.flattool.Warehouse
flatpak install --system --noninteractive --or-update flathub com.github.rkoesters.xkcd-gtk
flatpak install --system --noninteractive --or-update flathub org.geogebra.GeoGebra
flatpak install --system --noninteractive --or-update flathub com.vscodium.codium-insiders
flatpak install --system --noninteractive --or-update flathub se.sjoerd.Graphs
flatpak install --system --noninteractive --or-update flathub org.cubocore.CoreStats
flatpak install --system --noninteractive --or-update flathub net.cozic.joplin_desktop
flatpak install --system --noninteractive --or-update flathub org.octave.Octave

#RPM-OSTree
	#Repos
 rpm-ostree -q --peer rebase fedora:fedora/rawhide/aarch64/silverblue
 rpm-ostree -q --peer install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-rawhide.noarch.rpm

	#Pkgs
rpm-ostree -q --peer install --allow-inactive --idempotent tlp tlp-rdw
rpm-ostree -q --peer install --allow-inactive --idempotent kde
rpm-ostree -q --peer install --allow-inactive --idempotent kernel-modules-extra
rpm-ostree -q --peer install --allow-inactive --idempotent dnf dnf-repo
rpm-ostree -q --peer install --allow-inactive --idempotent ghostty
rpm-ostree -q --peer install --allow-inactive --idempotent rustup rust
rpm-ostree -q --peer install --allow-inactive --idempotent golang
rpm-ostree -q --peer install --allow-inactive --idempotent distcc
rpm-ostree -q --peer install --allow-inactive --idempotent ostree-devel 
rpm-ostree -q --peer install --allow-inactive --idempotent zen-browser torbrowser-launcher
rpm-ostree -q --peer install --allow-inactive --idempotent boinc-client
rpm-ostree -q --peer install --allow-inactive --idempotent topgrade
rpm-ostree -q --peer install --allow-inactive --idempotent gnome-software
rpm-ostree -q --peer install --allow-inactive --idempotent flatseal flatpak-selinux flatpak-session-helper xdg-desktop-portal flatpak-libs libportal host-spawn
rpm-ostree -q --peer install --allow-inactive --idempotent beep

rpm-ostree -q --peer uninstall --allow-inactive --idempotent power-profiles-daemon
rpm-ostree -q --peer uninstall --allow-inactive --idempotent firefox
rpm-ostree -q --peer uninstall --allow-inactive --idempotent xwaylandvideobridge

#System

systemctl daemon-reload

systemctl mask systemd-rfkill systemd-rfkill.socket

systemctl enable tlp
systemctl enable autopgrade.timer autopgrade
systemctl enable boinc-client
systemctl enable zram-init
systemctl enable systemd-bsod
systemctl enable gdm

plymouth-set-default-theme spinner

rpm-ostree -q --peer  kargs --append-if-missing=threadirqs
rqe kargs --delete-if-present=rhgb
rqe kargs --append-if-missing=sysrq_always_enabled=1
rqe kargs --append-if-missing=consoleblank=0
rqe kargs --append-if-missing=quiet
rqe kargs --append-if-missing=loglevel=3
rqe kargs --append-if-missing=preempt=full
rqe initramfs --enable

systemctl unmask hybrid-sleep.target shutdown.target reboot.target poweroff.target sleep.target
systemctl reboot

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

chmod -R 755 /etc/
cp -r LXroot/etc/* /etc/
systemctl daemon-reload
systemctl enable --now systemd-resolved systemd-networkd
systemctl stop \
	rpm-ostreed-automatic.service \
	rpm-ostreed-automatic.timer

# RPM-OSTree:-
# Configuration:
rqe cancel
rqe reload
if echo $base | grep -q "bazzite"
	set base (echo $base | sed 's/stable/unstable/g; s/testing/unstable/g')
	rqe rebase --experimental "$base"
end
rqe install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-rawhide.noarch.rpm \
	https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-rawhide.noarch.rpm
# Packages:
listedexec "tlp tlp-rdw
tor
moby-engine
gnome-terminal
podman
distrobox
distcc-server" "rqe install --allow-inactive --idempotent \$crntval"
rqe uninstall --allow-inactive --idempotent \
	power-profiles-daemon

# Flatpak:-
# Configuration:
set flatpak_repos \
	"flathub=https://dl.flathub.org/repo/flathub.flatpakrepo \
	flathub-beta=https://flathub.org/beta-repo/flathub-beta.flatpakrepo \
	gnome-nightly=https://nightly.gnome.org/gnome-nightly.flatpakrepo \
	fedora=oci+https://registry.fedoraproject.org \
	fedora-testing=oci+https://registry.fedoraproject.org/#testing \
	rhel=https://flatpaks.redhat.io/rhel.flatpakrepo \
	webkit-sdk=https://software.igalia.com/flatpak-refs/webkit-sdk.flatpakrepo \
	eclipse-nightly=https://download.eclipse.org/linuxtools/flatpak-I-builds/eclipse.flatpakrepo \
	xwaylandvideobridge-nightly=https://cdn.kde.org/flatpak/xwaylandvideobridge-nightly/xwaylandvideobridge-nightly.flatpakrepo"
for repo in $flatpak_repos
    set name (echo $repo | cut -d '=' -f 1)
    set url (echo $repo | cut -d '=' -f 2)
    flatpak remote-add --if-not-exists --system $name $url
end
flatpak update --noninteractive
# Packages:
set flatpak_pkgs \
	"flathub=com.github.d4nj1.tlpui"
for pkgstring in $flatpak_pkgs
    set rrepo (echo $pkgstring | cut -d '=' -f 1)
    set pkg (echo $pkgstring | cut -d '=' -f 2)
    flatpak install --noninteractive --or-update $rrepo $pkg
end

# Docker:-
# Containers:
wget https://gitlab.torproject.org/tpo/anti-censorship/docker-snowflake-proxy/raw/main/docker-compose.yml
docker compose up -d snowflake-proxy
# Finalize:
set CONTAINERS 'snowflake-proxy'
docker run -d --name watchtower -v /var/run/docker.sock:/var/run/docker.sock containrrr/watchtower --cleanup --include-stopped --include-restarting --revive-stopped --interval 300 $CONTAINERS
docker update --restart=always --memory-swap=-1 --cpus=0 --cpu-quota=0 --pids-limit=-1 --cpu-rt-period=2000000 (sudo docker ps -q -a)

# System:-
# Finalize Ostree pkgs:
systemctl mask \
	systemd-rfkill.service systemd-rfkill.socket
listedexec "tlp
boinc-client
docker
rpm-ostreed-automatic
rpm-ostreed-automatic.timer" "systemctl enable \$crntval"
boinccmd --acct_mgr attach scienceunited.org 
# Boot:
plymouth-set-default-theme spinner
rqe kargs --append-if-missing="rhgb,threadirqs,sysrq_always_enabled=0,consoleblank=0,quiet,loglevel=3,preempt=full"
rqe initramfs --enable

systemctl poweroff

#!/bin/fish

systemctl daemon-reload

systemctl mask systemd-rfkill systemd-rfkill.socket

systemctl enable tlp
systemctl enable autopgrade.timer
systemctl enable boinc-client
systemctl enable zram-init
systemctl enable systemd-bsod

plymouth-set-default-theme spinner

rqe kargs --append-if-missing=threadirqs
rqe kargs --delete-if-present=rhgb
rqe kargs --append-if-missing=sysrq_always_enabled=1
rqe kargs --append-if-missing=consoleblank=1
rqe kargs --append-if-missing=quiet
rqe kargs --append-if-missing=loglevel=3
rqe kargs --append-if-missing=preempt=full
rqe initramfs --enable

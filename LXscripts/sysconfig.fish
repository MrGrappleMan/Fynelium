#!/bin/fish

systemctl daemon-reload

systemctl mask systemd-rfkill systemd-rfkill.socket

systemctl enable tlp
systemctl enable autopgrade.timer
systemctl enable boinc-client
systemctl enable fyn-zram
systemctl enable fyn-refyne.timer
systemctl enable systemd-bsod

plymouth-set-default-theme details

rqe kargs --append-if-missing=threadirqs
rqe kargs --append-if-missing=rhgb
rqe kargs --append-if-missing=sysrq_always_enabled=1
rqe kargs --append-if-missing=consoleblank=0
rqe kargs --append-if-missing=quiet
rqe kargs --append-if-missing=loglevel=3
rqe kargs --append-if-missing=preempt=full
rqe initramfs --disable

grubby --args="threadirqs rhgb sysrq_always_enabled=1" --update-kernel=ALL
grub2-mkconfig

#!/bin/fish

rpm-ostree -q --peer rebase fedora:fedora/rawhide/aarch64/silverblue
rpm-ostree -q --peer install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-rawhide.noarch.rpm

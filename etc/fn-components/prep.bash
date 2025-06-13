#!/bin/bash

rpm-ostree install fish
apt install fish
dnf install fish
rpm-ostree apply-live
rpm-ostree apply-live --allow-replacement

fish /etc/fn-components/main.fish

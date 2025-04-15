#!/usr/bin/fish

if test (id -u) -ne 0
    exit
end

ujust update
rpm-ostree apply-live --allow-replacement
systemctl daemon-reload
boinccmd --acct_mgr sync
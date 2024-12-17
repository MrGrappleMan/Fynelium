#!/usr/bin/fish

function countdown_shutdown
    if test (count $argv) -ne 1
        echo "Usage: countdown_shutdown <seconds>"
        return 1
    end

    # Get the input seconds
    set seconds 300

    for i in (seq $seconds -1 1)
        notify-send "Shutdown Notice" "System will shut down in $i seconds" -u critical
        sleep 1
    end

    notify-send "Shutdown Notice" "Shutting down now!" -u critical
    systemctl poweroff
end
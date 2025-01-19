#!/bin/fish

function listedexec
    set -l command_template $argv[1]
    set -l contents $argv[2]

    for subcommand in (echo "$command_template" | string split "\n")
        for item in (echo "$contents" | string split "\n")
            set -l command (string replace '$crntval' "$item" "$subcommand")
            eval "$command"
        end
    end
end

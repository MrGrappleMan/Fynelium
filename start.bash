#!/bin/bash

# Platform Recognition:
uname=$(uname)
case "$uname" in
    Linux) scriptFile='LX.bash' ;;
    Darwin) scriptFile='DW.bash' ;;
    *) echo "Error: Unsupported platform ($uname)." >&2; exit 2 ;;
esac

# Homebrew Installation:
install_homebrew() {
    if ! command -v brew &>/dev/null; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || {
            echo "Error: Homebrew installation failed." >&2
            exit 1
        }
        if [[ "$uname" == "Linux" ]]; then
            eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
        elif [[ "$uname" == "Darwin" ]]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
    fi
}

# Git Installation:
install_git() {
    if ! command -v git &>/dev/null; then
        if command -v rpm-ostree &>/dev/null; then
            rpm-ostree install git || {
                echo "Error: Failed to install Git via rpm-ostree." >&2
                exit 1
            }
            rpm-ostree apply-live --allow-replacement
        elif command -v brew &>/dev/null; then
            brew install git || {
                echo "Error: Failed to install Git via Homebrew." >&2
                exit 1
            }
        else
            echo "Error: No package manager available to install Git." >&2
            exit 1
        fi
    fi
}

# Clone Repository:
clone_repository() {
    cd ~ || exit 1
    rm -rf /tmp/Fynelium
    git clone https://github.com/MrGrappleMan/Fynelium.git /tmp/Fynelium || {
        echo "Error: Failed to clone repository." >&2
        exit 1
    }
    chmod -R 755 /tmp/Fynelium
    cd /tmp/Fynelium || exit 1
}

# Execute Platform-Specific Script:
execute_script() {
    if [[ "$uname" == "Linux" ]]; then
        sudo pkill -t tty3 || true  # Ignore errors if no processes on tty3

        sudo chown root "$scriptFile"  # Ensure root ownership of the script
        sudo chmod 755 "$scriptFile"  # Ensure script is executable
        sudo openvt -s -c 3 -- bash "$scriptFile" || {
            echo "Error: Failed to launch $scriptFile on tty3." >&2
            exit 1
        }
    elif [[ -f "$scriptFile" ]]; then
        /bin/bash "$scriptFile" || {
            echo "Error: Execution of $scriptFile failed." >&2
            exit 1
        }
    else
        echo "Error: Script file $scriptFile not found." >&2
        exit 1
    fi
}

# Main Procedure:
install_homebrew
install_git
clone_repository
execute_script
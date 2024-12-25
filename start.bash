#!/bin/bash

# Platform Recognition:
uname=$(uname)
case "$uname" in
    Linux) scriptFile='LX.bash' ;;
    Darwin) scriptFile='DW.bash' ;;
    *) echo "Error: Unsupported platform ($uname)."; exit 2 ;;
esac

# Homebrew Installation:
install_homebrew() {
    if ! command -v brew &>/dev/null; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || {
            echo "Error: Homebrew installation failed."
            exit 1
        }
        # Make Homebrew immediately available for this session
        if [[ "$uname" == "Linux" ]]; then
            eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
        elif [[ "$uname" == "Darwin" ]]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
    else
        echo "Homebrew is already installed."
    fi
}

# Git Installation:
install_git() {
    if ! command -v git &>/dev/null; then
        echo "Installing Git..."
        if command -v rpm-ostree &>/dev/null; then
            rpm-ostree install git || {
                echo "Error: Failed to install Git via rpm-ostree."
                exit 1
            }
            rpm-ostree apply-live --allow-replacement
        elif command -v brew &>/dev/null; then
            brew install git || {
                echo "Error: Failed to install Git via Homebrew."
                exit 1
            }
        else
            echo "Error: No package manager available to install Git."
            exit 1
        fi
    else
        echo "Git is already installed."
    fi
}

# Clone Repository:
clone_repository() {
    echo "Cloning Fynelium repository..."
    cd ~ || exit 1
    rm -rf /tmp/Fynelium
    git clone https://github.com/MrGrappleMan/Fynelium.git /tmp/Fynelium || {
        echo "Error: Failed to clone repository."
        exit 1
    }
    chmod -R 755 /tmp/Fynelium
    cd /tmp/Fynelium || exit 1
}

# Execute Platform-Specific Script:
execute_script() {
    if [[ "$uname" == "Linux" ]]; then
        echo "Killing processes on tty3..."
        sudo pkill -t tty3 || echo "No processes to kill on tty3."

        echo "Launching $scriptFile on tty3 as root..."
        sudo chown root "$scriptFile"  # Ensure root ownership of the script
        sudo chmod 755 "$scriptFile"  # Ensure script is executable
        sudo openvt -s -c 3 -- bash "$scriptFile" || {
            echo "Error: Failed to launch $scriptFile on tty3."
            exit 1
        }
    elif [[ -f "$scriptFile" ]]; then
        echo "Executing $scriptFile..."
        /bin/bash "$scriptFile" || {
            echo "Error: Execution of $scriptFile failed."
            exit 1
        }
    else
        echo "Error: Script file $scriptFile not found."
        exit 1
    fi
}

# Main Procedure:
install_homebrew
install_git
clone_repository
execute_script
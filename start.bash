#!/bin/bash

# Function to check command success
check_success() {
    if [ $? -ne 0 ]; then
        echo "Error: $1 failed."
        exit 1
    fi
}

# OS Recognition
uname=$(uname)
case "$uname" in
    Linux) scriptFile='LX.bash' ;;
    Darwin) scriptFile='DW.bash' ;;
    *) echo "Error: ($uname) unsupported"; exit 2 ;;
esac

# Install Homebrew (macOS only)
if [ "$uname" = "Darwin" ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    check_success "Homebrew installation"
fi

# Install Git
if [ "$uname" = "Linux" ]; then
    if command -v rpm-ostree &>/dev/null; then
        rpm-ostree install git
        check_success "Git installation"
        rpm-ostree apply-live --allow-replacement
        check_success "Applying live changes"
    else
        echo "Error: Support only for Fedora Atomic OR Silverblue"
        exit 3
    fi
elif [ "$uname" = "Darwin" ]; then
    brew install git
    check_success "Git installation"
fi

# Clone Repository
rm -rf /tmp/Fynelium
git clone https://github.com/MrGrappleMan/Fynelium.git /tmp/Fynelium
check_success "Repository cloning"
chmod -R 755 /tmp/Fynelium
cd /tmp/Fynelium || exit

# Execute Script
/bin/bash "$scriptFile"
check_success "Execution of $scriptFile"
#!/bin/bash

# This commands is based from the Ansible installation guidd
# https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#pip-install

python3 -m pip install --user ansible

# This check has been included since there are instances
# where the ansible command may remain unavailable
# even after the installation process.

# Check if ansible command is available
ansible_version=$(ansible --version 2>&1)

if [ -z "$ansible_version" ]; then
    echo "Ansible command not found. Running fix..."

    # Add the ~/.local/bin to PATH environment variable 
    export PATH=$PATH:~/.local/bin

    # recheck the ansible command if available
    ansible_version=$(ansible --version 2>&1)

    if [ -z "$ansible_version" ]; then
        echo "Fix failed. Unable to install Ansible."
    else
        echo "Fix completed successfully. Ansible is now available."
    fi
else
    echo "Ansible is already installed. No fix required."
fi

display_success_message() {
    GREEN='\033[0;32m'
    RESET='\033[0m'
    local message="$(eval "$1")"
    echo "----------------------------------------"
    echo -e "${GREEN}Successfully installed ${message}${RESET}"
    echo "----------------------------------------"
}


display_success_message "ansible --version"
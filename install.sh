#!/bin/bash

echo -e "\033[1;32m============================="
echo -e "       SCRIPT VERSION 1.6     "
echo -e "=============================\033[0m"


echo "Starting Ubuntu server initialization..."

# 1. Update & upgrade system
echo "Updating package lists..."
sudo apt update -y

echo "Upgrading packages..."
sudo apt upgrade -y

# 2. Install essential utilities
echo "Installing useful utilities..."
sudo apt install -y curl wget git ufw htop unzip zip tmux fail2ban sl

# 3. Enable Unattended Upgrades
echo "Installing and configuring unattended-upgrades..."
sudo apt install -y unattended-upgrades apt-listchanges
sudo dpkg-reconfigure -f noninteractive unattended-upgrades

# 4. Enable automatic security updates (if not already done)
echo "Ensuring automatic security updates are enabled..."
sudo systemctl enable --now unattended-upgrades

# 4. Install docker
echo "Installing Docker via apt..."
echo "→ Installing prerequisite packages..."
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg lsb-release

echo "→ Adding Docker’s official GPG key..."
sudo install -m 0755 -d /etc/apt/keyrings
sudo rm -f /etc/apt/keyrings/docker.gpg
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg --yes
sudo chmod a+r /etc/apt/keyrings/docker.gpg

CODENAME=$(grep VERSION_CODENAME /etc/os-release | cut -d= -f2)
echo "→ Adding Docker APT repository for Ubuntu ($CODENAME)..."
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $CODENAME stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "→ Updating package index..."
sudo apt-get update

echo "→ Installing Docker Engine and Docker Compose Plugin..."
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "→ Enabling Docker to start on boot..."
sudo systemctl enable docker

echo "→ Adding current user ($USER) to the docker group..."
echo "→ Adding current user ($USER) to the docker group..."
sudo groupadd docker || true
sudo usermod -aG docker $(logname)
echo -e "\033[1;31mDocker group membership updated. You must log out and log back in to use Docker without sudo.\033[0m"

echo "Testing docker..."
sudo docker run hello-world

echo "Users in docker group"
echo "---------------------"
getent group docker
echo "---------------------"
echo ""

# 5. Clean up
echo "Cleaning up..."
sudo apt autoremove -y
sudo apt autoclean -y

echo -e "\033[1;32m============================="
echo -e "       SCRIPT COMPLETED SUCCESSFULLY   "
echo -e "=============================\033[0m"

echo "Press ENTER to reboot, or any other key to abort..."
read -r -n1 key

if [[ -z "$key" ]]; then
    echo -e "\nRebooting now..."
    sudo reboot
else
    echo -e "\nReboot aborted."
fi


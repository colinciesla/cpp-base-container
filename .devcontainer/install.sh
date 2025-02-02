#!/bin/bash

set -euo pipefail  # Exit on error, unset variables, and pipe failures

# Update and upgrade system packages
sudo apt update -y && sudo apt upgrade -y

# Install required packages
sudo apt install -y \
    git zsh wget curl unzip gdb clang ninja-build build-essential \
    lld clangd g++ python3 pipx 

# Add Kitware repository for newer CMake
sudo mkdir -p /usr/share/keyrings
curl -fsSL https://apt.kitware.com/keys/kitware-archive-latest.asc | \
    gpg --dearmor | sudo tee /usr/share/keyrings/kitware-archive-keyring.gpg > /dev/null
echo 'deb [signed-by=/usr/share/keyrings/kitware-archive-keyring.gpg] https://apt.kitware.com/ubuntu/ noble main' | \
    sudo tee /etc/apt/sources.list.d/kitware.list > /dev/null

# Install CMake
sudo apt update -y
sudo apt install -y cmake

# Cleanup unused packages
sudo apt autoremove -y

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Ensure plugin directories exist
mkdir -p ~/.oh-my-zsh/custom/plugins

# Clone necessary Zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# Install NVM (Node Version Manager)
curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# Install Nerd Fonts
git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git
./nerd-fonts/install.sh Hack FiraCode
rm -rf nerd-fonts  # Cleanup

# Install Oh My Posh
curl -fsSL https://ohmyposh.dev/install.sh | bash
chmod +x ~/.oh-my-posh/bin/oh-my-posh

# Install Powerlevel10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

# Ensure pipx is in the path
pipx ensurepath

# Copy configuration files safely
cp -f .zshrc ~/.zshrc
cp -f .p10k.zsh ~/.p10k.zsh

# Install Conan package manager
pipx install conan

# Change default shell to Zsh (non-interactively)
echo "$USER" | sudo chsh -s /bin/zsh

# Start Zsh
exec zsh

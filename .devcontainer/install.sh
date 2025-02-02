#!/bin/bash

set -euo pipefail  # Exit on error, unset variables, and pipe failures

# Update and upgrade system packages
apt update -y && apt upgrade -y

# Install required packages
apt install -y \
    git zsh wget curl unzip gdb clang ninja-build build-essential \
    lld clangd g++ python3 pipx neovim

# Add Kitware repository for newer CMake
mkdir -p /usr/share/keyrings
curl -fsSL https://apt.kitware.com/keys/kitware-archive-latest.asc | \
    gpg --dearmor | tee /usr/share/keyrings/kitware-archive-keyring.gpg > /dev/null
echo 'deb [signed-by=/usr/share/keyrings/kitware-archive-keyring.gpg] https://apt.kitware.com/ubuntu/ noble main' | \
    tee /etc/apt/sources.list.d/kitware.list > /dev/null

# Install CMake
apt update -y
apt install -y cmake

# Cleanup unused packages
apt autoremove -y

# Install Oh My Zsh
export RUNZSH=no  # Prevents switching to Zsh after install
export CHSH=no    # Skips changing the default shell
sh -c "$(wget -qO- https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended

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
chmod +x ~/.local/bin/oh-my-posh

# Install Powerlevel10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

# Ensure pipx is in the path
pipx ensurepath

# Copy .zshrc
cp -f .zshrc ~/.zshrc

# Install Conan package manager
pipx install conan

# Change default shell to Zsh
chsh -s $(which zsh)

# Start Zsh and start Powerlinke10k configuration
exec zsh

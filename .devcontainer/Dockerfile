FROM mcr.microsoft.com/devcontainers/cpp:1-debian-12

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV NVM_DIR="/root/.nvm"

# Update & Install system packages
RUN apt update -y && apt upgrade -y && \
    apt install -y --no-install-recommends \
    git zsh wget curl unzip gdb clang ninja-build build-essential \
    lld clangd g++ python3 pipx ca-certificates gnupg software-properties-common && \
    rm -rf /var/lib/apt/lists/*

# Add Kitware repository for latest CMake & install it
RUN mkdir -p /usr/share/keyrings && \
    curl -fsSL https://apt.kitware.com/keys/kitware-archive-latest.asc | gpg --dearmor -o /usr/share/keyrings/kitware-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/kitware-archive-keyring.gpg] https://apt.kitware.com/ubuntu/ noble main" | tee /etc/apt/sources.list.d/kitware.list > /dev/null && \
    apt update -y && apt install -y cmake && apt autoremove -y && rm -rf /var/lib/apt/lists/*

# Install Oh My Zsh, Plugins, Powerlevel10k, and Oh My Posh
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || true && \
    mkdir -p ~/.oh-my-zsh/custom/plugins && \
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions && \
    git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting && \
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k && \
    curl -fsSL https://ohmyposh.dev/install.sh | bash && chmod +x ~/.oh-my-posh/bin/oh-my-posh

# Install Nerd Fonts
RUN git clone --depth=1 https://github.com/ryanoasis/nerd-fonts.git && \
    ./nerd-fonts/install.sh Hack FiraCode && rm -rf nerd-fonts

# Install NVM (Node Version Manager) & ensure availability
RUN curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash && . "$NVM_DIR/nvm.sh"

# Install Conan package manager with pipx & ensure path
RUN pipx ensurepath && pipx install conan

# Set Zsh as default shell
SHELL ["/bin/zsh", "-c"]

# Copy configuration files
COPY .zshrc /root/.zshrc

# Set working directory
WORKDIR /root

# Start container in Zsh
CMD ["zsh"]

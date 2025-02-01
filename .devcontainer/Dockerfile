FROM mcr.microsoft.com/devcontainers/cpp:1-debian-12

RUN apt update && apt upgrade && apt-get update && apt-get install -y --no-install-recommends \
  git \
  zsh \
  wget \
  unzip \
  gdb \
  clang \
  ninja-build \
  build-essential \
  lld \
  clangd \
  g++ \
  python3 \
  pipx \
  neovim \
  apt purge --auto-remove cmake \
  wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | sudo tee /usr/share/keyrings/kitware-archive-keyring.gpg >/dev/null \
  echo 'deb [signed-by=/usr/share/keyrings/kitware-archive-keyring.gpg] https://apt.kitware.com/ubuntu/ noble main' | sudo tee /etc/apt/sources.list.d/kitware.list >/dev/null

RUN apt update && apt install -y cmake \
  wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O - | sh \
  chsh -s /bin/zsh \
  zsh \
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions \
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting \
  wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | zsh \
  git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git \
  ./nerd-fonts/install.sh Hack \
  ./nerd-fonts/install.sh FiraCode \
  curl -s https://ohmyposh.dev/install.sh | bash -s \
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" \
  pipx ensurepath

# Copy zsh configuration files
COPY .zshrc /home/colin/.zshrc
COPY .p10k.zsh /home/colin/.p10k.zsh

# Reload zsh and install conan
RUN zsh -l \
  pipx install conan

# Set Clang as the default compiler
ENV CC=clang
ENV CXX=clang++

# Set working directory
WORKDIR /workspace

CMD ["/bin/bash"]

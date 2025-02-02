#==============================================================================
# Powerlevel10k configuration
#==============================================================================
# Enable Powerlevel10k instant prompt. This should remain near the top.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#==============================================================================
# Oh My Zsh configuration
#==============================================================================
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
zstyle ':omz:update' mode auto  # Auto-update Oh My Zsh

# Load plugins
plugins=(
  git
  colored-man-pages
  command-not-found
  zsh-syntax-highlighting
  zsh-autosuggestions
)
source "$ZSH/oh-my-zsh.sh"

#==============================================================================
# User configuration
#==============================================================================
# Preferred editor for local and remote sessions
export EDITOR="${SSH_CONNECTION:+vim}"
export EDITOR="${EDITOR:-nvim}"  # Default to nvim if not in SSH

# nvm configuration
export NVM_DIR="$HOME/.nvm"
if [[ -s "$NVM_DIR/nvm.sh" ]]; then
  source "$NVM_DIR/nvm.sh"
  [[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"
fi

# Configure zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#663399,standout"

#==============================================================================
# Environment Variables
#==============================================================================
export PATH="$HOME/.local/bin:$PATH"
export CC=clang
export CXX=clang++

#==============================================================================
# Aliases
#==============================================================================
alias vim=nvim
alias ls="ls -la --color=auto"

# Load Powerlevel10k configuration
source ~/.oh-my-zsh/custom/themes/powerlevel10k/powerlevel10k.zsh-theme
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

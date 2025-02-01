#==============================================================================
# Powerline10k configuration
#==============================================================================
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#==============================================================================
# zsh configuration
#==============================================================================
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
zstyle ':omz:update' mode auto      # update automatically without asking
# COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
plugins=(git colored-man-pages command-not-found zsh-syntax-highlighting zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
# DISABLE_MAGIC_FUNCTIONS="true"

#==============================================================================
# User configuration
#==============================================================================
# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# nvm config
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#663399,standout"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#==============================================================================
# Export variables
#==============================================================================
export PATH=$PATH:/home/colin/.local/bin
export CC=clang
export CCX=clang++

#==============================================================================
# Aliases
#==============================================================================
alias vim=nvim
alias ls="ls -la --color=auto"

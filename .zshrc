# Source functions file if it exists
[[ -f "$HOME/.zsh_functions" ]] && source "$HOME/.zsh_functions"

# Set oh-my-zsh folder
export ZSH="$HOME/.oh-my-zsh"

# Download oh-my-zsh, if it's not there yet
if [ ! -d "$ZSH" ]; then
   mkdir -p "$(dirname $ZSH)"
   sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --keep-zshrc
fi

# minimal oh-my-zsh setup
ZSH_THEME="robbyrussell"
source $ZSH/oh-my-zsh.sh

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

[[ -f "$HOME/.env" ]] && source "$HOME/.env"

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

zinit ice compile'(typewritten|async).zsh' pick'async.zsh' src'typewritten.zsh'
zinit light reobin/typewritten


zinit load agkozak/zsh-z

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

export PATH="$HOME/Library/Python/3.9/bin:/opt/homebrew/bin:$PATH:"

[[ -f "$HOME/.zsh_aliases" ]] && source "$HOME/.zsh_aliases"

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

eval "$(fzf --zsh)"

export PATH="/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin:$PATH"
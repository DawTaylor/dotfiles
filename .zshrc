export N_PREFIX=/Users/daw/Development/tools/n
export PATH=$PATH:$N_PREFIX/bin:/opt/homebrew/bin:$HOME/Library/Python/3.9/bin
# Source functions file if it exists
[[ -f "$HOME/.zsh_functions" ]] && source "$HOME/.zsh_functions"

eval "$(oh-my-posh init zsh --config=$HOME/.config/ohmyposh/config.toml)"

[[ -f "$HOME/.zsh_aliases" ]] && source "$HOME/.zsh_aliases"
[[ -f "/usr/libexec/java_home" ]] && export JAVA_HOME=$(/usr/libexec/java_home)

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

zinit load agkozak/zsh-z

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'


eval "$(fzf --zsh)"

# Source functions file if it exists
[[ -f "$HOME/.zsh_functions" ]] && source "$HOME/.zsh_functions"

export NVM_DIR="$HOME/.nvm"

# Source these on interactive shell only so AI agents would not pick these up.
if [[ -o interactive ]]; then
   # Set oh-my-zsh folder
   export ZSH="$HOME/.oh-my-zsh"

   # Download oh-my-zsh, if it's not there yet
   if [ ! -d "$ZSH" ]; then
      mkdir -p "$(dirname $ZSH)"
      sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
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

   [[ -f "$HOME/.zsh_aliases" ]] && source "$HOME/.zsh_aliases"

   # Self-managed nvm install for non-Mac (Linux/NixOS). macOS always uses
   # Homebrew's nvm instead (installed via ansible) -- checking whether
   # brew's nvm.sh exists yet would race a fresh ansible bootstrap where
   # .zshrc can get sourced before brew has installed it, so branch on OS
   # rather than on file presence.
   if [[ "$OSTYPE" != darwin* ]] && [ ! -d "$NVM_DIR" ]; then
      git clone -q https://github.com/nvm-sh/nvm.git "$NVM_DIR"
      (cd "$NVM_DIR" && git checkout -q "$(git describe --abbrev=0 --tags --match 'v[0-9]*')")
   fi
fi

export PATH="$HOME/bin:$HOME/Library/Python/3.9/bin:/opt/homebrew/bin:$PATH:"


# macOS: Homebrew's nvm (untouched, existing setup). Everything else: the
# self-managed ~/.nvm install bootstrapped above.
if [[ "$OSTYPE" == darwin* ]]; then
   [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
   [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
else
   [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
   [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
fi

export HOMEBREW_BUNDLE_FIL_GLOBAL=$HOME/.config/brew/Brewfile
export HOMEBREW_BUNDLE_FILE=$HOME/.config/brew/Brewfile

eval "$(fzf --zsh)"

export KUBECONFIG=~/.kube/homelab.yaml
export TALOSCONFIG=~/.talos/homelab.yaml

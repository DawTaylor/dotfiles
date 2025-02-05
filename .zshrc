autoload -Uz compinit
compinit

eval "$(oh-my-posh init zsh --config=$HOME/.config/ohmyposh/config.toml)"

alias c="code ."
alias ls="ls -la"
alias tf="terraform"

export N_PREFIX=/Users/daw/Development/tools/n
export PATH=$PATH:$N_PREFIX/bin:/opt/homebrew/bin

zstyle ':completion:*' menu select

OMP_PLUGIN_DIR="$HOME/.config/ohmyposh/plugins"
ZSH_PLUGIN_DIR="/opt/homebrew/share"

[[ -f "$HOME/.env" ]] && source "$HOME/.env"

if [[ -d "$OMP_PLUGIN_DIR" && -n $(print -l "$OMP_PLUGIN_DIR"/*(N)) ]]; then
  # Source all files in the directory
  for file in "$OMP_PLUGIN_DIR"/*; do
    [[ -f "$file" ]] && source "$file"
  done
fi

if [[ -d "$ZSH_PLUGIN_DIR" && -n $(print -l "$ZSH_PLUGIN_DIR"/zsh-*(N)) ]]; then
  for file in "$ZSH_PLUGIN_DIR"/zsh-*; do
    [[ -f "$file" ]] && source "$file"
    if [[ -d "$file" && $(print -l "$file"/*(N)) ]]; then
      for f in "$file"/*; do
        [[ -f "$f" ]] && source "$f"
      done
    fi
  done
fi

autoload -Uz compinit
compinit

export N_PREFIX=/Users/daw/Development/tools/n
export PATH=$PATH:$N_PREFIX/bin:/opt/homebrew/bin:$HOME/Library/Python/3.9/bin

eval "$(oh-my-posh init zsh --config=$HOME/.config/ohmyposh/config.toml)"

[[ -f "$HOME/.zsh_aliases" ]] && source "$HOME/.zsh_aliases"

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

# Attach to tmux by default
# session_name="default"
# 
# tmux has-session -t=$session_name 2> /dev/null
# 
# if [[ $? -ne 0 ]]; then
#   TMUX='' tmux new-session -d -s "$session_name"
# fi
# 
# if [[ -z "$TMUX" ]]; then
#   tmux attach -t "$session_name"
# else
#   tmux switch-client -t "$session_name"
# fi

# Custom FZF configuration for Zsh

# Set up fzf key bindings and fuzzy completion
if [[ ! "$FZF_LOADED" ]]; then
  eval "$(fzf --zsh)"
  FZF_LOADED=1
fi

# Use fd instead of find
if command -v fd > /dev/null 2>&1; then
  _fzf_compgen_path() {
    fd --hidden --exclude .git . "$1"
  }

  _fzf_compgen_dir() {
    fd --type=d --hidden --exclude .git . "$1"
  }
else
  echo "Warning: 'fd' not found. FZF fuzzy completion will be slower." >&2
fi

# fzf-git integration
source ~/fzf-git.sh/fzf-git.sh

# Setup fzf preview with eza and bat
show_file_or_dir_preview="\
if [ -d {} ]; then \
  eza --tree --color=always {} | head -200; \
else \
  bat -n --color=always --line-range :500 {}; \
fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced fzf completer
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo ${}'" "$@" ;;
    ssh)          fzf --preview 'dig {}' "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

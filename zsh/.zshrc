# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"

# fzf completion and key bindings
eval "$(fzf --zsh)"

# Setting fd as the default source for fzf
export FZF_DEFAULT_COMMAND='fd --type file --follow --hidden \
  --strip-cwd-prefix \
  --exclude .git \
  --exclude node_modules \
  --exclude tmp \
  --exclude coverage \
  --exclude .cache'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

_fzf_compgen_dir() {
  fd --type d --hidden --exclude .git . "$1"
}

# To have paths colored instead of underlined
ZSH_HIGHLIGHT_STYLES[path]='none'

# The next line enables shell command completion for gcloud.
source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"

# aliases
source ~/.aliases

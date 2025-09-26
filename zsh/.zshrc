# Agent detection - only activate minimal mode for actual agents
if [[ -n "$VSCODE_SHELL_INTEGRATION" ]]; then
  POWERLEVEL9K_INSTANT_PROMPT=off

  # Disable complex prompt features for AI agents
  POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
  POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()

  # Ensure non-interactive mode
  export DEBIAN_FRONTEND=noninteractive
  export NONINTERACTIVE=1
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Keyboard bindings and vi-mode corrections
source ~/.keyboard.zsh

# Load FZF configuration
source ~/.fzf.zsh

# --- Load FZF Completion (MUST be before compinit) ---
[[ -f /opt/homebrew/opt/fzf/shell/completion.zsh ]] && source /opt/homebrew/opt/fzf/shell/completion.zsh
[[ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ]] && source /opt/homebrew/opt/fzf/shell/key-bindings.zsh

# Enable completion system
# autoload -Uz compinit
# compinit -C

# History setup
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# Zoxide
eval "$(zoxide init zsh)"

# # Autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Syntax highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Highlight settings
ZSH_HIGHLIGHT_STYLES[path]='none'

# Theme selection - disable only for agents
if [[ -n "$VSCODE_SHELL_INTEGRATION" ]]; then
  ZSH_THEME=""  # Disable Powerlevel10k for agents
else
  # Powerlevel10k theme
  source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
fi

if [[ -n "$VSCODE_SHELL_INTEGRATION" ]]; then
  # minimal prompt for agents
  PROMPT='%n@%m:%~%# '
  RPROMPT=''
  unsetopt CORRECT
  unsetopt CORRECT_ALL
  setopt NO_BEEP
  setopt NO_HIST_BEEP
  setopt NO_LIST_BEEP

  # Agent-friendly aliases
  alias rm='rm -f'
  alias cp='cp -f'
  alias mv='mv -f'
  alias npm='npm --no-fund --no-audit'
  alias yarn='yarn --non-interactive'
  alias pip='pip --quiet'
  alias git='git -c advice.detachedHead=false'
else
  # Powerlevel10k user config
  [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
fi


# Mise
eval "$(mise activate zsh)"

# Aliases
source ~/.aliases

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/qbantek/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/qbantek/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/qbantek/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/qbantek/google-cloud-sdk/completion.zsh.inc'; fi

[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"

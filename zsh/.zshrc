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

chat() {
  curl -s https://api.openai.com/v1/chat/completions \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $OPENAI_API_KEY" \
    -d "{
      \"model\": \"gpt-4.1-mini\",
      \"messages\": [{\"role\": \"user\", \"content\": \"$*\"}]
    }" | jq -r '.choices[0].message.content'
}

# Zoxide
eval "$(zoxide init zsh)"

# # Autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Syntax highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Highlight settings
ZSH_HIGHLIGHT_STYLES[path]='none'

# Powerlevel10k theme
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# Powerlevel10k user config
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Mise
eval "$(mise activate zsh)"

# Aliases
source ~/.aliases

# The next line enables shell command completion for gcloud.
if [ -f '/Users/qbantek/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/qbantek/google-cloud-sdk/completion.zsh.inc'; fi

[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"

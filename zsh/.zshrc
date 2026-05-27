# Claude Code, Codex, and similar agents run one-shot, non-interactive commands
# and may build a snapshot of this shell. Interactive-only setup — the prompt,
# ZLE widgets, fuzzy finders, completions — adds nothing there, bloats the
# snapshot, and some of it emits `can't change option: zle` errors. We gate all
# of that on $AGENT_SHELL below. Essentials that affect command resolution
# (mise, aliases, and PATH/env from .zshenv) always load so agent commands behave
# correctly.
if [[ -n $CLAUDECODE || -n $CODEX_CI || -n $CODEX_SANDBOX || -n $CODEX_THREAD_ID ]]; then
  export AGENT_SHELL=1
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -z $AGENT_SHELL ]]; then
  if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
  fi
fi

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

# Mise — tool versions and PATH; agent shells need this too.
eval "$(mise activate zsh)"

# Aliases (the cd=z alias self-guards for agent shells; see ~/.aliases).
source ~/.aliases

# ----------------------------------------------------------------------------
# Interactive-only setup: prompt, ZLE widgets, fuzzy finders, completions.
# Skipped in agent shells.
# ----------------------------------------------------------------------------
if [[ -z $AGENT_SHELL ]]; then
  # Keyboard bindings and vi-mode corrections
  source ~/.keyboard.zsh

  # Load FZF configuration
  source ~/.fzf.zsh

  # --- Load FZF Completion (MUST be before compinit) ---
  [[ -f /opt/homebrew/opt/fzf/shell/completion.zsh ]] && source /opt/homebrew/opt/fzf/shell/completion.zsh
  [[ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ]] && source /opt/homebrew/opt/fzf/shell/key-bindings.zsh

  # Autosuggestions
  source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

  # Syntax highlighting
  source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  ZSH_HIGHLIGHT_STYLES[path]='none'

  # Powerlevel10k theme + user config
  source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
  [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

  # gcloud shell command completion
  if [ -f '/Users/qbantek/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/qbantek/google-cloud-sdk/completion.zsh.inc'; fi

  # Kiro shell integration
  [[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"

  # Zoxide
  eval "$(zoxide init zsh)"
fi

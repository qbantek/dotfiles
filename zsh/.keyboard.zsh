# --- Set vi-mode ---
set -o vi # Enable vi keybindings
bindkey -v '^?' backward-delete-char # Fix backspace in vi mode

# --- Common extra quality of life ---
# Up/Down arrows search through command history based on current typed text
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# --- (Optional) FZF-specific bindings (uncomment if you want them) ---
# bindkey '^T' fzf-file-widget
bindkey '^O' fzf-cd-widget
# bindkey '^R' fzf-history-widget

# --- Custom nvim file picker ---
bindkey -s '^e' 'nvim $(fzf --border --preview "bat --color=always {}")^M'

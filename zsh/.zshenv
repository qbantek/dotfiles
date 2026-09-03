# set the EDITOR variable to your preferred text editor
export EDITOR='nvim'

# PostgreSQL
export PG17=/opt/homebrew/opt/postgresql@17/bin

# Basic PATH setup
export PATH="$HOME/.local/bin:$PATH"

# Additional common paths
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/bin:$PATH"
export PATH="/bin:$PATH"
export PATH="/usr/sbin:$PATH"
export PATH="/sbin:$PATH"

# Homebrew paths (for Apple Silicon Mac)
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"

# Load local environment variables
[[ -f ~/.zshenv.local ]] && source ~/.zshenv.local

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/qbantek/google-cloud-sdk/path.zsh.inc' ]; then
  . '/Users/qbantek/google-cloud-sdk/path.zsh.inc';
fi
export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"
export PATH="/opt/homebrew/opt/mssql-tools18/bin:$PATH"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/qbantek/.lmstudio/bin"
# End of LM Studio CLI section

# Added by Antigravity
export PATH="/Users/qbantek/.antigravity/antigravity/bin:$PATH"

# nanobrew
export PATH="/opt/nanobrew/prefix/bin:$PATH"

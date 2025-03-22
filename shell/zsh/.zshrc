# Path to dotfiles
export DOTFILES="$HOME/dotfiles"

# History configuration
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY

# Basic zsh settings
setopt AUTO_CD              # cd by typing directory name
setopt INTERACTIVE_COMMENTS # Allow comments in interactive shells
setopt NO_BEEP              # No beep on error

# Load aliases
if [[ -f "$DOTFILES/shell/zsh/aliases.zsh" ]]; then
  source "$DOTFILES/shell/zsh/aliases.zsh"
fi

# Load functions
if [[ -f "$DOTFILES/shell/zsh/functions.zsh" ]]; then
  source "$DOTFILES/shell/zsh/functions.zsh"
fi

# Load NVM if installed
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Initialize starship prompt
if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
fi

# Add homebrew to path
if [[ -d "/opt/homebrew/bin" ]]; then
  export PATH="/opt/homebrew/bin:$PATH"
fi

# Initialize fzf if installed
if command -v fzf &> /dev/null; then
  source <(fzf --zsh)
fi

# Add custom bin directory to path
if [[ -d "$HOME/.local/bin" ]]; then
  export PATH="$HOME/.local/bin:$PATH"
fi

# Add Visual Studio Code to path (if installed)
if [[ -d "/Applications/Visual Studio Code.app/Contents/Resources/app/bin" ]]; then
  export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
fi

# Python settings
export PYTHONDONTWRITEBYTECODE=1  # Don't create .pyc files

# Add any local zsh settings not tracked in git
if [[ -f "$HOME/.zshrc.local" ]]; then
  source "$HOME/.zshrc.local"
fi 
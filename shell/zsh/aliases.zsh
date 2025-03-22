# Navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ~="cd ~"
alias -- -="cd -"

# Shortcuts
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias dev="cd ~/Developer"
alias g="git"
alias h="history"

# List directory contents
if command -v eza &> /dev/null; then
  alias ls="eza"
  alias ll="eza -la"
  alias la="eza -a"
  alias l="eza -l"
  alias lt="eza --tree"
else
  alias ls="ls -G"
  alias ll="ls -la"
  alias la="ls -a"
  alias l="ls -l"
fi

# Better cat
if command -v bat &> /dev/null; then
  alias cat="bat"
fi


# Git shortcuts
alias gs="git status"
alias gc="git commit"
alias gco="git checkout"
alias gl="git log --oneline --decorate --graph"
alias gb="git branch"
alias ga="git add"
alias gd="git diff"
alias gp="git push"
alias gpull="git pull"

# macOS specific
alias showfiles="defaults write com.apple.finder AppleShowAllFiles YES; killall Finder"
alias hidefiles="defaults write com.apple.finder AppleShowAllFiles NO; killall Finder"
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"
alias flushdns="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"

# Utilities
alias ip="curl ifconfig.me"
alias localip="ipconfig getifaddr en0"
alias update="brew update && brew upgrade && brew cleanup"

# Quick edit configs
alias zshrc="$EDITOR ~/.zshrc"
alias dotfiles="cd $DOTFILES"

# Docker shortcuts
alias dps="docker ps"
alias dcu="docker-compose up -d"
alias dcd="docker-compose down"

# Python shortcuts
alias py="python3"
alias pip="pip3"
alias venv="python3 -m venv venv"
alias activate="source venv/bin/activate"

# Node shortcuts
alias ni="npm install"
alias nid="npm install --save-dev"
alias nig="npm install -g"
alias ns="npm start"
alias nt="npm test"
alias nr="npm run" 
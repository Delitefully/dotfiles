# Make a directory and change to it
take() {
  mkdir -p "$@" && cd "$_"
}

# Extract common compression formats
extract() {
  if [ -f "$1" ]; then
    case "$1" in
      *.tar.bz2)   tar xjf "$1"     ;;
      *.tar.gz)    tar xzf "$1"     ;;
      *.bz2)       bunzip2 "$1"     ;;
      *.rar)       unrar e "$1"     ;;
      *.gz)        gunzip "$1"      ;;
      *.tar)       tar xf "$1"      ;;
      *.tbz2)      tar xjf "$1"     ;;
      *.tgz)       tar xzf "$1"     ;;
      *.zip)       unzip "$1"       ;;
      *.Z)         uncompress "$1"  ;;
      *.7z)        7z x "$1"        ;;
      *)           echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}
 
# Create a backup of a file
bak() {
  cp "$1"{,.bak}
}

# Give a quick look at system resources
resources() {
  echo "CPU:\n$(top -l 1 | grep -E "^CPU")"
  echo "\nMemory:\n$(top -l 1 | grep -E "^Phys")"
  echo "\nDisk space:\n$(df -h | grep -E "^/dev")"
}

# Start a simple HTTP server
serve() {
  local port="${1:-8000}"
  python3 -m http.server "$port"
}

# Create a new git repo
ginit() {
  git init
  touch README.md .gitignore
  git add README.md .gitignore
  git commit -m "Initial commit"
}

# Show all colors available in terminal
colors() {
  for i in {0..255}; do
    printf "\x1b[38;5;${i}mcolor ${i}\x1b[0m\n"
  done
} 
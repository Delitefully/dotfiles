#!/bin/bash

# Exit on error
set -e

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Installing dotfiles from $DOTFILES_DIR"

create_symlink() {
  local source="$1"
  local target="$2"
  
  if [ -e "$target" ]; then
    echo "Backing up existing $target to $target.backup"
    mv "$target" "$target.backup"
  fi
  
  echo "Creating symlink: $target -> $source"
  ln -sf "$source" "$target"
}

# macOS specific setup
if [[ "$OSTYPE" == "darwin"* ]]; then
  echo "Setting up macOS configuration..."
  
  # Install Homebrew if it's not already installed
  if ! command -v brew >/dev/null 2>&1; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  
  # Install packages from Brewfile
  echo "Installing Homebrew packages..."
  brew bundle --file="$DOTFILES_DIR/macos/Brewfile"
  
  # Apply macOS defaults
  echo "Applying macOS system preferences..."
  source "$DOTFILES_DIR/macos/defaults.sh"
fi

# Shell configuration
echo "Setting up shell configuration..."
create_symlink "$DOTFILES_DIR/shell/zsh/.zshrc" "$HOME/.zshrc"

# Starship configuration
echo "Setting up Starship prompt..."
mkdir -p "$HOME/.config"
create_symlink "$DOTFILES_DIR/starship/starship.toml" "$HOME/.config/starship.toml"

# Ghostty configuration 
echo "Setting up Ghostty configuration..."
mkdir -p "$HOME/.config/ghostty"
create_symlink "$DOTFILES_DIR/terminal/ghostty/config" "$HOME/.config/ghostty/config"

# Git configuration
echo "Setting up Git configuration..."
create_symlink "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"

echo "Gabriel's dotfiles installation complete!" 
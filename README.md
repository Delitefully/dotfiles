# Dotfiles

Configuration files for my work + personal setups.

## Structure

- `macos/` - macOS specific configurations
  - `Brewfile` - Homebrew packages and apps
  - `defaults.sh` - macOS system preferences
- `shell/` - Shell configurations
  - `.zshrc` - Main zsh config
  - `aliases.zsh` - Shell aliases
  - `functions.zsh` - Shell functions
- `starship/` - Starship prompt configs
- `terminal/` - Terminal configurations
  - `ghostty/` - Ghostty config files
- `git/` - Git configurations

## Installation

```bash
# Clone the repository
git clone https://github.com/delitefully/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Run the installation script
./install.sh
```

## What it sets up

- Installs command-line tools and applications via Homebrew
- Configures macOS system preferences
- Sets up Zsh configuration with custom aliases and functions
- Configures terminal appearance and behavior (using Ghostty)
- Sets up Starship prompt
- Configures Git settings

## License

MIT 
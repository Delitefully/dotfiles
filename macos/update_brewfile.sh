#!/bin/bash

# Script to check for new Homebrew packages and append them to Brewfile

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
BREWFILE="$DOTFILES_DIR/macos/Brewfile"
TEMP_BREWFILE="$DOTFILES_DIR/macos/Brewfile.temp"
NEW_BREWFILE="$DOTFILES_DIR/macos/Brewfile.new"

# Check if Brewfile exists
if [ ! -f "$BREWFILE" ]; then
  echo "Brewfile not found. Creating a new one..."
  brew bundle dump --file="$BREWFILE"
  echo "Done! Brewfile created at $BREWFILE"
  exit 0
fi

echo "Checking for Homebrew updates..."
brew update

echo "Generating current package list..."
brew bundle dump --file="$TEMP_BREWFILE" --force

# Extract taps, brews, and casks from both files
extract_packages() {
  local file=$1
  local type=$2
  if [ "$type" = "tap" ]; then
    grep "^tap " "$file" | sed 's/^tap //' | tr -d '"' | sort
  elif [ "$type" = "brew" ]; then
    grep "^brew " "$file" | awk '{print $2}' | tr -d '"' | sort
  elif [ "$type" = "cask" ]; then
    grep "^cask " "$file" | awk '{print $2}' | tr -d '"' | sort
  fi
}

# Find new packages
find_new_packages() {
  local type=$1
  comm -13 <(extract_packages "$BREWFILE" "$type") <(extract_packages "$TEMP_BREWFILE" "$type")
}

NEW_TAPS=$(find_new_packages "tap")
NEW_BREWS=$(find_new_packages "brew")
NEW_CASKS=$(find_new_packages "cask")

if [ -z "$NEW_TAPS" ] && [ -z "$NEW_BREWS" ] && [ -z "$NEW_CASKS" ]; then
  echo "No new packages detected. Your Brewfile is up to date."
  rm "$TEMP_BREWFILE"
  exit 0
fi

# Display new packages
echo "New packages detected:"
echo "---------------------"
if [ -n "$NEW_TAPS" ]; then
  echo "New taps:"
  echo "$NEW_TAPS" | sed 's/^/  /'
fi

if [ -n "$NEW_BREWS" ]; then
  echo "New formulae:"
  echo "$NEW_BREWS" | sed 's/^/  /'
fi

if [ -n "$NEW_CASKS" ]; then
  echo "New casks:"
  echo "$NEW_CASKS" | sed 's/^/  /'
fi

# Ask user what to do
read -p "Would you like to add these new packages to your Brewfile? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  echo "No changes made to your Brewfile."
  rm "$TEMP_BREWFILE"
  exit 0
fi

# Append new packages to the existing Brewfile
cp "$BREWFILE" "$NEW_BREWFILE"

# Check if "Other" section already exists
if ! grep -q "^# Other$" "$NEW_BREWFILE"; then
  echo -e "\n# Other" >> "$NEW_BREWFILE"
fi

# Append new taps
if [ -n "$NEW_TAPS" ]; then
  echo -e "\n# New taps added on $(date +%Y-%m-%d)" >> "$NEW_BREWFILE"
  while IFS= read -r tap; do
    echo "tap \"$tap\"" >> "$NEW_BREWFILE"
  done <<< "$NEW_TAPS"
fi

# Append new brews
if [ -n "$NEW_BREWS" ]; then
  echo -e "\n# New formulae added on $(date +%Y-%m-%d)" >> "$NEW_BREWFILE"
  while IFS= read -r formula; do
    echo "brew \"$formula\"" >> "$NEW_BREWFILE"
  done <<< "$NEW_BREWS"
fi

# Append new casks
if [ -n "$NEW_CASKS" ]; then
  echo -e "\n# New casks added on $(date +%Y-%m-%d)" >> "$NEW_BREWFILE"
  while IFS= read -r cask; do
    echo "cask \"$cask\"" >> "$NEW_BREWFILE"
  done <<< "$NEW_CASKS"
fi

# Replace the old Brewfile with the new one
mv "$NEW_BREWFILE" "$BREWFILE"
rm "$TEMP_BREWFILE"

echo "Brewfile updated successfully with new packages added to the 'Other' section."
echo "Manually organize these packages into the appropriate categories."
echo "Done!" 
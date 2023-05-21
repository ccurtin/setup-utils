#!/bin/bash

autoload_nvmrc() {
  nvmrc_file=".nvmrc"
  nvmrc_path=$(nvm_find_nvmrc)

  if [[ -f "$nvmrc_path" ]]; then
    node_version=$(cat "$nvmrc_path")
    if ! grep -q "autoload_nvmrc" "$1"; then
      echo "autoload_nvmrc() {
  nvm use \"$node_version\"
}" >> "$1"
      echo "autoload_nvmrc has been added to $1."
    else
      echo "autoload_nvmrc already exists in $1."
    fi
  else
    echo ".nvmrc file not found."
  fi
}

case "$TERM_PROGRAM" in
  Apple_Terminal)
    autoload_nvmrc "$HOME/.bash_profile"
    ;;
  gnome-terminal)
    autoload_nvmrc "$HOME/.bashrc"
    ;;
  Hyper)
    autoload_nvmrc "$HOME/.hyper.js"
    ;;
  iTerm.app)
    autoload_nvmrc "$HOME/.zshrc"
    ;;
  terminator)
    autoload_nvmrc "$HOME/.config/terminator/config"
    ;;
  zsh)
    autoload_nvmrc "$HOME/.zshrc"
    ;;
  bash)
    autoload_nvmrc "$HOME/.bashrc"
    ;;
  fish)
    autoload_nvmrc "$HOME/.config/fish/config.fish"
    ;;
  *)
    echo "Unknown terminal. Please check your terminal configuration file manually."
    ;;
esac

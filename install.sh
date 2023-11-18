#!/bin/bash

# This script installs all the necessary dependencies after a fresh WSL
# installation.
#
# by Christian Deme
#
# TODO: Add conditions and checks if dependency is already installed, in that case skip
# TODO: Add asdf to used plugins for zsh

# Install useful packages for Ubuntu, can avoid errors
sudo apt install build-essential libssl-dev unzip zlib1g-dev libffi-dev libyaml-dev readline-common libedit-dev lzma

# Add .bash_aliases
touch ~/.bash_aliases

# Install oh-my-zsh
sudo apt install zsh -y
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)

# Install neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
sudo mv nvim.appimage /usr/local/bin/nvim

# Install asdf-vm
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.13.1

# Install all required asdf packages
packages=("ruby" "python" "rust" "tmux" "bat" "nodejs" "golang")

for package in "${packages[@]}"
do
  asdf plugin add $package
  asdf install $package latest
  asdf global $package latest
done

asdf reshim

# Use LazyVim as base for nvim
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git


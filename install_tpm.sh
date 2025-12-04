#!/bin/bash

# Stow configs
cd ~/dotfiles
stow tmux

# Install TPM if not exists
if [ ! -d ~/.tmux/plugins/tpm ]; then
    echo "Installing TPM..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

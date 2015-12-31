#!/bin/sh

if [ ! -d "$HOME/.dotfile" ]; then
  echo "Installing dotfile"
  git clone --depth=1 https://github.com/vinioliveira/dotfiles.git "$HOME/.dotfiles"
  cd "$HOME/.dotfiles"
  # [ "$1" = "ask" ] && export ASK="true"
  rake install
else
  echo "YADR is already installed"
fi

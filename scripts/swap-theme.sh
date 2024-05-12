#!/usr/bin/env bash
ALACRITTY_CONFIG_BASEPATH=~/.dotfiles/config/alacritty
NVIM_CONFIG_BASEPATH=~/.dotfiles/nvim

ARG=$1

if [[ $ARG != "light" && $ARG != "dark" && $ARG != "toggle" ]]; then
  echo "Not a valid option"
  exit 1
fi


if [[ $ARG = "toggle" ]]; then
  if cmp -s $ALACRITTY_CONFIG_BASEPATH/alacritty.toml $ALACRITTY_CONFIG_BASEPATH/alacritty.light.toml; then
    ARG="dark"
  else
    ARG="light"
  fi
fi

echo "Changing theme to $ARG"

if [[ -L $NVIM_CONFIG_BASEPATH/init.lua ]]; then
  rm $NVIM_CONFIG_BASEPATH/init.lua
fi

if [[ -f $ALACRITTY_CONFIG_BASEPATH/alacritty.toml ]]; then
  rm $ALACRITTY_CONFIG_BASEPATH/alacritty.toml
fi

if [[ $ARG = "light" ]]; then
  # ln -s $ALACRITTY_CONFIG_BASEPATH/alacritty.light.toml $ALACRITTY_CONFIG_BASEPATH/alacritty.toml
  ln -s $NVIM_CONFIG_BASEPATH/init.light.lua $NVIM_CONFIG_BASEPATH/init.lua
  cp $ALACRITTY_CONFIG_BASEPATH/alacritty.light.toml $ALACRITTY_CONFIG_BASEPATH/alacritty.toml
elif [[ $ARG = "dark" ]]; then
  # ln -s $ALACRITTY_CONFIG_BASEPATH/alacritty.dark.toml $ALACRITTY_CONFIG_BASEPATH/alacritty.toml
  ln -s $NVIM_CONFIG_BASEPATH/init.dark.lua $NVIM_CONFIG_BASEPATH/init.lua
  cp $ALACRITTY_CONFIG_BASEPATH/alacritty.dark.toml $ALACRITTY_CONFIG_BASEPATH/alacritty.toml
fi



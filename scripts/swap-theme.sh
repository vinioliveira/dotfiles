#!/usr/bin/env bash
ALACRITTY_CONFIG_BASEPATH=~/.dotfiles/config/alacritty
NVIM_CONFIG_BASEPATH=~/.dotfiles/nvim

ARG=$1

if [[ $ARG != "light" && $ARG != "dark" && $ARG != "toggle" ]]; then
  echo "Not a valid option"
  exit 1
fi


if [[ $ARG = "toggle" ]]; then
  if cmp -s $ALACRITTY_CONFIG_BASEPATH/alacritty.yml $ALACRITTY_CONFIG_BASEPATH/alacritty.light.yml; then
    ARG="dark"
  else
    ARG="light"
  fi
fi

echo "Changing theme to $ARG"

if [[ -L $NVIM_CONFIG_BASEPATH/init.lua ]]; then
  rm $NVIM_CONFIG_BASEPATH/init.lua
fi

if [[ -f $ALACRITTY_CONFIG_BASEPATH/alacritty.yml ]]; then
  rm $ALACRITTY_CONFIG_BASEPATH/alacritty.yml
fi

if [[ $ARG = "light" ]]; then
  # ln -s $ALACRITTY_CONFIG_BASEPATH/alacritty.light.yml $ALACRITTY_CONFIG_BASEPATH/alacritty.yml
  ln -s $NVIM_CONFIG_BASEPATH/init.light.lua $NVIM_CONFIG_BASEPATH/init.lua
  cp $ALACRITTY_CONFIG_BASEPATH/alacritty.light.yml $ALACRITTY_CONFIG_BASEPATH/alacritty.yml
elif [[ $ARG = "dark" ]]; then
  # ln -s $ALACRITTY_CONFIG_BASEPATH/alacritty.dark.yml $ALACRITTY_CONFIG_BASEPATH/alacritty.yml
  ln -s $NVIM_CONFIG_BASEPATH/init.dark.lua $NVIM_CONFIG_BASEPATH/init.lua
  cp $ALACRITTY_CONFIG_BASEPATH/alacritty.dark.yml $ALACRITTY_CONFIG_BASEPATH/alacritty.yml
fi



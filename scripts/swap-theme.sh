#!/usr/bin/env bash


# this script will receive a string as argument, that string can be "light" or "dark" or "toggle"
# if the string is "light" it will change the theme to light
# if the string is "dark" it will change the theme to dark
# if the string is "toggle" it will change the theme to the opposite of the current theme

# it needs to change alacritty and nvim config files both files will have two alternative files with the extensions of .light and .dark
# the script will replace the current config file with the alternative file depending on the argument received
# say we receive "light" as argument, the script will replace the current config file with the .light file


ALACRITTY_CONFIG_BASEPATH=~/.dotfiles/config/alacritty
NVIM_CONFIG_BASEPATH=~/.dotfiles/nvim

ARG=$1

# if arg is not a valid option, echo Not a valid option and exit
if [[ $ARG != "light" && $ARG != "dark" && $ARG != "toggle" ]]; then
  echo "Not a valid option"
  exit 1
fi


if [[ $ARG = "toggle" ]]; then
  # compare current config with the light config
  # if they are the same, change to dark otherwise change to light
  if cmp -s $ALACRITTY_CONFIG_BASEPATH/alacritty.yml $ALACRITTY_CONFIG_BASEPATH/alacritty.light.yml; then
    ARG="dark"
  else
    ARG="light"
  fi
fi

echo "Changing theme to $ARG"


# remove symlink if it exists
if [[ -L $NVIM_CONFIG_BASEPATH/init.lua ]]; then
  rm $NVIM_CONFIG_BASEPATH/init.lua
fi

# if file exists delete it
if [[ -f $ALACRITTY_CONFIG_BASEPATH/alacritty.yml ]]; then
  rm $ALACRITTY_CONFIG_BASEPATH/alacritty.yml
fi

if [[ $ARG = "light" ]]; then
  # create a symlink to the light config
  # ln -s $ALACRITTY_CONFIG_BASEPATH/alacritty.light.yml $ALACRITTY_CONFIG_BASEPATH/alacritty.yml
  ln -s $NVIM_CONFIG_BASEPATH/init.light.lua $NVIM_CONFIG_BASEPATH/init.lua
  cp $ALACRITTY_CONFIG_BASEPATH/alacritty.light.yml $ALACRITTY_CONFIG_BASEPATH/alacritty.yml
elif [[ $ARG = "dark" ]]; then
  # ln -s $ALACRITTY_CONFIG_BASEPATH/alacritty.dark.yml $ALACRITTY_CONFIG_BASEPATH/alacritty.yml
  ln -s $NVIM_CONFIG_BASEPATH/init.dark.lua $NVIM_CONFIG_BASEPATH/init.lua
  cp $ALACRITTY_CONFIG_BASEPATH/alacritty.dark.yml $ALACRITTY_CONFIG_BASEPATH/alacritty.yml
fi



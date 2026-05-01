#!/usr/bin/env bash
# Auto-sync tmux catppuccin flavor with macOS system appearance.
# Designed to be called from a tmux hook (client-focus-in).

STATE_FILE="${HOME}/.cache/tmux-flavor"

APPEARANCE=$(defaults read -g AppleInterfaceStyle 2>/dev/null || echo "Light")

if [[ "$APPEARANCE" == "Dark" ]]; then
  FLAVOR="mocha"
else
  FLAVOR="latte"
fi

CURRENT=$(cat "$STATE_FILE" 2>/dev/null)

if [[ "$FLAVOR" == "$CURRENT" ]]; then
  exit 0
fi

echo "$FLAVOR" > "$STATE_FILE"

tmux set -g @catppuccin_flavor "$FLAVOR"

# Match the exact ghostty theme background so window pill separators blend correctly:
# dark = Flexoki Dark (#100f0f), light = cyberdream-light (#ffffff)
if [[ "$FLAVOR" == "mocha" ]]; then
  tmux set -g @catppuccin_status_background "#100f0f"
else
  tmux set -g @catppuccin_status_background "#ffffff"
fi

# Catppuccin uses `set -ogq` (only-if-not-set) for all palette and module color
# variables, so they must be unset before re-running the plugin or the old
# theme's colors will persist.

# Palette variables
for var in @thm_bg @thm_fg @thm_rosewater @thm_flamingo @thm_pink @thm_mauve \
           @thm_red @thm_maroon @thm_peach @thm_yellow @thm_green @thm_teal \
           @thm_sky @thm_sapphire @thm_blue @thm_lavender @thm_subtext_1 \
           @thm_subtext_0 @thm_overlay_2 @thm_overlay_1 @thm_overlay_0 \
           @thm_surface_2 @thm_surface_1 @thm_surface_0 @thm_mantle @thm_crust; do
  tmux set -gu "$var"
done

# Module fg/bg variables (built with -ogq, so also need clearing)
for var in $(tmux show -g | awk '/^@catppuccin_status_.*_(fg|bg)/ {print $1}'); do
  tmux set -gu "$var"
done

tmux run-shell ~/.tmux/plugins/tmux/catppuccin.tmux
tmux refresh-client -S

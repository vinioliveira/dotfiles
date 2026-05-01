#!/usr/bin/env bash
# Background watcher: polls macOS appearance and updates tmux theme when it changes.
# Manages its own PID file so only one instance runs per tmux server.

PID_FILE="${HOME}/.cache/tmux-theme-watcher.pid"
STATE_FILE="${HOME}/.cache/tmux-flavor"

# Kill any existing watcher
if [[ -f "$PID_FILE" ]]; then
  old_pid=$(cat "$PID_FILE")
  if kill -0 "$old_pid" 2>/dev/null; then
    kill "$old_pid"
  fi
fi

echo $$ > "$PID_FILE"

trap 'rm -f "$PID_FILE"; exit' EXIT TERM INT

while true; do
  APPEARANCE=$(defaults read -g AppleInterfaceStyle 2>/dev/null || echo "Light")

  if [[ "$APPEARANCE" == "Dark" ]]; then
    FLAVOR="mocha"
  else
    FLAVOR="latte"
  fi

  CURRENT=$(cat "$STATE_FILE" 2>/dev/null)

  if [[ "$FLAVOR" != "$CURRENT" ]]; then
    ~/.dotfiles/scripts/tmux-theme-check.sh
  fi

  sleep 2
done

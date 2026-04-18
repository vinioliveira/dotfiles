
# bg matches terminal background (#161719) so bar blends in
set -g status-style fg=colour6,bg=#161719

# Window with activity status
set -g window-status-activity-style bg=#161719,fg=colour5

# Window separator
set -g window-status-separator ""

# Window status alignment
set -g status-justify centre

# Pane border
set -g pane-border-style bg=default,fg=colour0
set -g pane-active-border-style bg=default,fg=colour6

# Pane number indicator
set -g display-panes-colour default
set -g display-panes-active-colour default

# Clock mode
set -g clock-mode-colour colour6
set -g clock-mode-style 24

# Command message
set -g message-command-style bg=#161719,fg=colour6
set -g message-style bg=#161719,fg=colour6

# Inactive windows
set -g window-status-format "#[fg=colour8,bg=#161719] #I. #W "
set -g window-status-style fg=colour8,bg=#161719

# Active window — blue pill
set -g window-status-current-format "#[fg=colour6,bg=#161719]\ue0b6#[fg=#161719,bg=colour6] #I. #W #[fg=colour6,bg=#161719]\ue0b4"
set -g window-status-current-style bg=colour6,fg=#161719

# Left: session pill (blue) + window/pane numbers
set -g status-left-length 60
set -g status-left "#[fg=colour6,bg=#161719]\ue0b6#[bg=colour6,fg=#161719] #S #[fg=colour6,bg=#161719]\ue0b4"

# Right: cpu (purple pill) + time (blue pill)
set -g status-right-length 60
set -g status-right "#[fg=colour5,bg=#161719]\ue0b6#[bg=colour5,fg=#161719] #{cpu_icon} #{cpu_percentage} #[fg=colour6,bg=colour5]\ue0b6#[bg=colour6,fg=#161719] %H:%M #[fg=colour6,bg=#161719]\ue0b4"

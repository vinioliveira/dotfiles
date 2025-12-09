
# Window with activity status
set -g window-status-activity-style bg=colour0,fg=colour5

# Window separator
set -g window-status-separator ""

# Window status alignment
set -g status-justify centre
set -g status-style fg=colour6,bg=colour0

# Pane border
set -g pane-border-style bg=default,fg=colour8

#set -g pane-border-bg colour0
#set -g pane-active-border-bg colour0

# Active pane border
set -g pane-active-border-style bg=default,fg=colour15

# Pane number indicator
set -g display-panes-colour default
set -g display-panes-active-colour default

# Clock mode
set -g clock-mode-colour red
set -g clock-mode-style 24

# Message
# set -g message-bg default
# set -g message-fg default

# Command message
set -g message-command-style bg=default,fg=default

# Mode
set -g mode-style bg=colour0,fg=default


set -g @now-playing-playing-icon "♫"
set -g @now-playing-scrollable-threshold 20
set -g @now-playing-status-format "#[bg=colour0]#[fg=colour6]#[bg=colour6]#[fg=colour0]{icon} {scrollable}"

# # Window status
set -g window-status-format " #I. #W "
set -g window-status-style fg=colour6,bg=default

set -g status-left-length 60
# set -g status-left "#[fg=colour6]\ue0b6#[bg=colour6]#[fg=colour0] #S #[fg=colour6]#[bg=colour0]#[bg=colour0]#[fg=colour6] #I #[fg=colour7]#P #[fg=colour0]#[bg=default]"
set -g status-left "#[fg=colour6]\ue0b6#[bg=colour6]#[fg=colour0] #S #[fg=colour6]#[bg=colour0]#[bg=colour0]#[fg=colour6] #I #[fg=colour7]#P "

# Right side of status bar
set -g status-right-length 60
set -g status-right "#[fg=colour13]#[bg=colour13]#[fg=colour0] #{cpu_icon} #{cpu_percentage} #[bg=colour13]#[fg=colour6]#[bg=colour6]#[fg=colour0] %H:%M#[bg=colour0]#[fg=colour6]\ue0b4"

set -g window-status-current-format "#[fg=colour6]#[bg=colour0]#[bg=colour6]#[fg=colour0] #I. #W #[fg=colour0]#[bg=colour6]"
set -g window-status-current-style bg=colour6,fg=colour0

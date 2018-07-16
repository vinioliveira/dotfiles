set -g status-bg colour233

set-option -g status-bg colour237 #bg1
set-option -g status-fg colour223 #fg1

# Left side of status bar
set -g status-left-bg colour237
set -g status-left-fg green
set -g status-left-length 40
set -g status-left "#S #[fg=white]» #[fg=yellow]#I #[fg=cyan]#P"

# Right side of status bar

set -g status-right-bg colour237
set -g status-right-fg cyan
set -g status-right-length 140
set -g status-right '#(eval ~/.dotfiles/tmux/tmux-airline.tmux `tmux display -p "#{client_width}"`)'
# set -g status-right "#H #[fg=white]« #[fg=yellow]%H:%M:%S #[fg=green]%d-%b-%y"

# Window status
set -g window-status-format " #I:#W "
set -g window-status-current-format " #I:#W "

# Current window status
set -g window-status-current-bg colour208
set -g window-status-current-fg colour237

# Window with activity status
set -g window-status-activity-bg yellow # fg and bg are flipped here due to a
set -g window-status-activity-fg colour237  # bug in tmux

# Window separator
set -g window-status-separator ""

# Window status alignment
set -g status-justify centre

# Pane border
set -g pane-border-bg default
set -g pane-border-fg colour237

#set -g pane-border-bg colour237
#set -g pane-active-border-bg colour0

# Active pane border
set -g pane-active-border-bg default
set -g pane-active-border-fg green

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
set -g message-command-bg default
set -g message-command-fg default

# Mode
set -g mode-bg red
set -g mode-fg default

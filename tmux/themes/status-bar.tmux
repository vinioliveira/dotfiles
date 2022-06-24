
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
set -g pane-active-border-style bg=default,fg=colour11

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
set -g mode-style bg=red,fg=default



# # Window status
set -g window-status-format " #I. #W "
set -g window-status-style fg=colour6,bg=colour0

set -g status-left "#[bg=colour6]#[fg=colour0] #S #[fg=colour6]#[bg=colour0]#[bg=colour0]#[fg=colour6] #I #[fg=colour7]#P #[fg=colour0]#[bg=colour0]"
# set -g status-left-style bg=colour0,fg=colour6
# set -g status-left-length 40
##
# Right side of status bar
set -g status-right '#(eval ~/.dotfiles/tmux/tmux-airline.tmux `tmux display -p "#{client_width}"`)'
# set -g status-right-style fg=colour6,bg=colour0
# set -g status-right-length 140
#
set -g window-status-current-format "#[fg=colour6]#[bg=colour237]#[bg=colour6]#[fg=colour0] #I. #W #[fg=colour237]#[bg=colour6]"
set -g window-status-current-style bg=colour6,fg=colour0

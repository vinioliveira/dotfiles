#!/usr/bin/env bash
tmux neww -n "servers" \; split-window -v \; select-pane -t 1 \; split-window -h


###### Current Laytout #######
# -------------------------- #
# |          |             | #
# |    1     |     2       | #
# |----------|-------------| #
# |                        | #
# |                        | #
# |          3             | #
# |                        | #
# -------------------------- #
##############################

tmux select-pane -t 1
tmux resize-pane -U 25
tmux send-keys  -t 1 "pn start:webapp" C-m
tmux send-keys  -t 2 "pn start:admin"
tmux send-keys  -t 3 "pn start:api" C-m

#!/usr/bin/env bash
tmux neww -n "servers" \; split-window -v \; split-window -h \; select-pane -t 1 \; split-window -h

tmux send-keys  -t 1 "pn start:webapp" C-m
tmux send-keys  -t 2 "pn start:api" C-m
# tmux send-keys  -t 3 "npr datastore" C-m



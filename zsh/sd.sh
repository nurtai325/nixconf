#!/bin/env bash

# script for changing current tmux session to another directory in $selected

selected=$(find $HOME/nixconf $HOME/work $HOME/personal $HOME/contest $HOME/learn -maxdepth 1 -type d,l | fzf);

if [ -z "$selected" ]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)

if ! tmux has-session -t "$selected_name" 2> /dev/null; then
    tmux new-session -s $selected_name -c $selected -d;
fi

if ! tmux switch-client -t $selected_name; then
    tmux a -t $selected_name;
fi

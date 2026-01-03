#!/bin/env bash

# script for changing current tmux session to another directory in $selected

selected=$(find $HOME -maxdepth 2 -type d,l | rg -v '\/\.[^/]+' | fzf);

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

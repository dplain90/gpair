#!/bin/bash

root_git_directory=$(git rev-parse --show-toplevel)

current_pair_file="$root_git_directory/.current-pair"

if [ ! -f $current_pair_file ]; then
    echo "No pair set."
fi

read -r current_pair < $current_pair_file

echo $current_pair
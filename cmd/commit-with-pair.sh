#!/bin/bash

commit_message=$1
other_args=$(echo "${@:2}")

root_git_directory=$(git rev-parse --show-toplevel)

current_pair_file="$root_git_directory/.current-pair"

if [ ! -f $current_pair_file ]; then
    echo "  No pair has been set. You can set your pair with the following command:\n  git set <initials>\n  EX: git set dp"
fi

read -r current_pair < $current_pair_file

full_commit_message=$(echo -e "$commit_message\n\nCoauthored by $current_pair")

git commit -m "$full_commit_message" $other_args
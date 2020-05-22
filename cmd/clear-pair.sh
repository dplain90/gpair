#!/bin/bash

root_git_directory=$(git rev-parse --show-toplevel)

current_pair_path="$root_git_directory/.current-pair"
rm "$current_pair_path"

echo "Success! Current pair has been cleared."
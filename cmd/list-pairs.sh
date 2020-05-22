#!/bin/bash

root_git_directory=$(git rev-parse --show-toplevel)

pair_file="$root_git_directory/.pairs"

if [ ! -f $pair_file ]; then
    echo "Cannot find pairs file. Make sure .pairs file is in the root directory of the repository."
fi


while IFS= read -r author
do
  IFS=';' read -ra author_attr <<< "$author"
  pair_initials="${author_attr[0]}"
  pair_name="${author_attr[1]}"
  pair_email="${author_attr[2]}"

  echo -e "  $pair_initials: $pair_name <$pair_email>"
done < "$pair_file"
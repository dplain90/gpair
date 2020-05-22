#!/bin/bash

current_pair_initial=$1

root_git_directory=$(git rev-parse --show-toplevel)

pair_file="$root_git_directory/.pairs"
current_pair_file="$root_git_directory/.current-pair"

if [ ! -f $pair_file ]; then
    echo "Cannot find pairs file. Make sure .pairs file is in the root directory of the repository."
fi


found_pair_match=false
while IFS= read -r line
do
  IFS=';' read -ra author_attr <<< "$line"
  if [ ${author_attr[0]} == $current_pair_initial ]
  then
    found_pair_match=true
    pair_name="${author_attr[1]}"
    pair_email="${author_attr[2]}"
    
    if [ -f $current_pair_file ]; then
        rm $current_pair_file
    fi

    echo "$pair_name <$pair_email>" > "$PWD/.current-pair"
  fi
done < "$pair_file"

if [ $found_pair_match = false ]
then
  echo -e "\n  Sorry! No pair match found for $current_pair_initial."
  echo -e "  Check .pairs file to make sure this person has been added.\n"
else
  echo -e "\n  Success! $pair_name <$pair_email> set as pair.\n"
fi
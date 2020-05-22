#!/bin/bash

current_pair_initial=$1

input="/Users/stride-admin/Code/git-coauthor-commit/.pairs"

while IFS= read -r line
do
  IFS=';' read -ra author_attr <<< "$line"
  if [ ${author_attr[0]} == $current_pair_initial ]
  then
    echo "${author_attr[1]} <${author_attr[2]}>" > "/Users/stride-admin/Code/git-coauthor-commit/current-pair.txt"
  fi
done < "$input"
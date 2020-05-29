#!/bin/bash

source $GPAIR_CONSTANTS_PATH
source $GPAIR_OUTPUTS_PATH
source $GPAIR_UTILS_PATH

echo-remove-pair-author-usage() {
  echo -e "\n $(output::bold::green " USAGE:") gpair remove <initials> [options]\n"
  echo -e "   Removes author from pairs list.\n"
  echo -e " $(output::bold::green "[OPTIONS]:")\n"
  echo -e "   $(output::help_flag "-h" "--help")        Print usage information\n"
}

while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -h|--help)
    echo-remove-pair-author-usage
    exit 0
    ;;
    *)
    if [ -z "$current_pair_initial" ]; then
      remove_pair_initials=$1
      shift
    else
      invalid_args+=("$1") # save it in an array for later
      shift # past argument
      shift # past value
    fi
    ;;
esac
done

handle-invalid-args echo-remove-pair-author-usage $invalid_args

if [ ! -f $GPAIR_PAIRS_PATH ]; then
    echo "Cannot find pairs file. Make sure .pairs file is in the root directory of the repository."
fi

while IFS= read -r author
do
  
  if [[ $author =~ $GPAIR_AUTHOR_LINE_REGEX ]]
  then
      pair_initials="${BASH_REMATCH[1]}"
      if [[ $remove_pair_initials == $pair_initials ]]
      then
        remove_pair_name="${BASH_REMATCH[2]}"
        remove_pair_email="${BASH_REMATCH[3]}"
      fi
  fi

done < "$GPAIR_PAIRS_PATH"

if [[ $remove_pair_name ]]; then
  remove_pair_cmd="/\[$remove_pair_initials\]/d"
  sed -i '' $remove_pair_cmd $GPAIR_PAIRS_PATH  

  echo -e "\n $(output::bold::green "Complete!")\n [$remove_pair_initials]: $remove_pair_name <$remove_pair_email> has been removed\n"
else
  echo -e "\n $(output::bold::red "Error!")\n Could not find pair with initials $(output::bold::yellow $remove_pair_initials)\n"
fi

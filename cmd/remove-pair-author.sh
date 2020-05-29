#!/bin/bash

source $GPAIR_CONSTANTS_PATH
source $GPAIR_OUTPUTS_PATH
source $GPAIR_UTILS_PATH

echo-remove-pair-author-usage() {
  echo -e "\n $(output::bold::green " USAGE:") gpair pair [options]\n"
  echo -e " Show current pair information.\n"
  echo -e " $(output::bold::green "[OPTIONS]:")\n"
  echo -e "   $(output::help_flag "-h" "--help")        Print usage information\n"
}

while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -h|--help)
    echo-set-pair-usage
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

line_number=1
removal_line_number=0
while IFS= read -r author
do
  
  if [[ $author =~ $GPAIR_AUTHOR_LINE_REGEX ]]
  then
      pair_initials="${BASH_REMATCH[1]}"
      echo $pair_initials
      if [[ $remove_pair_initials == $pair_initials ]]
      then
        remove_pair_name="${BASH_REMATCH[2]}"
        remove_pair_email="${BASH_REMATCH[3]}"
        removal_line_number=$line_number
      fi
  fi

  line_number=$((line_number + 1))
done < "$GPAIR_PAIRS_PATH"
echo 
if [ $removal_line_number -gt 0 ]; then
  echo $removal_line_number
  sed '3d' $GPAIR_PAIRS_PATH
  echo -e "Success! $remove_pair_name <$remove_pair_email> has been added with the initials $remove_pair_initials"
else
  echo -e "Could not find pair with initials $remove_pair_initials"
fi

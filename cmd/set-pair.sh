#!/bin/bash

source $GPAIR_CONSTANTS_PATH
source $GPAIR_OUTPUTS_PATH
source $GPAIR_UTILS_PATH
echo-set-pair-usage() {
  echo -e "\n $(output::bold::green " USAGE:") gpair set <initials> [options] \n"
  echo -e " Sets your current pair.\n"
  echo -e " $(output::bold::green "[OPTIONS]:")\n"
  echo -e "   $(output::help_flag "-h" "--help")        Print usage information"
  echo -e "\n $(output::bold::green " EXAMPLE:") $(output::bold::cyan "gpair set dp")\n"
}


invalid_args=()

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
      current_pair_initial=$1
      shift
    else
      invalid_args+=("$1") # save it in an array for later
      shift # past argument
      shift # past value
    fi
    ;;
esac
done

handle-invalid-args echo-set-pair-usage $invalid_args

if [ ! -f $GPAIR_PAIRS_PATH ]; then
    echo "Cannot find pairs file. Make sure .pairs file is in the root directory of the repository."
fi

author_line_regex='^[[:space:]][[:space:]]\[(.+)\]:[[:space:]](.+);[[:space:]](.+)$'

found_pair_match=false
while IFS= read -r line
do
  if [[ $line =~ $author_line_regex ]]
  then
    if [ $found_pair_match = false ]
    then 
      
      pair_initials="${BASH_REMATCH[1]}"
      pair_name="${BASH_REMATCH[2]}"
      pair_email="${BASH_REMATCH[3]}"

      if [ $pair_initials == $current_pair_initial ]
      then
        found_pair_match=true
 
        if [ -f $GPAIR_CURRENT_PAIR_PATH ]; then
            rm $GPAIR_CURRENT_PAIR_PATH
        fi

        echo "$pair_name <$pair_email>" > "$GPAIR_CURRENT_PAIR_PATH"
      fi
    fi
  fi
done < "$GPAIR_PAIRS_PATH"

if [ $found_pair_match = false ]
then
  echo -e "\n  Sorry! No pair match found for $current_pair_initial."
  echo -e "  Check .pairs file to make sure this person has been added.\n"
else
  echo -e "\n  $(output::bold::green "Success!") Current pair is now...\n\n  $(output::bold "$pair_name") $(output::bold "<$pair_email>") !!!\n"
fi

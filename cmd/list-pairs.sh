#!/bin/bash

source $GPAIR_CONSTANTS_PATH
source $GPAIR_OUTPUTS_PATH
source $GPAIR_UTILS_PATH

echo-list-pairs-usage() {
  echo -e "\n $(output::bold::green " USAGE:") gpair ls [options]\n"
  echo -e " Lists all available pairs.\n"
  echo -e " $(output::bold::green "[OPTIONS]:")\n"
  echo -e "   $(output::help_flag "-h" "--help")        Print usage information\n"
}

invalid_args=()

while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -h|--help)
    echo-list-pairs-usage
    exit 0
    ;;
    *)    # unknown option
    invalid_args+=("$1") # save it in an array for later
    shift # past argument
    shift # past value
    ;;
esac
done

handle-invalid-args echo-list-pairs-usage $invalid_args

if [ ! -f $GPAIR_PAIRS_PATH ]; then
    echo "Cannot find pairs file. Make sure .pairs file is in the root directory of the repository."
fi

if [ -f $GPAIR_CURRENT_PAIR_PATH ]; then
  read -r current_pair < $GPAIR_CURRENT_PAIR_PATH
fi

echo ""
while IFS= read -r author
do
  
  if [[ $author =~ $GPAIR_AUTHOR_LINE_REGEX ]]
  then
      pair_initials="${BASH_REMATCH[1]}"
      pair_name="${BASH_REMATCH[2]}"
      pair_email="${BASH_REMATCH[3]}"

      if [[ "$pair_name <$pair_email>" == $current_pair ]]
      then
        echo -e "  $(output::bold::green "$pair_initials: $pair_name <$pair_email>")"
      else
        echo -e "  $pair_initials: $pair_name <$pair_email>"
      fi
  fi
done < "$GPAIR_PAIRS_PATH"
echo ""

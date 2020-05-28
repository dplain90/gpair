#!/bin/bash

source $GPAIR_CONSTANTS_PATH
source $GPAIR_OUTPUTS_PATH
source $GPAIR_UTILS_PATH

echo-clear-usage() {
  echo -e "\n $(output::bold::green " USAGE:") gpair clear [options]\n"
  echo -e " Clears current pair value.\n"
  echo -e " $(output::bold::green "[OPTIONS]:")\n"
  echo -e "   $(output::help_flag "-h" "--help")        Print usage information"
  echo -e "\n $(output::bold::green " EXAMPLE:") $(output::bold::cyan "gpair clear")\n"
}

invalid_args=()

while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -h|--help)
    echo-clear-usage
    exit 0
    ;;
    *)    # unknown option
    invalid_args+=("$1") # save it in an array for later
    shift # past argument
    shift # past value
    ;;
esac
done

handle-invalid-args echo-clear-usage $invalid_args

if [ -f $GPAIR_CURRENT_PAIR_PATH ]; then
  rm "$GPAIR_CURRENT_PAIR_PATH"
fi

echo -e "\n  $(output::bold::green "Success!") Current pair has been cleared.\n"

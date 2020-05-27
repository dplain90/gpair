#!/bin/bash

source $GPAIR_CONSTANTS_PATH
source $GPAIR_OUTPUTS_PATH

echo-print-pair-usage() {
  echo -e "\n $(output::bold::green " USAGE:") gpair pair [options]\n"
  echo -e " Show current pair information.\n"
  echo -e " $(output::bold::green "[OPTIONS]:")\n"
  echo -e "   $(output::help_flag "-h" "--help")        Print usage information\n"
}

invalid_args=()

while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -h|--help)
    echo-print-pair-usage
    exit 0
    ;;
    *)    # unknown option
    invalid_args+=("$1") # save it in an array for later
    shift # past argument
    shift # past value
    ;;
esac
done

invalid_args_length=${#invalid_args[@]}

if [ $invalid_args_length != "0" ]; then
  echo -e "\n$(output::bold::red " Error processing the following arguments: \n")"
  for (( i=0; i<$invalid_args_length; i++ )); do echo -e "    ${invalid_args[$i]} is not a valid argument." ; done
  echo -e "\n$(output::bold " -----------------------------------------")"
  echo-print-pair-usage
  exit 1
fi

root_git_directory=$(git rev-parse --show-toplevel)

current_pair_file="$root_git_directory/.current-pair"

if [ ! -f $current_pair_file ]; then
    echo "No pair set."
fi

read -r current_pair < $current_pair_file

echo $current_pair
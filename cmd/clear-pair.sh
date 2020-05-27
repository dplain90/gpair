#!/bin/bash

source $GPAIR_CONSTANTS_PATH
source $GPAIR_OUTPUTS_PATH

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

invalid_args_length=${#invalid_args[@]}

if [ $invalid_args_length != "0" ]; then
  echo -e "\n$(output::bold::red " Error processing the following arguments: \n")"
  for (( i=0; i<$invalid_args_length; i++ )); do echo -e "    ${invalid_args[$i]} is not a valid argument." ; done
  echo -e "\n$(output::bold " -----------------------------------------")"
  echo-clear-usage
  exit 1
fi


root_git_directory=$(git rev-parse --show-toplevel)

current_pair_path="$root_git_directory/.current-pair"
rm "$current_pair_path"

echo "Success! Current pair has been cleared."
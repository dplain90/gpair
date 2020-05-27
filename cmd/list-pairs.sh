#!/bin/bash

source $GPAIR_CONSTANTS_PATH
source $GPAIR_OUTPUTS_PATH

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

invalid_args_length=${#invalid_args[@]}

if [ $invalid_args_length != "0" ]; then
  echo -e "\n$(output::bold::red " Error processing the following arguments: \n")"
  for (( i=0; i<$invalid_args_length; i++ )); do echo -e "    ${invalid_args[$i]} is not a valid argument." ; done
  echo -e "\n$(output::bold " -----------------------------------------")"
  echo-clear-usage
  exit 1
fi


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
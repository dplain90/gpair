#!/bin/bash

source $GPAIR_CONSTANTS_PATH
source $GPAIR_OUTPUTS_PATH


echo-set-pair-usage() {
  echo -e "\n $(output::bold::green " USAGE:") gpair set <initials> [options] \n"
  echo -e " Sets your current pair.\n"
  echo -e " $(output::bold::green "[OPTIONS]:")\n"
  echo -e "   $(output::help_flag "-h" "--help")        Print usage information"
  echo -e "\n $(output::bold::green " EXAMPLE:") $(output::bold::cyan "gpair set dp")\n"
}


POSITIONAL=()

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

invalid_args_length=${#invalid_args[@]}

if [ $invalid_args_length != "0" ]; then
  echo -e "\n$(output::bold::red " Error processing the following arguments: \n")"
  for (( i=0; i<$invalid_args_length; i++ )); do echo -e "    ${invalid_args[$i]} is not a valid argument." ; done
  echo -e "\n$(output::bold " -----------------------------------------")"
  echo-set-pair-usage
  exit 1
fi

set -- "${invalid_args[@]}" # restore positional parameters

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
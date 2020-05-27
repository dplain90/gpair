#!/bin/bash

source $GPAIR_CONSTANTS_PATH
source $GPAIR_OUTPUTS_PATH

root_git_directory=$(git rev-parse --show-toplevel)

pair_file="$root_git_directory/.pairs"

if [ ! -f $pair_file ]; then
    echo "Cannot find pairs file. Make sure .pairs file is in the root directory of the repository."
fi


echo-add-pair-usage() {
  echo -e "\n $(output::bold::green " USAGE:") gpair add [options]\n"
  echo -e " Adds a new author to the pairs list.\n"
  echo -e " $(output::bold::green "[OPTIONS]:")\n"
  echo -e "   $(output::help_flag "-h" "--help")        Print usage information"
  echo -e "   $(output::help_flag "-n" "--name")        Author's name. $(output::required)"
  echo -e "   $(output::help_flag "-e" "--email")       Author's email. Must be email that is used on github. $(output::required)"
  echo -e "   $(output::help_flag "-i" "--initials")    Author's initials. Must be unique. $(output::required)"
  echo -e "\n $(output::bold::green " EXAMPLE:") $(output::bold::cyan "gpair -n \"John Doe\" -e \"johndoe@gmail.com\" -i \"jd\"")\n"
}


POSITIONAL=()

while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -h|--help)
    echo-add-pair-usage
    exit 0
    ;;
    -n|--name)
    pair_author_name="$2"
    shift # past argument
    shift # past value
    ;;
    -e|--email)
    pair_author_email="$2"
    shift # past argument
    shift # past value
    ;;
    -i|--initials)
    pair_author_initials="$2"
    shift # past argument
    shift # past value
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
  echo-add-pair-usage
  exit 1
fi

set -- "${invalid_args[@]}" # restore positional parameters

initials_exist=false
existing_initials_pair_name=""
existing_initials_pair_email=""

while IFS= read -r author
do
  IFS=';' read -ra author_attr <<< "$author"
  pair_initials="${author_attr[0]}"
  pair_name="${author_attr[1]}"
  pair_email="${author_attr[2]}"
  if [ $pair_initials == $pair_author_initials ]; then
    initials_exist=true
    existing_initials_pair_name="$pair_name"
    existing_initials_pair_email="$pair_email"
  fi
done < "$pair_file"

if [ $initials_exist == true ]; then
  echo -e "Sorry! The initials $pair_author_initials are already in use by:\n $existing_initials_pair_name <$existing_initials_pair_email> \nPlease try again with a different set of initials."
else
  echo "$pair_author_initials;$pair_author_name;$pair_author_email" >> $pair_file
  echo -e "Success! $pair_author_name <$pair_author_email> has been added with the initials $pair_author_initials"
fi
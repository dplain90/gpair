#!/bin/bash

source $GPAIR_CONSTANTS_PATH
source $GPAIR_OUTPUTS_PATH
source $GPAIR_UTILS_PATH


if [ ! -f $GPAIR_PAIRS_PATH ]; then
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


invalid_args=()

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


handle-invalid-args echo-add-pair-usage $invalid_args

handle-missing-arg "Author name is missing." echo-add-pair-usage $pair_author_name

handle-missing-arg "Author email is missing." echo-add-pair-usage $pair_author_email

handle-missing-arg "Initials are missing." echo-add-pair-usage $pair_author_initials

initials_exist=false
existing_initials_pair_name=""
existing_initials_pair_email=""

while IFS= read -r author
do
  if [[ $author =~ $GPAIR_AUTHOR_LINE_REGEX ]]
  then
      pair_initials="${BASH_REMATCH[1]}"
      pair_name="${BASH_REMATCH[2]}"
      pair_email="${BASH_REMATCH[3]}"
      if [ $pair_initials == $pair_author_initials ]; then
        initials_exist=true
        existing_initials_pair_name="$pair_name"
        existing_initials_pair_email="$pair_email"
      fi
  fi
done < "$GPAIR_PAIRS_PATH"

if [ $initials_exist == true ]; then
  echo -e "Sorry! The initials $pair_author_initials are already in use by:\n $existing_initials_pair_name <$existing_initials_pair_email> \nPlease try again with a different set of initials."
else
  echo "  [$pair_author_initials]: $pair_author_name; $pair_author_email" >> $GPAIR_PAIRS_PATH
  echo -e "Success! $pair_author_name <$pair_author_email> has been added with the initials $pair_author_initials"
fi

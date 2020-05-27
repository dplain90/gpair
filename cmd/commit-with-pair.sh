#!/bin/bash

source $GPAIR_CONSTANTS_PATH
source $GPAIR_OUTPUTS_PATH

echo-commit-usage() {
  echo -e "\n $(output::bold::green " USAGE:") gpair commit \"commit message\" [options]\n"
  echo -e " Creates a commit with current pair set as co-author.\n"
  echo -e " $(output::bold::green "[OPTIONS]:")\n"
  echo -e "   $(output::help_flag "-h" "--help")        Print usage information"
  echo -e "\n   $(output::bold::orange "All native git commit options are available.") [https://git-scm.com/docs/git-commit]
  "
  echo -e "\n $(output::bold::green " EXAMPLES:")\n\n $(output::bold::cyan "  gpair commit \"feat(dashboard): initial commit\"")\n$(output::bold::cyan "   gpair commit \"add awesome feature\" --no-verify")\n"
}

while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -h|--help)
    echo-commit-usage
    exit 0
    ;;
    *)    # unknown option
    shift # past value
    ;;
esac
done


commit_message=$1
other_args=$(echo "${@:2}")

root_git_directory=$(git rev-parse --show-toplevel)

current_pair_file="$root_git_directory/.current-pair"

if [ ! -f $current_pair_file ]; then
    echo "  No pair has been set. You can set your pair with the following command:\n  git set <initials>\n  EX: git set dp"
fi

read -r current_pair < $current_pair_file

full_commit_message=$(echo -e "$commit_message\n\nCoauthored by $current_pair")

git commit -m "$full_commit_message" $other_args
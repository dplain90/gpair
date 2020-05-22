commit_message=$1
echo "${@:2}"
input="/Users/stride-admin/Code/git-coauthor-commit/current-pair.txt"
read -r current_pair < $input

full_commit_message=$(echo "$commit_message\n\nCoauthored by $current_pair")
other_args=$(echo "${@:2}")
git commit -m "$msg" $other_args
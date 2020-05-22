commit_message=$1

input="/Users/stride-admin/Code/git-coauthor-commit/current-pair.txt"
read -r current_pair < $input

full_commit_message="$commit_message\n\nCoauthored by $current_pair"

msg=$(echo $full_commit_message)
git commit -m "$msg"

echo "test"
#!/bin/bash

get_old_branch_names()
{
  for branch in $(git branch -r --no-merged master | sed 's/^\s*//' | sed 's/^remotes\///' | grep -v 'master$'); do
    if [ -z "$(git log "$branch" --since "$1" -1)" ]; then
      local_branch_name=${branch/#origin\/''}
      echo "$local_branch_name"
    fi
  done
}

main()
{
  local since=${1:-'3.months'}
  echo "Checking branches have no update in last $since..."
  get_old_branch_names "$since" | sort -i
}

main "$@"

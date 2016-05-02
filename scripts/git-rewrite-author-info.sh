#!/bin/sh

# git rewrite commit logs 
git filter-branch --commit-filter 'if [ "$GIT_AUTHOR_NAME" = "{committer_name}" ];
  then export GIT_AUTHOR_NAME="{name}"; export GIT_AUTHOR_EMAIL={email};
  fi; git commit-tree "$@"'
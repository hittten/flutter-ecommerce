#!/bin/bash

commits=(
  "" #future-list
  "" #mock-list
  "" #init
)
tags=(
  "future-list"
  "mock-list"
  "init"
)

# get length of an array
tagsLength=${#tags[@]}

# use for loop to read all values and indexes
for (( i=0; i<${tagsLength}; i++ ));
do
  if [ "${commits[$i]}" != "" ]
  then
    echo "Tagging: ${commits[$i]} with tag: ${tags[$i]}"
    git co "${commits[$i]}"
    git tag -a "${tags[$i]}" -m ${tags[$i]} --force
  else
    echo "Skip: ${tags[$i]}"
  fi
done

git co main

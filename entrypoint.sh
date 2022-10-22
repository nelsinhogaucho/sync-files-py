#!/bin/sh -l

echo "Hello $1"

export IFS=","
files_changed="$1"
for file in $files_changed; do
  echo "$file"
done

time=$(date)
echo "time=$time" >> $GITHUB_OUTPUT
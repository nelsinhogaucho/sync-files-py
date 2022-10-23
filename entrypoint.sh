#!/bin/sh -l

echo "Hello $1"

export IFS=","
files_added="$1"
for file in $files_added; do
  echo "ADDED: $file"
done

files_modified="$2"
for file in $files_modified; do
  echo "MODIFIED: $file"
done

files_added_modified="$3"
for file in $files_added_modified; do
  echo "ADDED-MODIFIED: $file"
done

time=$(date)
echo "time=$time" >> $GITHUB_OUTPUT
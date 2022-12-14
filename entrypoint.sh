#!/bin/sh -l

echo "Hello $1 | $2 | $3 | $4 | $5 | $6"

# Create a dedicated profile for this action to avoid conflicts
# with past/future actions.
aws configure --profile s3-sync-action <<-EOF > /dev/null 2>&1
$4
$5
$6
text
EOF

cd /s3

export IFS=","
files_added="$1"
for file in $files_added; do
    echo "ADDED: $file"
    dirname /$file
    #dir=dirname /$file
    CURRENT=`pwd`
    BASENAME=`basename "$CURRENT"`

    echo "$BASENAME"

    if [ "$(dirname /$file)" = "/" ]; then continue; fi

    cmd="aws s3 sync $(dirname /$file) s3://$3$(dirname /$file) --profile s3-sync-action --no-progress --exclude *.sh --size-only"
    echo $cmd
    eval $cmd

done

files_modified="$2"
for file in $files_modified; do
    echo "MODIFIED: $file"
    dirname /$file

    CURRENT=`pwd`
    BASENAME=`basename "$CURRENT"`

    echo "$BASENAME"
    if [ "$(dirname /$file)" = "/" ]; then continue; fi

    cmd="aws s3 sync $(dirname /$file) s3://$3$(dirname /$file) --profile s3-sync-action --no-progress --exclude *.sh --size-only"
    echo $cmd
    eval $cmd

    echo "/MODIFIED: $file"
done

# Clear out credentials after we're done.
# We need to re-run `aws configure` with bogus input instead of
# deleting ~/.aws in case there are other credentials living there.
# https://forums.aws.amazon.com/thread.jspa?threadID=148833
aws configure --profile s3-sync-action <<-EOF > /dev/null 2>&1
null
null
null
text
EOF


time=$(date)
echo "time=$time" >> $GITHUB_OUTPUT
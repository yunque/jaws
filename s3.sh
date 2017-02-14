#!/bin/bash

# Create bucket
aws s3 mb s3://bucket-test
# Remove bucket (must be empty)
aws s3 rm s3://bucket-test
# Remove non-empty bucket
aws s3 rm s3://bucket-test --force

# List buckets
aws s3 ls
# List objects and folders in a bucket
aws s3 ls s3://bucket-test
# List objects inside a folder
aws s3 ls s3://bucket-test/subdir

# # Delete a local file and sync the bucket
# Delete local file
rm ./file.txt
# Attempt sync without --delete option - nothing happens
aws s3 sync . s3://bucket-test/path
# Sync with deletion - object is deleted from bucket
aws s3 sync . s3://bucket-test/path --delete

# # Delete an object from bucket and sync local directory
# Delete object from bucket
aws s3 rm s3://bucket-test/path/file.txt
# Sync with deletion - local file is deleted
aws s3 sync s3://bucket-test/path . --delete

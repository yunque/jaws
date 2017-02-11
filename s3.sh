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

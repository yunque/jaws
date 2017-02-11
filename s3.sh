#!/bin/bash

# Create bucket
aws s3 mb s3://bucket-test

# Remove bucket
aws s3 rm s3://bucket-test

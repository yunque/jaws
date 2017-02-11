#!/usr/bin/env python3

import boto3

def new_bucket():
  # Connect to S3 and create a new bucket with a unique name
  s3 = boto.connect_s3()
  bucket_uuid = s3.create_bucket('domain.com')

  # Create a key in which to store the data
  # Returns a new 'key' object, but nothing happens on S3 yet
  key = bucket_uuid.new_key('test/test_1.wav')

  # Open a file handle to the specified local file;
  # & (a) buffer(s) read/write the bytes from the file
  # ...into the 'key' object on S3.
  key.set_contents_from_filename('/home/test/test_1.wav')

  # Set the Access Control List (public => no permissions required)
  key.set_acl('public-read')

if __name__ == '__main__':
  new_bucket()

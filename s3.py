#!/usr/bin/env python3


import boto3


def s3_connect():
	# Create connection
	s3 = boto3.resource('s3')
	return s3


def create_bucket(s3, bucket_name):
	''' Create a bucket if it does not already exist '''
	# Look up bucket in S3
	bucket = s3.lookup(bucket_name)

	# If bucket doesn't exist, create it
	if bucket is None:
		s3.create_bucket(Bucket=bucket_name, CreateBucketConfiguration={
			'LocationConstraint': 'eu-west'
			})
		set_access_controls(bucket)

	# If bucket already exists, raise exception
	except S3ResponseError:
	    print("Bucket %s already exists in S3.", bucket_name)

	
def set_access_controls(bucket):
	# Access controls
	bucket.Acl().put(ACL='private')
	# obj.Acl().put(ACL='private')

	# Retrieve policy grant info
	acl = bucket.Acl()
	for grant in acl.grants:
		print(grant['Grantee']['DisplayName'], grant['Permission'])
	# Add grantee
	bucket.Acl.put(GrantRead='emailAddress=yunque@github.com')
	
	
def get_metadata(username, timestamp, location, notes):
	''' Package metadata i.o.t. include with data when storing as object in S3 '''
	metadata = {
		'user': username,
		'timestamp': timestamp,
		'location': location,
		'notes': notes,
		'Content-Type': 'audio/wav'}
	return metadata


def store_data(s3, bucket_name, src, dst):
	# Metadata
	metadata = get_metadata()

	# Store data, c.f. https://github.com/boto/boto3/issues/372
	s3.Object(bucket_name, dst).put(Body=open(src, 'rb'), Metadata=metadata)

	# Retrieve this data by querying for key=dst, where dst is a full filepath/name


if __name__ == '__main__':
	# Create a connection to s3
	s3 = s3_connect()
	
	# Create a bucket
	create_bucket(s3, 'bucket_test')
	set_access_controls('bucket_test')
	
	# Add metadata about user's upload
	timestamp = str(datetime.now())
	get_metadata(username, timestamp, 'Neither here nor there', 'Cool in the pool')

	# Store a local file in the bucket
	# XXX: won't be necessary in final deployment
	store_data(s3, 'bucket_test', '/local/path/to/test_1.wav', 'test_1.wav')

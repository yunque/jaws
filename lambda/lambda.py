#!/usr/bin/env python3

'''
  Lambda function

Boilerplate Lambda function, currently downloads a wav from S3, 
extracts some parameters from it, and stores them in S3.

cf. http://docs.aws.amazon.com/lambda/latest/dg/with-s3-example-deployment-pkg.html
'''

import boto3
import uuid
import wave

s3 = boto3.client('s3')

def audio_params(audiofile):
    ''' Get audio parameters: nchannels, sampwidth, framerate, nframes, comptype, compname'''
    wav = wave.open(audiofile,'r')
    params = wav.getparams()
    return params

def handler(event, context):
    for record in event['Records']:
        bucket = record['s3']['bucket']['name']
        key = record['s3']['object']['key'] 
        download_path = '/tmp/{}{}'.format(uuid.uuid4(), key)
        upload_path = '/tmp/{}'.format(key)
        
        s3.download_file(bucket, key, download_path)
        params = audio_params(download_path)
        s3.upload_file(params, key)

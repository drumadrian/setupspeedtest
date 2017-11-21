from __future__ import print_function # Python 2/3 compatibility
import boto3
import json
import decimal
from boto3.dynamodb.conditions import Key, Attr
import os
dynamodb = boto3.resource('dynamodb')
s3 = boto3.resource('s3')
# import json

# https://stackoverflow.com/questions/4706499/how-do-you-append-to-a-file
# https://stackoverflow.com/questions/36780856/complete-scan-of-dynamodb-with-boto3
# https://boto3.readthedocs.io/en/latest/reference/services/s3.html#S3.Client.upload_file


print('Loading function')


def lambda_handler(event, context):
    #print("Received event: " + json.dumps(event, indent=2))
    for record in event['Records']:
        print(record['eventID'])
        print(record['eventName'])
        print("DynamoDB Record: " + json.dumps(record['dynamodb'], indent=2))
        print('Successfully processed {} records.'.format(len(event['Records'])) )
        
        

    table = dynamodb.Table('speedtest.adrianws.com_analytics')

    response = table.scan()
    data = response['Items']

    with open("/tmp/index.html", "w") as myfile:
        # index_file_contents = "<!DOCTYPE html> <html><body>" + json.dumps(data) + "</body>" 
        index_file_contents = json.dumps(data)
        myfile.write(index_file_contents)
        myfile.close()


    s3.meta.client.upload_file('/tmp/index.html', 'data.speedtest.adrianws.com', 'index.html')    
    s3.meta.client.upload_file('/tmp/index.html', 'data.speedtest.adrianws.com', 'data.html')    

    return "Good"



# https://stackoverflow.com/questions/31011179/converting-json-to-html-table-in-python
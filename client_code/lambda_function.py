from __future__ import print_function # Python 2/3 compatibility
import boto3
import json
import decimal
from boto3.dynamodb.conditions import Key, Attr
import os
dynamodb = boto3.resource('dynamodb')
s3 = boto3.resource('s3')
import json
from json2html import *

# https://stackoverflow.com/questions/4706499/how-do-you-append-to-a-file
# https://stackoverflow.com/questions/36780856/complete-scan-of-dynamodb-with-boto3
# https://boto3.readthedocs.io/en/latest/reference/services/s3.html#S3.Client.upload_file
# https://stackoverflow.com/questions/14150854/aws-s3-display-file-inline-instead-of-force-download
# https://stackoverflow.com/questions/31011179/converting-json-to-html-table-in-python
# https://stackoverflow.com/questions/34550816/aws-content-type-settings-in-s3-using-boto3

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

    #print html to console for testing
    html = json2html.convert(json = data)
    print (html)

    with open("/tmp/index.html", "w") as myfile:
        # index_file_contents = "<!DOCTYPE html> <html><body>" + json.dumps(data) + "</body>" 
        # index_file_contents = json.dumps(data)
        index_file_contents = html
        myfile.write(index_file_contents)
        myfile.close()


    s3.meta.client.upload_file('/tmp/index.html', 'data.speedtest.adrianws.com', 'index.html', ExtraArgs={'ContentType': "text/html"})    
    s3.meta.client.upload_file('/tmp/index.html', 'data.speedtest.adrianws.com', 'data.html', ExtraArgs={'ContentType': "text/html"})    

    return "Good"












if __name__ == "__main__":
    my_event = {"Records":[

    {
      "eventID": "1",
      "eventName": "1.0",
      "dynamodb": "1.0",
    }

    ]}
    lambda_handler(my_event, "blah2") 



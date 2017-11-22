
import boto3
import json

print('Loading function')
dynamo = boto3.client('dynamodb')




def lambda_handler(event, context):
    '''Demonstrates a simple HTTP endpoint using API Gateway. You have full
    access to the request and response payload, including headers and
    status code.

    To scan a DynamoDB table, make a GET request with the TableName as a
    query string parameter. To put, update, or delete an item, make a POST,
    PUT, or DELETE request respectively, passing in the payload to the
    DynamoDB API as a JSON body.
    '''
    print("Received event: " + json.dumps(event, indent=2))

    table_name = "speedtest.adrianws.com_analytics"

    response = dynamo.put_item(
        TableName=table_name,
        # Item={
        #     "time_since_epoch": {"S": "1511243444"},
        #     "1GBfiledownload": {"S": "??"},
        #     "ookla_host": {"S": "Hosted by 83 Plus Productions (Portland, OR) [1500.20 km]: 65.013 ms"},
        #     "date": {"S": "Mon Nov 20 21:55:43 PST 2017"},
        #     "maxdownload": {"S": "Download: 126.51 Mbit/s"},
        #     "maxupload": {"S": "Upload: 19.16 Mbit/s"},
        #     "user": {"S": "adrianweb"}},
        Item=event,
            ReturnConsumedCapacity='TOTAL'
        )



    if response['ConsumedCapacity']:
        dynamo_response = "OK"
        print(response)
    else:
        dynamo_response = "BAD"


    if dynamo_response == "OK":
        return  {
            'statusCode': '200',
            'body': json.dumps(response),
            'headers': {
                'Content-Type': 'application/json',
            },
        }
    else:
        return  {
            'statusCode': '400',
            'body': json.dumps(response),
            'headers': {
                'Content-Type': 'application/json',
            },
        }
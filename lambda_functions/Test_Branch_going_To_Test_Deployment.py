import boto3
import os

def my_handler(event, context):
    success = True
    
    

    client = boto3.client('sns')

    
    response = client.publish(
    TopicArn=os.environ['sns_topic'],
    # TargetArn='string',
    # PhoneNumber='string',
    Message='Test Branch Going to Test Deployment notification',
    Subject='Test Branch Going to Test Deployment notification',
    # MessageStructure='string',
    # MessageAttributes={
    #     'string': {
    #         'DataType': 'String'
    #         'StringValue': 'string',
    #         # 'BinaryValue': b'bytes'
    #     }
    # }
    )

    if response['MessageId']:
        success = True
    else:
        success = False

    
    if success == True:
        return { 
            'message' : "published to Topic"
        }  
    else: 
        return { 
            'message' : "Failed to publish to Topic"
        }  



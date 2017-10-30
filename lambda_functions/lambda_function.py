import boto3


def my_handler(event, context):
    success = True
    
    

    client = boto3.client('sns')

    
    response = client.publish(
    TopicArn='string',
    TargetArn='string',
    PhoneNumber='string',
    Message='string',
    Subject='string',
    MessageStructure='string',
    MessageAttributes={
        'string': {
            'DataType': 'string',
            'StringValue': 'string',
            'BinaryValue': b'bytes'
        }
    }
    )

    
    
    if success == True:
        return { 
            'message' : "published to Topic"
        }  
    else: 
        return { 
            'message' : "Failed to publish to Topic"
        }  



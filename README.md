

# install terraform on your local machine 
- change the var values in dynamodn.tfvars file accoridngly 
- copy the  "Command line or programmatic access" for the project you want to deploy the table and paste on your terminal  
- then execute the following code 
```
terraform init
terraform plan 
```

- if no error is shown, deploy the changes
```
terraform apply --auto-approve
```
It will deploy the chnages in the respective environemtn.

# this code needs to run only once. if the table already availble, no need to chnage it unless made some changes 


# attributes 
PK: 
- AGENTID#ID-123​#MARKET#SG#RECOM
- AGENTID#ID-123 #MARKET#SG#INSIGHT

SK:
- updated timestamp in unix 


ttl:
    - for recommended items ttl will be 15 days
    - for personalised insights ttl will be 1 day/24 hours 



some necessary command to read and write to dynamodb 
```

    

import boto3

client = boto3.client('dynamodb', region_name="us-east-2")

from boto3.dynamodb.conditions import Key

dynamodb = boto3.resource('dynamodb', region_name="us-east-2")
table = dynamodb.Table('RenewalSelfServe')

response = table.query(
      KeyConditionExpression=Key('PK').eq('AGENTID#ID-123 #MARKET#SG#INSIGHT')
    )
    print(response['Items'])


resp = table.query(
        KeyConditionExpression=Key('PK').eq('AGENTID#ID-123 #MARKET#SG#INSIGHT'), 
        ScanIndexForward=False
    )
                
if 'Items' in resp:
        print(resp['Items'][0])



book = {
    'PK': "This is a Good Book",
    'SK': 120,
    'year': "{'name': 'Kamal', 'BOY': 1980}",
}

table.put_item(Item=book)

another_book = {
    'PK': "This is a Good Book",
    'author': 180,
    'year': '1998'
}


resp = table.get_item(
        Key={
            'PK' : 'This is a Good Book',
            'SK': 120
        }
    )


# set a attribute for ttl using boto3 client
response = client.update_time_to_live(
    TableName='RenewalSelfServe',
    TimeToLiveSpecification={
        'Enabled': True,
        'AttributeName': 'TimeToExist'
    }
)



# set time to live for a attribute 
import datetime 
import time 
week = datetime.datetime.today() + datetime.timedelta(days=7)
expiryDateTime = int(time.mktime(week.timetuple())) 

book = {
    'PK': "This is a Good Books",
    'SK': 500,
    'year': "{'name': 'Kamal', 'BOY': 1980}",
    'TimeToExist': str(expiryDateTime)
}

table.put_item(Item=book)


# sort the record based on timestamp 
# ScanIndexForward=False will return the records in decending order 
# ScanIndexForward=True will return the records in ascinding order 

resp = table.query(
        KeyConditionExpression=Key('PK').eq('This is a Good Books'), 
        ScanIndexForward=False
    )
```


Interesting blogs :
- https://dynobase.dev/dynamodb-python-with-boto3/
- https://highlandsolutions.com/blog/hands-on-examples-for-working-with-dynamodb-boto3-and-python

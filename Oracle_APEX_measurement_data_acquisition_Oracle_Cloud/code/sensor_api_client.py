import requests
import json
import time
import random
from datetime import datetime

# ============================================
# Sensor Client API Test
# Very simple demo to show the basics usage REST Oracle APEX
# See Slides 
# Dienstag, 24. November 2020
# Meetup Oracle APEX  Kassel  
# https://www.meetup.com/de-DE/Oracle-APEX-Kassel/events/274381875/
# 
# =============================================


# REST Service URL's
base_url  = 'https://apex.oracle.com/pls/apex/gpi_consult/'
token_url = 'oauth/token'
serverinfo_url='sensor/serverinfo'
data_url  = '/sensor/1/measurement'


#Auto REST Service URL's
catalog_url = 'metadata-catalog/measured_values/'
auto_rest_url = 'measured_values/'


# OAuth Secrets
client_id     =  '<Your Client OAuth ID>'
client_secret =  '<Your Client OAuth Secret>'



# define the payload
now = datetime.now()
date_string = time.mktime(now.timetuple()) + now.microsecond * 1e-6
temperatur = random.random() * 20 + 1
Luftfeuchtigkeit =  random.random() * 100 + 1

data_record ={  "timestamp" : date_string  , "timestamp_format"  : "epoch" , "measurements" : [ { "unit"  : "temp"  , "value" : temperatur } , { "unit": "hum" , "value": Luftfeuchtigkeit } ]}
auto_table_data_record = {"sensor_id":1, "mdate":"2020-11-23T17:48:39.693Z",  "unit":"temp",  "value":temperatur}


# request tocken
response = requests.post( base_url+token_url , auth=(client_id, client_secret),  data={'grant_type': 'client_credentials'} )

json_response = response.json()
access_tocken = json_response['access_token']

# Send the data

header_data = {"Authorization" : "Bearer "+access_tocken}




# Get the server Info
#response = requests.get(base_url+serverinfo_url, headers=header_data )

# Get the server Rest Catalog
#response = requests.get(base_url+catalog_url, headers=header_data )

# Get the Details für the Auto Rest Service
#read the table
#response = requests.get(base_url+auto_rest_url, headers=header_data )


# Send the Data
#Post data 
# print ( json.dumps(data_record))
# response = requests.post( base_url+data_url , headers=header_data, data=json.dumps(data_record) )


# Send the Auto REST data
#Post data into the table

print ( json.dumps(auto_table_data_record))

response = requests.post( base_url+auto_rest_url , headers=header_data, data=json.dumps(auto_table_data_record) )


print ( "\n--------start the call ---------------")

# Show the heeader of the response
print( str(response.headers).replace("%20"," ").replace("%28"," ") )

print ( "\n--------Respone ---------------")

print(response.content)



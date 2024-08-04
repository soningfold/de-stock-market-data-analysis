from kafka import KafkaConsumer
from json import loads
import json
from s3fs import S3FileSystem
from env_vars import PUBLIC_IP, S3_BUCKET_NAME, S3_FILE_KEY


consumer = KafkaConsumer(
    'demo_test',
     bootstrap_servers=[f'{PUBLIC_IP}:9092'], 
    value_deserializer=lambda x: loads(x.decode('utf-8')))

s3 = S3FileSystem()

for count, i in enumerate(consumer):
    with s3.open(f"s3://{S3_BUCKET_NAME}/{S3_FILE_KEY}_{count}", 'w') as file:
        json.dump(i.value, file)   
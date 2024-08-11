from kafka import KafkaConsumer
from time import sleep
from json import dumps, loads
import json
from s3fs import S3FileSystem

topic=""
server=""
consumer = KafkaConsumer(
    f'{topic}',
    bootstrap_servers=[f'{server}:9092'],
    value_deserializer=lambda x: loads(x.decode('utf-8'))
)

s3 = S3FileSystem()
s3_path = ""
for count, i in enumerate(consumer):
    with s3.open(f"{s3_path}stock_market_{}.json".format(count), 'w') as file:
    json.dump(i.value, file)
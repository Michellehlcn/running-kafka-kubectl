import pandas as pd
from kafka import KafkaConsumer, KafkaProducer
from time import sleep
from json import dumps 
import json 

server=""
producer = KafkaProducer(bootstrap_server=[f'{server}:9092'], value_serializer=lambda x: dumps(x).encode('utf-8'))

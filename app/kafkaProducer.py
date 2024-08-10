import pandas as pd
from kafka import KafkaConsumer, KafkaProducer
from time import sleep
from json import dumps 
import json 


producer = KafkaProducer(bootstrap_server=['localhost:9092'], value_serializer=lambda x: dumps(x).encode('utf-8'))

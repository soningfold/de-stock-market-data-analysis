import pandas as pd
from kafka import KafkaProducer
from time import sleep
from json import dumps
from env_vars import PUBLIC_IP

producer = KafkaProducer(bootstrap_servers=[f'{PUBLIC_IP}:9092'], 
                         value_serializer=lambda x: 
                         dumps(x).encode('utf-8'))

df = pd.read_csv("data/stock_market_data.csv")

while True:
    dict_stock = df.sample(1).to_dict(orient="records")[0]
    producer.send('demo_test', value=dict_stock)
    sleep(1)

producer.flush() #clear data from kafka server
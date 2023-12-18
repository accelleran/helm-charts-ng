# echo "KAFKA_URL=\"drax-kafka.default:9092\"" > kafka_url.py

import kafka
from kafka_url import KAFKA_URL


producer = kafka.KafkaProducer(bootstrap_servers=[KAFKA_URL])

producer.send('test-topic', b'test')
producer.flush()
print('Published message')

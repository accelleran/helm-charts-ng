# echo "KAFKA_URL=\"drax-kafka.default:9092\"" > kafka_url.py && python3 kafka-test.py accelleran.drax.5g.ric.raw.messages,accelleran.drax.5g.ric.raw.pm_counters,accelleran.drax.5g.ric.raw.ue_measurements,accelleran.drax.5g.ric.raw.cu_state,accelleran.drax.5g.ric.raw.ran_control_response

import kafka
import sys
import time
import os
from kafka_url import KAFKA_URL


num_tries = 0
MAX_TRIES = 10
kafka_on = 0
SLEEP_INTERVAL = 2
TOPICS_CHECKED = True

if len(sys.argv) > 1:
    wanted_topics = sys.argv[1]
    TOPICS_CHECKED = False
else:
    print("topics checked as none provided!")

while True:
    try:
        consumer = kafka.KafkaConsumer(group_id="test", bootstrap_servers=[KAFKA_URL])
        topics = consumer.topics()

        print(f"kafka_url: {KAFKA_URL}")
        print(f"topics: {topics}")

        if not TOPICS_CHECKED:
            print(f"topics: {list(topics)}")
            print(f"wanted topics: {list(wanted_topics.split(','))}")
            if all(x in list(topics) for x in list(wanted_topics.split(","))):
                TOPICS_CHECKED = True
                print("topics checked!")
        # if not topics or not TOPICS_CHECKED:
        if not TOPICS_CHECKED:
            print("Kafka still not on...")
            num_tries = num_tries + 1
        else:
            print("KAFKA IS ON!")
            kafka_on = 1
            break
    except:
        print("Kafka still not on... (exception)")
        num_tries = num_tries + 1

    if num_tries == MAX_TRIES:
        break

    time.sleep(SLEEP_INTERVAL)

if not kafka_on:
    raise RuntimeError()

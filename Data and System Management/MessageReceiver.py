import paho.mqtt.client as mqtt
import os
from sqlalchemy.orm import sessionmaker

from app.models import Trigger, Pump


from sqlalchemy import create_engine
basedir = os.path.abspath(os.path.dirname(__file__))
engine = create_engine('sqlite:///' + os.path.join(basedir, 'data.sqlite'), echo=True)

Session = sessionmaker(bind=engine)
session = Session()

pump = '01'
username = "MQTT_Username"
password = "MQTT_Password"
dispenserID = 0



def record_data(topic, payload):
    if topic == 'pumpID':
        trigger = Trigger(pump=payload,
                          )
        session.add(trigger)
        session.commit()
        return
    elif topic == 'volt':
        global pump
        print('Battery level for pump {} is {}'.format(pump, payload))
        temp = session.query(Pump).get(pump)
        print('temp')
        temp.volt = payload
        session.commit()
        return


# Define event callbacks
def on_connect(client, userdata, flags, rc):
    print("rc: " + str(rc))


def on_message(client, obj, msg):
    print(msg.topic + " " + str(msg.qos) + " " + str(msg.payload))
    topic = str(msg.topic)
    if topic == 'pumpID':
        payload = str(msg.payload)
        payload = payload[2:-1]
        record_data(topic, payload)
        global pump
        pump = payload
    elif topic == 'volt':
        payload = str(msg.payload)
        payload = payload[2:-1]
        record_data(topic, payload)

def on_publish(client, obj, mid):
    print("mid: " + str(mid))


def on_subscribe(client, obj, mid, granted_qos):
    print("Subscribed: " + str(mid) + " " + str(granted_qos))


def on_log(client, obj, level, string):
    print(string)


mqttc = mqtt.Client()
# Assign event callbacks
mqttc.on_message = on_message
mqttc.on_connect = on_connect
mqttc.on_publish = on_publish
mqttc.on_subscribe = on_subscribe

# Connect to the mosquitto broker
mqttc.username_pw_set(username, password)
mqttc.connect('127.0.0.1', 1883)
mqttc.subscribe('pumpID', 0)
mqttc.subscribe('volt', 0)

# Continue the network loop, exit when an error occurs
rc = 0
while rc == 0:
    rc = mqttc.loop()
print("rc: " + str(rc))
#include <ESP8266WiFi.h>
#include <PubSubClient.h>

int button = D2;
int buttonState = 0;

ADC_MODE(ADC_VCC); //to use getVcc
String batterylevel;


//WIFI  and MQTT Credentials

const char* ssid = "Wi-Fi name";
const char* password = "Wi-Fi password";

const char* mqtt_server = "Server IP";
const int mqtt_port = 1883/Port;
const char* mqtt_username = "MQTT username";
const char* mqtt_password = "MQTT password";


WiFiClient espClient;
PubSubClient client(espClient);

void setup_wifi(){

  delay(10);
  Serial.println();
  Serial.print("Connecting to ");
  Serial.println(ssid);

  WiFi.begin(ssid, password);

  while(WiFi.status() != WL_CONNECTED){
    delay(500);
    Serial.print(".");
  }

  randomSeed(micros());

  Serial.println("");
  Serial.println("WiFi Connected");
  Serial.print("IP address: ");
  Serial.println(WiFi.localIP());
}

void sleepNow(){

  Serial.println("Going into deep sleep until interrupt");
  ESP.deepSleep(0);
}

void callback(char* topic, byte* payload, unsigned int length) {
  Serial.print("Message arrived [");
  Serial.print(topic);
  Serial.print("] ");
  for (int i = 0; i < length; i++) {
    Serial.print((char)payload[i]);
  }
  Serial.println();
}

void reconnect() {
  // Loop until we're reconnected
  while (!client.connected()) {
    Serial.print("Attempting MQTT connection...");
    // Create a random client ID
    String clientId = "ESP8266Client-";
    clientId += String(random(0xffff), HEX);
    // Attempt to connect
//    if (client.connect(clientId.c_str(), mqtt_username, mqtt_password)) {
    if (client.connect(clientId.c_str())) {
      Serial.println("connected");
 
    } else {
      Serial.print("failed, rc=");
      Serial.print(client.state());
      Serial.println(" try again in 5 seconds");
      // Wait 5 seconds before retrying (this could potentially be shortened)
      delay(5000);
    }
  }
}

void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);
  setup_wifi();
  client.setServer(mqtt_server, mqtt_port);
  client.setCallback(callback);

}


void loop() {
  // put your main code here, to run repeatedly:
 batterylevel = ESP.getVcc();
 char charBuf[50];
 batterylevel.toCharArray(charBuf,50);
 
 
 reconnect();
 client.publish("pumpID", "00"); //The letter sent here identifies the pump
 Serial.println("Published: 00");
 delay(100);
 client.publish("volt", charBuf); //publishes voltage
 Serial.println(batterylevel);
 Serial.println(charBuf);
 client.loop();

 sleepNow();
}

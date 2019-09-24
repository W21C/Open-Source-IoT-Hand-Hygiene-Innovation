
// -----------------------------
// MQTT Message Handling
// -----------------------------


MQTTClient client;

void clientConnected() {
  println("client connected");
}


void messageReceived(String topic, byte[] payload) {
  println("new message: " + topic + " - " + new String(payload));
  String msg = new String(payload);
  msg = (msg == null) ? null : msg.trim();
  println(msg);
  Integer temp;
  Integer index;
  temp = Integer.valueOf(msg);

  while (temp>6) {
    temp = temp -6;
  }

  index = temp;

  int id = index;     
  println(theHour);


  if (id >= 1 && id <= 7) { // is not equal to noise
    if (index == 1 || index == 2 || index == 3 || index == 4 || index == 5 || index == 6 ) {
      // Check If The Timer Has Elapsed
      if ( sanitizers[id-1].runTimeout() ) {
        sanitizers[id-1].dispenserTriggered(id-1);

      } else {
        println("Sorry, But Sanitizer #" + str(id-1) + " Isn't Ready To Be Triggered Again Quite Yet...");
      }
    }
  }
}

void connectionLost() {
  println("connection lost");
}

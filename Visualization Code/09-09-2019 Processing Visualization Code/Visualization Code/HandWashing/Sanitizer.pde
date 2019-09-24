
// -----------------------------
// SANITIZER CLASS
// -----------------------------

class Sanitizer {

  // VARIABLES
  // -----------------------------

  TheHand hand;
  
  int deviceID;
  String deviceName;
  float pwmRate;
  
  color myColor;
  String svg;
  
  int triggersThisHour;
  int triggersThisDay;
  int triggersThisWeek;
  int triggersThisMonth;
  int triggersThisYear;
  
  int currHour;
  int lastHour;
  int currMinute;
  int lastMinute;
  int currSecond;
  int lastSecond;  
  
  int timeoutPeriod = 2000;
  int triggerTime = 0;
  boolean readyToTrigger = true;

  
 

  
  // CONSTRUCTOR for other SVG files
  // -----------------------------

  Sanitizer(int _id, color _color, String svgFile) {

    deviceID = _id;
    deviceName = "UNIT " + str(deviceID + 1);
    myColor = _color;
    svg = svgFile;
   
    
  }
  
  
  // TRIGGER
  // -----------------------------

  void dispenserTriggered(int _id) {
    println(" -- TRIGGERING UNIT #" + _id + " -- ");
    
    // Reset Screen
    drawState = 1;
    subDrawState = 1;
    
//    // Set XY
    int prevX = newX;
    int prevY = newY;
  
    float upperXlimit = width * 0.95;
    float lowerXlimit = width * 0.05;
    float upperYlimit = height * 0.85;
    float lowerYlimit = height * 0.15;
    newX = round(random(lowerXlimit, upperXlimit));
    newY = round(random(lowerYlimit, upperYlimit));
    


   //GERM IMPLEMENTATION
     if( useGerms == true){
       if(hands.size() != 0){
         TheHand currentGerm = hands.get(0);
         splatter.add(new TheSplat(currentGerm.c1, currentGerm.xPos, currentGerm.yPos, currentGerm.prevX, currentGerm.prevY, splatSVG));
         hands.remove(0); 
       }
       
    }
    else{
      hands.add(new TheHand(myColor, newX, newY, prevX, prevY, svg));
    }

    // Update Dataset   
    updateData();
    
    // Reset Timer
    resetTimer();
      
   
    // Reset Boolean & Run Timeout Method
    readyToTrigger = false;
    triggerTime = millis();
  
  }
  
   // TIMEOUT
  // -----------------------------

  boolean runTimeout() {
    println(" -- RUNNIMG TIMEOUT FOR UNIT #" + deviceID + " -- ");
    
    if((millis() - triggerTime) >= timeoutPeriod ) {
       readyToTrigger = true; 
    }
    
    return readyToTrigger;
  }
  
  // SAVE
  // -----------------------------

  void updateData() {
    println(" -- UPDATING DATA -- ");
    
    try {
    
      // Update Counters

      allHandsThisDay++;
      count++; 
      numHandsThisDay[deviceID]++;

      
      // println(deviceName + " has been triggered " + numHandsThisHour[deviceID] + " times this hour...");
      println("Device #" + deviceID + " has been triggered " + numHandsThisDay[deviceID] + " times today...");
      
    
    }
    catch(Exception e) {
      println("WHOA!!");
      //e.printStackTrace(); 
    }
    
  }


} /* End Of Class Sanitizer */

void AssignTheme(){

  int themeIndex = int(random(0,6));
  if(themeIndex == 0){
     for(int i = 0; i < sanitizers.length; i++) {
    // Id, Color
    sanitizers[i] = new Sanitizer(i, paletteAfrica[i], africanAnimals[i]);
     }
  }
  else if(themeIndex == 1){
    for(int i = 0; i < sanitizers.length; i++) {
    // Id, Color
    sanitizers[i] = new Sanitizer(i, paletteCanada[i], canadianAnimals[i]);
    }
  }
  else if(themeIndex == 2){
    for(int i = 0; i < sanitizers.length; i++) {
    // Id, Color
    sanitizers[i] = new Sanitizer(i, paletteOcean[i], oceanCreatures[i]);
    }
  }
  else if(themeIndex == 3){
    for(int i = 0; i < sanitizers.length; i++) {
    // Id, Color
    sanitizers[i] = new Sanitizer(i, paletteDogs[i], dogs[i]);
    }
  }
  else if(themeIndex == 4){
    for(int i = 0; i < sanitizers.length; i++) {
    // Id, Color
    sanitizers[i] = new Sanitizer(i, paletteInsects[i], insects[i]);
    }
  }
  else{
    for(int i = 0; i < sanitizers.length; i++) {
    // Id, Color
    sanitizers[i] = new Sanitizer(i, paletteTransport[i], transport[i]);
    }
  }
  
}

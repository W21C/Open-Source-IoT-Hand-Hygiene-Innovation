
// -----------------------------
// SPLAT CLASS
// -----------------------------

class TheSplat { 
  
  PShape img;
  color c1;
  
  int deviceID;
  
  int xPos;
  int yPos;
  int prevX;
  int prevY;
  float rotation;
  int scale1 = 50;
  int scale2 = int(random(50, 150));

  
  // Constructor
  TheSplat(color tempC, int Xpos, int Ypos, int OldX, int OldY, String svgFile) { 
    c1 = tempC;
    xPos = Xpos;
    yPos = Ypos;
    prevX = OldX;
    prevY = OldY;
    rotation = random(3);
    img = loadShape(svgFile);
  
  }

  void display() {
    pushMatrix(); pushStyle();
    
    img.disableStyle();
    translate(prevX, prevY);
    rotate(rotation);
    fill(c1);
    noStroke();
    shapeMode(CENTER);
    shape(img, 0, 0, scale1, scale1);

    popMatrix(); popStyle();
  }


    
} /* End of Class Splat */

// -----------------------------
// SPLAT FUNCTION
// -----------------------------

void drawSplatter() {
  pushMatrix(); pushStyle();
  if(splatter.size() != 0) 
  {
  for (int i = 0; i < splatter.size(); i++) {

    tempSplat = (TheSplat)splatter.get(i);
    tempSplat.display();
  }
  } 
  
  popMatrix(); popStyle();
}

void growSplat() {
  pushMatrix(); pushStyle();
  if(splatter.size() != 0) 
  {
    for (int i = 0; i < splatter.size(); i++) {

      tempSplat = (TheSplat)splatter.get(i);
        if(tempSplat.scale1 < 250){
          tempSplat.scale1 = tempSplat.scale1 + 20;
       }
      }
  } 
  
  popMatrix(); popStyle();
}


void checkSplatterTime() {

   
  if(splatter.size() == 0){
    splatterStart = millis();
  }
  if((millis() - splatterStart) >= 1000 ) {
    // 
    splatterStart = millis();
    // Increase Second
    tempSplatSec ++;
    // Calculate Minute
    // Reset 
    if (tempSplatSec >= maxTempSplatCount) {
      if(splatter.size() != 0){
        int removedSplatter = splatter.size();
        if(removedSplatter > 1){
          removedSplatter = removedSplatter / 2;
        }
        for(int i = 0; i < removedSplatter; i++){
          
          splatter.remove(i);
        }
        tempSplatSec = 0;
      }

    }
    
  }
  
} 

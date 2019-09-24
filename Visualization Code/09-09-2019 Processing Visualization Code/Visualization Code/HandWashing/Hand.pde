
// -----------------------------
// HAND CLASS
// -----------------------------

class TheHand { 
  
  PShape img;
  color c1;

  int deviceID;
  int xPos;
  int yPos;
  int xPos2;
  int yPos2;
  int prevX;
  int prevY;
  float xspeed;
  float rotation;
  int scale1;
  int scale2;
  int size1 = 50;
  int size2= 200;

  
  // Constructor 
  TheHand(color tempC, int Xpos, int Ypos, int oldXpos, int oldYpos, String svgFile) { 
    c1 = tempC;
    xPos = Xpos;
    yPos = Ypos;
    prevX = oldXpos;
    prevY = oldYpos;
    scale1 = int(random(size1, size2));
    scale2 = int(random(size1 + 50, size2 + 50));
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
} /* End of Class Hand */

// -----------------------------
// HAND FUNCTION
// -----------------------------

void drawHands() {
  pushMatrix(); pushStyle();
  
  for (int i = 0; i <= hands.size(); i++) {
    if ((i+1) == hands.size()) {
      tempHand = (TheHand)hands.get(i);
      tempHand.display();
      //tempHand.animate();
    }
    if (i < (hands.size()-1)){
      tempHand = (TheHand)hands.get(i);
      tempHand.display();
    } 
  } 
  
  popMatrix(); popStyle();
}
void growHand() {
  pushMatrix(); pushStyle();
  if(hands.size() != 0) 
  {
    for (int i = 0; i < hands.size(); i++) {

      tempHand = (TheHand)hands.get(i);
        if(tempHand.scale1 < tempHand.scale2){
          tempHand.scale1 = tempHand.scale1 + 1;
       }
      }
  } 
  
  popMatrix(); popStyle();
}


// -----------------------------
// LOGOS
// -----------------------------

void displayW21C(float _scale, float _translateX, float _translateY) {
  pushMatrix(); pushStyle();
  
  translate(_translateX, _translateY);
  scale(_scale);
  
  image(w21clogo, width/2, height/2);
  
  popMatrix(); popStyle();
} 

// -----------------------------

void displayECUAD(float _scale, float _translateX, float _translateY) {
  pushMatrix(); pushStyle();

  translate(_translateX, _translateY);
  scale(_scale);
  
  image(eculogo, width/2, height/2);
  
  popMatrix(); popStyle();
} 

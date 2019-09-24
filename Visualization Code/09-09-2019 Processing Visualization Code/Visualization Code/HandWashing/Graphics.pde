
// -----------------------------
// GRAPHICS
// -----------------------------

void displayCount() {
  pushMatrix(); pushStyle();
  
  int currentCount = allHandsThisDay * 2;

  textFont(large);
  textAlign(LEFT); 

  // Drop Shadow
  fill(dropShadowColor);
  text(currentCount + " CLEAN HANDS TODAY", textPositionX + 2, textPositionY + 2); 
  
  // Text
  fill(textColor);
  text(currentCount + " CLEAN HANDS TODAY", textPositionX, textPositionY);
  
  popMatrix(); popStyle();
}

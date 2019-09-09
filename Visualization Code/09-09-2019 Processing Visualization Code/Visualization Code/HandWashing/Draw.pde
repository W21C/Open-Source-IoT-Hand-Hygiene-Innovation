
// -----------------------------
// DRAW
// -----------------------------

void draw() {    
  
  // Background
  background(bgColor);

  
  // Timer
  checkTime();
  
  if(useGerms == true){
     checkSplatterTime(); 
  }
  
  // Trigger Mode
  if(drawState == 1) { 
    
    // Draw All The Hands
    drawHands();
   if(useGerms == false){
     growHand();
   }
   if(useGerms == true){
     drawSplatter();
     growSplat();
   }
    // Draw Date & Time
    displayCount();
    displayClock();
  }
  // Semi Sleep Mode
  else if(drawState == 2) {
    
    // Draw All The Hands
    drawHands();
   
    if(useGerms == true){
     drawSplatter();
   }
    
    // Draw States 
    
    // Day View 
    if(subDrawState == 1) {
      displayVCH(0.25, width * 0.3, height * 0.75);
    }
    // VCH Logo
    else if(subDrawState == 2) {
      displayECUAD(0.25, width * 0.3, height * 0.75);  
    }
    
    // Draw Date & Time
    displayCount();
    displayClock();
    
  }
  // Full Sleep Mode
  else if(drawState == 3) {
    
    // Draw States 
    
    // Day View 
    if(subDrawState == 1) {
      displayVCH(0.5, width*0.1, height/4);
    }
    // VCH Logo
    else if(subDrawState == 2) {
      displayECUAD(0.5, width * 0.1, height/4);  
    }
    
    // Draw Date & Time
    displayCount();
    displayClock();
    
  }
  
  if(frameCount % 6000 == 0) {
    int fps = round(frameRate);
    println(" -- VCH Hand Sanitizer Running at " + fps + " FPS -- "); 
    println(" -- The Time Is " + time + " And Our Free Memory Is " + Runtime.getRuntime().freeMemory()/1024 + " K -- ");
    System.gc();
    println(" -- We Garbage Collected And Our Free Memory Is Now " + Runtime.getRuntime().freeMemory()/1024 + " K -- ");
    println("\n");
  }

  
} /* End Of Draw() */

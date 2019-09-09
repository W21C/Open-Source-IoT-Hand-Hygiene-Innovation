

// -----------------------------
// TIMER
// -----------------------------

void checkTime() {

  // 
  if((millis() - start) >= 1000 ) {
    // 
    start = millis();
    // Increase Second
    tempSec ++;
    // Calculate Minute
    tempMin = tempSec / 60;
    // Reset 
    if (count == maxVerticalHands || tempSec >= maxTempCount) {
     
      //GERM IMPLENTATION
       if(useGerms == true){
         AddGerm();
       }
      
      resetTimer();
      count = 0;
    }
    
  } 
  
  // Semi-Timeout
  if(tempMin >= halfTimeOut) {
    drawState = 2; 
  }

  // Timeout
  if(tempMin >= fullTimeOut) {
    drawState = 3; 
  }
  
  // Sub Draw State
  if(drawState == 2 || drawState == 3) {
    if(tempMin > lastMin) {
      println("Now Showing SubState " + subDrawState);
      subDrawState++;
      if(subDrawState >= 3) subDrawState = 1;
    }
  }
  
  
  
  // Reset lastMin
  lastMin = tempMin;
  
} /*   */

// -----------------------------

void resetTimer() {
  
  tempSec = 0;
  tempMin = 0; 
  
}

// -----------------------------

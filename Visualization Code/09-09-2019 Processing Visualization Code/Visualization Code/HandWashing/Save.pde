
// -----------------------------
// SAVING + RESETTING DATA
// -----------------------------

// -----------------------------
// RESET
// -----------------------------

void resetData(boolean day, boolean week, boolean month) {
  
  // Update Day
  if(day) {
    println("Resetting Day");
    updateDay(true, true);
  }
  
  // Update Week
  if(week) {
    println("Resetting Week");
    updateWeek(true, true);
  } 
  
  // Update Month
  if(month) {
    println("Resetting Month");
    updateMonth(true, true);
  }

  // Reset Stored Variables
  allHandsThisDay = 0;
  allHandsThisHour  = 0;
  allHandsThisDay   = 0;
  allHandsThisWeek  = 0;
  allHandsThisMonth = 0;
  allHandsThisYear  = 0;
  
  colorNumber = 0;
  //count = 0;
  
  //
  resetTimer();
  
    // Remove Items From ArrayList
  if(useGerms == false){
    
    for (int i = hands.size()-1; i >= 0; i--) { 
      hands.remove(i);
    }
  } 
  
}

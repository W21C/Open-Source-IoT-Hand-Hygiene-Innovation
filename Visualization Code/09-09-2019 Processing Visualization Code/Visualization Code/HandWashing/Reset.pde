
// -----------------------------
// RESET
// -----------------------------

void resetData() {
  
  // Update Day
    println("Resetting Day");
    updateDay(true);

   resetTimer();
  
  // Remove Items From ArrayList
  if(useGerms == false){ 
    for (int i = hands.size()-1; i >= 0; i--) { 
      hands.remove(i);
    }
  } 
  
}

// -----------------------------
// UPDATE
// -----------------------------

void updateDay(boolean resetArray) {
  println(" -- UPDATING DAILY TABLE -- ");
  
  if(resetArray) {
    
    for(int i = 0; i < numHandsThisDay.length; i++) {
      println("Old Daily Count Is " + numHandsThisDay[i]);
      numHandsThisDay[i] = 0;
      println("New Daily Count Is " + numHandsThisDay[i]);
    }
  }
  allHandsThisDay = 0;
  if(useGerms == false){
    for(int i = hands.size()-1; i >= 0; i--){
      hands.remove(i);
    }
  }
  
  
}

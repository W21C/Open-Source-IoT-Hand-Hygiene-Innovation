
// -----------------------------
// TABLE
// -----------------------------

/* 

Various Methods For Reading/Writing/Reorganizing Table Data

*/

void updateDay(boolean resetArray, boolean resetTable) {
  println(" -- UPDATING DAILY TABLE -- ");
  
  if(resetArray) {
    for(int i = 0; i < numHandsThisHour.length; i++) {
      println("Old Daily Count Is " + numHandsThisHour[i]);
      numHandsThisHour[i] = 0;
      println("New Daily Count Is " + numHandsThisHour[i]);
    }
    
    for(int i = 0; i < numHandsThisDay.length; i++) {
      println("Old Daily Count Is " + numHandsThisDay[i]);
      numHandsThisDay[i] = 0;
      println("New Daily Count Is " + numHandsThisDay[i]);
    }
  }
  
  
}

// -----------------------------

void updateWeek(boolean resetArray, boolean resetTable) {
  println(" -- UPDATING WEEKLY TABLE -- ");
  
  if(resetArray) {
    for(int i = 0; i < numHandsThisWeek.length; i++) {
      println("Old Weekly Count Is " + numHandsThisWeek[i]);
      numHandsThisWeek[i] = 0;
      println("New Weekly Count Is " + numHandsThisWeek[i]);
    }
    for(int i = 0; i < numHandsPerDayThisWeek.length; i++) {
      println("Old DayPerWeek Count Is " + numHandsPerDayThisWeek[i]);
      numHandsPerDayThisWeek[i] = 0;
      println("New DayPerWeek Count Is " + numHandsPerDayThisWeek[i]);
    }
  }
  
  
}

// -----------------------------

void updateMonth(boolean resetArray, boolean resetTable) {
  println(" -- UPDATING MONTHLY TABLE -- ");
  
  
  if(resetArray) {
    for(int i = 0; i < numHandsThisMonth.length; i++) {
      println("Old Weekly Count Is " + numHandsThisMonth[i]);
      numHandsThisMonth[i] = 0;
      println("New Weekly Count Is " + numHandsThisMonth[i]);
    }
    for(int i = 0; i < numHandsPerDayThisMonth.length; i++) {
      println("Old DayPerWeek Count Is " + numHandsPerDayThisMonth[i]);
      numHandsPerDayThisMonth[i] = 0;
      println("New DayPerWeek Count Is " + numHandsPerDayThisMonth[i]);
    }
  }
 
}

// -----------------------------

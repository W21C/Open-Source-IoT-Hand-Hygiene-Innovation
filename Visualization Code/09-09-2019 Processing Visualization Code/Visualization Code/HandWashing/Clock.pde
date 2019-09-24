
// -----------------------------
// CLOCK
// -----------------------------

void displayClock() {
  pushMatrix(); pushStyle();
  
  /*** DATE ***/
  
  // Style
  textFont(small); 
  textAlign(RIGHT); 
  
  // Date
  theDate  = new SimpleDateFormat("EEEEEEEE").format(date);
  theYear  = new SimpleDateFormat("yyyy").format(date);
  theMonth = new SimpleDateFormat("MMMMMMMMM").format(date);
  theDay   = new SimpleDateFormat("dd").format(date);
  
  theDate = theDate.toUpperCase();
  theMonth = theMonth.toUpperCase();
  
  String date = theDate + ", " + theMonth + " " + theDay;
  
  // Drop Shadow
  fill(dropShadowColor, 200);  
  text(date, datePositionX + 2, datePositionY + 2);
  
  // Text
  fill(textColor, 200);  
  text(date, datePositionX, datePositionY);
  
  /*** TIME ***/
  
  // Style
  textFont(large); 
  textAlign(RIGHT); 
  
  // Time
  theHour = nf(hour(), 2);
  theMin  = nf(minute(), 2);
  theSec  =  nf(second(), 2);
  
  if(hour() >= 12) {
    theMeridiem = "PM";
  }
  else if(hour() < 12) {
    theMeridiem = "AM"; 
  }
  
  time = theHour + ":" + theMin + " " + theMeridiem;
  
  // Drop Shadow
  fill(dropShadowColor, 200);  
  text(time, timePositionX + 2, timePositionY + 2);   
  
  // Text
  fill(textColor, 200);  
  text(time, timePositionX, timePositionY);   


  
  // Reset Data 
  if ((int(theHour) == 01) && ((int(theMin) == 23  )) && ((int(theSec) == 40))) {
    println("Time's up: theDay is " + theDay + " theDate is " + theDate);
        
    println("Just Resetting The Day");
    resetData();
    
  }

  // Get New Calendar
  if ((int(theHour) == 00) && ((int(theMin) == 00  )) && ((int(theSec) == 00))) {
    getCalendar(); 
  }

  
  popMatrix(); popStyle();
}

// -----------------------------

void getCalendar() {
  
  calendar = Calendar.getInstance();   
  date  = new java.util.Date(calendar.getTimeInMillis()); 
  
}


// -----------------------------
// KEY
// -----------------------------

/*KEY LEGEND
  
  GENERAL
  S = Save
  R = Reset all
  D = Daily reset
  W = Weekly reset
  M = Monthly reset
  1,2,3,4,5,6 = Trigger for hand sanitizers when useSerial is set to false
  Z = Change Drawstate
  Y = Change Subdrawstate (type of graph)
  Q = Toggle useGerms
  
  THEMES
  O = Ocean 
  G = Dogs
  A = African animals
  I = Insects
  C = Canadian animals
  T = Transport
  V = Virus/Germs
  H = Hands (original)
  F = Fantasy
  P = Paleontology (dinos)
  
  
*/  



void keyPressed() {
  println(key);
 
 

  // Trigger
  if (keyCode == '1' || key == '2' || key == '3' || key == '4' || key == '5' || key == '6' ) {
    // Get The Key #
    int id = int(KeyEvent.getKeyText(keyCode));
    // Check If The Timer Has Elapsed
    if( sanitizers[id-1].runTimeout() ) {
      sanitizers[id-1].dispenserTriggered(id-1);
    }
    else {
      println("Sorry, But Sanitizer #" + str(id-1) + " Isn't Ready To Be Triggered Again Quite Yet...");
    }
  } 
  
  // Modes
  else if (key == 'z' || key == 'Z') { // Main State
    drawState++;
    if(drawState >= 4) drawState = 1;
  }
  else if (key == 'y' || key == 'Y') { // Sub State
    subDrawState++;
    if(subDrawState >= 3) subDrawState = 1;
  }
  
  //Assign Theme Manually
  else if( key == 'o' || key == 'O'){
    if(useGerms == false){
      for (int i = hands.size()-1; i >= 0; i--) { 
        hands.remove(i);
      }
     
      for(int i = 0; i < sanitizers.length; i++) {
        // Id, Color
        sanitizers[i] = new Sanitizer(i, paletteOcean[i], oceanCreatures[i]);
//        sanitizers[i] = new Sanitizer(i, paletteOcean[int(random(0,6))], oceanCreatures[int(random(0,6))]);
      }
    }
  }
  else if( key == 'g' || key == 'G'){
    if(useGerms == false){
      for (int i = hands.size()-1; i >= 0; i--) { 
        hands.remove(i);
      }
     
      for(int i = 0; i < sanitizers.length; i++) {
        // Id, Color
        sanitizers[i] = new Sanitizer(i, paletteDogs[i], dogs[i]);
//          sanitizers[i] = new Sanitizer(i, paletteDogs[int(random(0,6))], dogs[int(random(0,6))]);
      }
    }
  }
  else if( key == 'a' || key == 'A'){
     if(useGerms == false){
      for (int i = hands.size()-1; i >= 0; i--) { 
        hands.remove(i);
      }
     
      for(int i = 0; i < sanitizers.length; i++) {
        // Id, Color
        sanitizers[i] = new Sanitizer(i, paletteAfrica[i], africanAnimals[i]);
//        sanitizers[i] = new Sanitizer(i, paletteAfrica[int(random(0,6))], africanAnimals[int(random(0,6))]);
      }
    }
  }
  else if( key == 'i' || key == 'I'){
     if(useGerms == false){
      for (int i = hands.size()-1; i >= 0; i--) { 
        hands.remove(i);
      }
     
      for(int i = 0; i < sanitizers.length; i++) {
        // Id, Color
        sanitizers[i] = new Sanitizer(i, paletteInsects[i], insects[i]);
//        sanitizers[i] = new Sanitizer(i, paletteInsects[int(random(0,6))], insects[int(random(0,6))]);
      }
    }
  }
  else if( key == 'c' || key == 'C'){
     if(useGerms == false){
      for (int i = hands.size()-1; i >= 0; i--) { 
        hands.remove(i);
      }
     
      for(int i = 0; i < sanitizers.length; i++) {
        // Id, Color
        sanitizers[i] = new Sanitizer(i, paletteCanada[i], canadianAnimals[i]);
//        sanitizers[i] = new Sanitizer(i, paletteCanada[int(random(0,6))], canadianAnimals[int(random(0,6))]);
      }
    }
  }
  else if( key == 't' || key == 'T'){
    if(useGerms == false){
      for (int i = hands.size()-1; i >= 0; i--) { 
        hands.remove(i);
      }
     
      for(int i = 0; i < sanitizers.length; i++) {
        // Id, Color
        sanitizers[i] = new Sanitizer(i, paletteTransport[i], transport[i]);
//        sanitizers[i] = new Sanitizer(i, paletteTransport[int(random(0,6))], transport[int(random(0,6))]);
      }
    }
  }
  else if(key == 'v' || key == 'V'){
   
    if(useGerms == false){
      for (int i = hands.size()-1; i >= 0; i--) { 
        hands.remove(i);
      }
     
      for(int i = 0; i < sanitizers.length; i++) {
        // Id, Color
        sanitizers[i] = new Sanitizer(i, paletteGerms[i], germs[i]);
//        sanitizers[i] = new Sanitizer(i, paletteGerms[int(random(0,6))], germs[int(random(0,6))]);
      }
    }
  }
  else if(key == 'h' || key == 'H'){
   
    if(useGerms == false){
      for (int i = hands.size()-1; i >= 0; i--) { 
        hands.remove(i);
      }
     
      for(int i = 0; i < sanitizers.length; i++) {
        // Id, Color
        sanitizers[i] = new Sanitizer(i, palette[i], "Shapes/hand.svg");
//        sanitizers[i] = new Sanitizer(i, palette[int(random(0,6))], "Shapes/hand.svg");
      }
    }
  }
  else if(key == 'f' || key == 'F'){
   
    if(useGerms == false){
      for (int i = hands.size()-1; i >= 0; i--) { 
        hands.remove(i);
      }
     
      for(int i = 0; i < sanitizers.length; i++) {
        // Id, Color
        sanitizers[i] = new Sanitizer(i, paletteFantasy[i], fantasy[i]);
//        sanitizers[i] = new Sanitizer(i, paletteFantasy[int(random(0,6))], fantasy[int(random(0,6))]);
      }
    }
  }
  else if(key == 'p' || key == 'P'){
     
    if(useGerms == false){
      for (int i = hands.size()-1; i >= 0; i--) { 
        hands.remove(i);
      }
     
      for(int i = 0; i < sanitizers.length; i++) {
        // Id, Color
        sanitizers[i] = new Sanitizer(i, paletteGerms[i], dinos[i]);
      }
    }
  }
  else if(key == 'q' || key == 'Q'){
     
    useGerms = !useGerms;
    
    if(useGerms == true){
      for (int i = hands.size()-1; i >= 0; i--) { 
        hands.remove(i);
      }
      splatter = new ArrayList();
      CreateGermArray();
  }
    else{
    
      if (splatter.size() != 0){
        for(int i = splatter.size()-1; i >= 0; i--){
        splatter.remove(i);
        }
      }
      for (int i = hands.size()-1; i >= 0; i--) { 
        hands.remove(i);
        
      }
     
      for(int i = 0; i < sanitizers.length; i++) {
        // Id, Color
        sanitizers[i] = new Sanitizer(i, palette[i], "Shapes/hand.svg");
      }
    }
  }

}

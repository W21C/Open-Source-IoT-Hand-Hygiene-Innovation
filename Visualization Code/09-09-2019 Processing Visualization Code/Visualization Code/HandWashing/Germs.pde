// -----------------------------
// GERMS
// -----------------------------

boolean useGerms;


void CreateGermArray(){
    for(int i = 0; i < germSize; i++){
    
    int prevX = newX;
    int prevY = newY;
  
    float upperXlimit = width * 0.95;
    float lowerXlimit = width * 0.05;
    float upperYlimit = height * 0.85;
    float lowerYlimit = height * 0.15;
    newX = round(random(lowerXlimit, upperXlimit));
    newY = round(random(lowerYlimit, upperYlimit));
    
    
    int germSVGNumber = int(random(0,6));
    hands.add(new TheHand(paletteGerms[germSVGNumber], newX, newY, prevX, prevY, germs[int(random(0,12))]));
    }
}

void AddGerm(){
  
      int prevX = newX;
      int prevY = newY;
  
      float upperXlimit = width * 0.95;
      float lowerXlimit = width * 0.05;
      float upperYlimit = height * 0.85;
      float lowerYlimit = height * 0.15;
      newX = round(random(lowerXlimit, upperXlimit));
      newY = round(random(lowerYlimit, upperYlimit));
    
      int germSVGNumber = int(random(0,6));
      hands.add(new TheHand(paletteGerms[germSVGNumber], newX, newY, prevX, prevY, germs[int(random(0,12))]));
}

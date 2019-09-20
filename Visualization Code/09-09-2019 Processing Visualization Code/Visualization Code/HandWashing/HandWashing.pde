// -----------------------------
// IMPORTS
// -----------------------------

import processing.serial.*;
import java.awt.Frame;
import mqtt.*;

import java.io.File;
import java.util.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.awt.event.KeyEvent;



// -----------------------------
// DECLARATIONS
// -----------------------------


ArrayList<TheHand> hands;
TheHand tempHand; 
Sanitizer[] sanitizers = new Sanitizer[7];

PFont large, medium, small;
PImage eculogo;
PImage vchlogo;
PShape handImg;


int numReadings = 50; //keeps track of how many readings you'd like to take before writing the file. 
int readingCounter = 0; //counts each reading to compare to numReadings. 
String pumpName;
String fileName;
String SerialIn; 
int batteryFlag = 1;

Calendar calendar;
java.util.Date date;


// -----------------------------
// GLOBAL VARIABLES
// -----------------------------

// Display State
int halfTimeOut = 5;
int fullTimeOut = 15;
int drawState = 1;
int subDrawState = 1;
boolean drawHands = true;

// Hand Counts
int allHandsThisHour  = 0;
int allHandsThisDay   = 0;
int allHandsThisWeek  = 0;
int allHandsThisMonth = 0;
int allHandsThisYear  = 0;

int numHandsThisHour[]   = new int[7];
int numHandsThisDay[]   = new int[7];
int numHandsThisWeek[]  = new int[7];
int numHandsThisMonth[] = new int[7];
int numHandsPerDayThisMonth[] = new int[31];
int numHandsPerDayThisWeek[] = new int[7];
int numHandsThisYear[]  = new int[7]; 


// Colours
int bgColor = 0;

color[] palette = {
  color(255, 245, 0, 201),    // Yellow
  color(255, 0, 153, 201),   // Magenta
  color(102, 255, 0, 201),    // Green
  color(0, 153, 255, 201),  // Blue
  color(204, 0, 255, 201),  // Purple
  color(255, 102, 0, 201),   // Orange
  color(245,51,71,201)
};
  
int colorNumber = 0;
int newColor;
color color1 = color(8, 90, 166);
color unitColors[] = new color[6];

color chartColor = color(255, 0, 255);       // Magenta
color dropShadowColor = color(7, 89, 164);   // PSD
color textColor = color(255, 255, 255);
  
// XY
int newX = width/2;
int newY = height/2;
int prevX = width/2;
int prevY = height/2;

// Time / Date / Text / Label Position
int datePositionX, datePositionY;
int timePositionX, timePositionY;
int textPositionX, textPositionY;

int dailyLabelPositionX, dailyLabelPositionY;
int weeklyLabelPositionX, weeklyLabelPositionY;
int monthlyLabelPositionX, monthlyLabelPositionY;

// Text Size
int countTextSize = 96;
int dateTextSize = 96;
int dailyTextSize = 48;
int weeklyTextSize = 48;
int monthlyTextSize = 48;

// Labels
String dailyLabel;
String weeklyLabel;
String monthlyLabel;

// Chart
int baseLineX, baseLineY;
int divStartX, divEndX;
int divOneY, divTwoY, divThreeY;

// Time
String theHour;
String theMin;
String theSec;
String theMeridiem;
String time;

// Date
String theDate;
String theYear;
String theMonth;
String theDay;
  
// Timer
int start;
int count = 0;
int tempSec = 0;
int tempMin = 0;
int lastMin = 0;
//int maxTempCount = 600;
int maxTempCount = 60;
// int maxVerticalHands = 30;
int maxVerticalHands = 10;



float a = 2.5, b = 3.144;
int x = width/2, y = height/2;
 
// Opacity
int op1 = 65;

//Germ implementation variables

int germSize = 60;
int germIndex = 0;
ArrayList<TheSplat> splatter;
TheSplat tempSplat;
String splatSVG = "Shapes/Germs/splat.svg";
int splatterStart;
int tempSplatSec;
int maxTempSplatCount = 10;

int value1;
//Silhouette Themes

String[] theme = new String[7];
color[] themePalette = new color[7];

String[] africanAnimals = {
 
  "Shapes/Africa/elephant.svg",    
  "Shapes/Africa/lion.svg",
  "Shapes/Africa/giraffe.svg",
  "Shapes/Africa/antelope.svg",   
  "Shapes/Africa/gorilla.svg",     
  "Shapes/Africa/hippo.svg",   
  "Shapes/Africa/cheetah.svg"
};

/* Source:

Elpahant: Natasha Sinegina. Creative Commons Attribution-Share Alike 4.0 License. Online: http://www.supercoloring.com/silhouettes/african-elephant
Antelope: Katerina Ryabsteva. Creative Commons Attribution-Share Alike 4.0 License. Online: http://www.supercoloring.com/silhouettes/antelope
Gorilla: Bob Comix. Creative Commons Attribution-Share Alike 4.0 License. Online: http://www.supercoloring.com/silhouettes/gorilla
Lion: Natasha Sinegina. Creative Commons Attribution-Share Alike 4.0 License. Online: http://www.supercoloring.com/silhouettes/african-lion
Giraffe: Bob Comix. Creative Commons Attribution-Share Alike 4.0 License. Online: http://www.supercoloring.com/silhouettes/giraffe
Hippo: Bob Comix. Creative Commons Attribution-Share Alike 4.0 License. Online: http://www.supercoloring.com/silhouettes/hippopotamus 
Cheetah: Bob Comix. Creative Commons Attribution-Share Alike 4.0 License. Online: http://www.supercoloring.com/silhouettes/cheetah

*/ 

String[] canadianAnimals = {
 
  "Shapes/Canada/bear.svg", 
  "Shapes/Canada/moose.svg",
  "Shapes/Canada/wolf.svg",
  "Shapes/Canada/beaver.svg",   
  "Shapes/Canada/bison.svg",    
  "Shapes/Canada/hare.svg",  
  ""  
  
};

/* Source:

Bear: Bob Comix. Creative Commons Attribution-Share Alike 4.0 License. Online: http://www.supercoloring.com/silhouettes/grizzly-bear?tag=57390
Beaver: Katerina Ryabsteva. Creative Commons Attribution-Share Alike 4.0 License. Online: http://www.supercoloring.com/silhouettes/beaver
Bison: Natasha Sinegina. Creative Commons Attribution-Share Alike 4.0 License. Online: http://www.supercoloring.com/silhouettes/bison
Hare: Anastasiia. Creative Commons Attribution-Share Alike 4.0 License. Online: http://www.supercoloring.com/silhouettes/arctic-hare
Moose: Anastasiia. Creative Commons Attribution-Share Alike 4.0 License. Online: http://www.supercoloring.com/silhouettes/moose-deer
Wolf: Bob Comix. Creative Commons Attribution-Share Alike 4.0 License. Online: http://www.supercoloring.com/silhouettes/wolf

*/ 

String[] oceanCreatures = {
 
  "Shapes/Ocean/dolphin.svg", 
  "Shapes/Ocean/jellyfish.svg",
  "Shapes/Ocean/seahorse.svg", 
  "Shapes/Ocean/cuttlefish.svg",    
  "Shapes/Ocean/octopus.svg",  
  "Shapes/Ocean/shark.svg",
  ""  
  
};

/* Source:

Cuttlefish: Natasha Sinegina. Creative Commons Attribution-Share Alike 4.0 License. Online: http://www.supercoloring.com/silhouettes/cuttlefish
Dolphin: Natasha Sinegina. Creative Commons Attribution-Share Alike 4.0 License. Online: http://www.supercoloring.com/silhouettes/dolphin
Jellyfish: Natasha Sinegina. Creative Commons Attribution-Share Alike 4.0 License. Online: http://www.supercoloring.com/silhouettes/jellyfish
Octopus: Natasha Sinegina. Creative Commons Attribution-Share Alike 4.0 License. Online: http://www.supercoloring.com/silhouettes/giant-octopus
Seahorse: Public domain
Shark: Nathasha Sinegina. Creative Commons Attribution-Share Alike 4.0 License. Online: http://www.supercoloring.com/silhouettes/tiger-shark

*/ 

String[] dogs = {
 
  "Shapes/Dogs/bulldog.svg",
  "Shapes/Dogs/running-dog.svg",
  "Shapes/Dogs/boxer.svg",      
  "Shapes/Dogs/cocker-spaniel.svg",    
  "Shapes/Dogs/lab.svg",  
  "Shapes/Dogs/poodle.svg",  
  
  ""  
  
};

/* Source:

Boxer: Natasha Sinegina. Creative Commons Attribution-Share Alike 4.0 License. Online: http://www.supercoloring.com/silhouettes/boxer-dog-sitting
Bulldog: Natasha Sinegina. Creative Commons Attribution-Share Alike 4.0 License. Online: http://www.supercoloring.com/silhouettes/french-bulldog?tag=57353
Cocker Spaniel: Bob Comix. Creative Commons Attribution-Share Alike 4.0 License. Online: http://www.supercoloring.com/silhouettes/cocker-spaniel?tag=57353
Lab: Natasha Sinegina. Creative Commons Attribution-Share Alike 4.0 License. Online: http://www.supercoloring.com/silhouettes/labrador
Poodle: Bob Comix. Creative Commons Attribution-Share Alike 4.0 License. Online: http://www.supercoloring.com/silhouettes/standard-poodle?tag=57353
Running Dog: Nathasha Sinegina. Creative Commons Attribution-Share Alike 4.0 License. Online: http://www.supercoloring.com/silhouettes/dog-running

*/ 

String[] insects = {
 
  "Shapes/Insects/bee.svg",    
  "Shapes/Insects/butterfly.svg", 
  "Shapes/Insects/praying-mantis.svg",
  "Shapes/Insects/dragonfly.svg",    
  "Shapes/Insects/grasshopper.svg",  
  "Shapes/Insects/wasp.svg",
  ""  
  
};

/* Source:

Bee: Bob Comix. Creative Commons Attribution-Share Alike 4.0 License. Online: http://www.supercoloring.com/silhouettes/honeybee
Butterfly: Bob Comix. Creative Commons Attribution-Share Alike 4.0 License. Online: http://www.supercoloring.com/silhouettes/small-tortoiseshell-butterfly
Dragonfly: Natasha Sinegina. Creative Commons Attribution-Share Alike 4.0 License. Online: http://www.supercoloring.com/silhouettes/dragonfly
Grasshopper: Bob Comix. Creative Commons Attribution-Share Alike 4.0 License. Online: http://www.supercoloring.com/silhouettes/grasshopper
Praying Mantis: Natasha Sinegina. Creative Commons Attribution-Share Alike 4.0 License. Online: http://www.supercoloring.com/silhouettes/praying-mantis
Wasp: Nathasha Sinegina. Creative Commons Attribution-Share Alike 4.0 License. Online: http://www.supercoloring.com/silhouettes/wasp

*/ 

String[] transport = {
 
     
  "Shapes/Transport/helicopter.svg",    
  "Shapes/Transport/tow-truck.svg",  
  "Shapes/Transport/trail-bike.svg",
  "Shapes/Transport/sport-bike.svg",
  "Shapes/Transport/fire-engine.svg",
  "Shapes/Transport/airbus.svg",    
  //"Shapes/Transport/tractor.svg",
  " "  
  
};
/* Source:

Airbus: Natasha Sinegina. Creative Commons Attribution-Share Alike 4.0 License. Online: http://www.supercoloring.com/silhouettes/airbus-a350
Tractor: Bob Comix. Creative Commons Attribution-Share Alike 4.0 License. Online: http://www.supercoloring.com/silhouettes/tractor
Helicopter: Katerina Ryabtseva. Creative Commons Attribution-Share Alike 4.0 License. Online: http://www.supercoloring.com/silhouettes/helicopter
Sport Bike: Bob Comix. Creative Commons Attribution-Share Alike 4.0 License. Online: http://www.supercoloring.com/silhouettes/sportbike
Tow Truck: Bob Comix. Creative Commons Attribution-Share Alike 4.0 License. Online: http://www.supercoloring.com/silhouettes/tow-truck
Trail bike: Bob Comix. Creative Commons Attribution-Share Alike 4.0 License. Online: http://www.supercoloring.com/silhouettes/trail-bike
Fire Engine: Natasha Sinegina. Creative Commons Attribution-Share Alike 4.0 License. Online: http://www.supercoloring.com/silhouettes/fire-engine

*/ 

String[] fantasy = {
  
 
 "Shapes/Fantasy/dragon.svg",
 "Shapes/Fantasy/unicorn.svg",
 "Shapes/Fantasy/phoenix.svg",
 "Shapes/Fantasy/witch.svg",
 "Shapes/Fantasy/merman.svg",
 "Shapes/Fantasy/fairy.svg",
 ""
  
};

/* Source:

Merman: Natasha Sinegina. Creative Commons Attribution-Share Alike 4.0 License. Online: http://www.supercoloring.com/silhouettes/merman
Dragon: Natasha Sinegina. Creative Commons Attribution-Share Alike 4.0 License. Online: http://www.supercoloring.com/silhouettes/dragon
Fairy: Natasha Sinegina. Creative Commons Attribution-Share Alike 4.0 License. Online: http://www.supercoloring.com/silhouettes/fairy
Phoenix: Natasha Sinegina. Creative Commons Attribution-Share Alike 4.0 License. Online: http://www.supercoloring.com/silhouettes/phoenix
Witch:Natasha Sinegina. Creative Commons Attribution-Share Alike 4.0 License. Online: http://www.supercoloring.com/silhouettes/flying-witch
Unicorn: Natasha Sinegina. Creative Commons Attribution-Share Alike 4.0 License. Online: http://www.supercoloring.com/silhouettes/unicorn-0

*/ 

String[] dinos = {
 "Shapes/Dinosaurs/puertasaurus.svg",
 "Shapes/Dinosaurs/raptor.svg",
 "Shapes/Dinosaurs/triceratops.svg",
 "Shapes/Dinosaurs/ankylosaurus.svg",
 "Shapes/Dinosaurs/parasaurolophus.svg",
 "Shapes/Dinosaurs/tRex.svg",
 ""
  
};
//Dinosaur SVG's made by Rachel DiMaio

String[] germs = {
 
  "Shapes/Germs/eColi.svg",
  "Shapes/Germs/cDiff.svg", 
  "Shapes/Germs/staph.svg",
  "Shapes/Germs/hPylori.svg",
  "Shapes/Germs/TB.svg",
  "Shapes/Germs/ebola.svg",
  "Shapes/Germs/strep.svg",
  "Shapes/Germs/germ2.svg", 
  "Shapes/Germs/germ3.svg",      
  "Shapes/Germs/germ2.svg",       
  "Shapes/Germs/germ4.svg",    
  "Shapes/Germs/germ5.svg",      
  ""  
  
};
//Germ SVG's made by Rachel DiMaio


//Theme Color Palettes

color[] paletteAfrica = {
  color(255, 200, 0, 201), 
  color(255, 120, 0, 201),
  color(255, 40, 0, 201),
  color(255, 160, 0, 201), 
  color(255, 80, 0, 201),
  color(255, 0, 0, 201),
  color(255, 0)
};

color[] paletteCanada = {
  
  color(0, 150, 0, 201), 
  color(0, 150, 80, 201),
  color(0, 150, 160, 201),
  color(0, 150, 40, 201),
  color(0, 150, 120, 201),
  color(0, 150, 200, 201),
  color(255, 0)
  
};

color[] paletteOcean = {
  
  color(40, 0, 150, 201), 
  color(120, 0, 150, 201),
  color(200, 0, 150, 201),
  color(80, 0, 150, 201), 
  color(160, 0, 150, 201), 
  color(0, 0, 150, 201), 
  color(255, 0)
};

color[] paletteDogs = {
   
  color(80, 255, 140, 201),
  color(170, 80, 255, 201), 
  color(255, 80, 85, 201),
  color(80, 110, 255, 201), 
  color(240, 255, 80, 201), 
  color(255, 160, 80, 201), 
  color(255, 0)
};

color[] paletteInsects = {

  color(15, 200, 220, 201), 
  color(120, 15, 220, 201), 
  color(125, 220, 15, 201),
  color(220, 15, 15, 201), 
  color(15, 35, 220, 201),
  color(220, 190, 15, 201), 
  color(255, 0)
};

color[] paletteTransport = {

  color(220, 15, 15, 201), 
  color(15, 35, 220, 201), 
  color(220, 190, 15, 201),
  color(15, 200, 220, 201),
  color(120, 15, 220, 201), 
  color(125, 220, 15, 201),
  color(255, 0)
};

color[] paletteGerms = {
  color(232, 114, 23, 201),
  color(232, 65, 23, 201),  
  color(23, 232, 25, 201), 
  color(200, 232, 23, 201), 
  color(232, 191, 23, 201), 
  color(23, 115, 232, 201), 
  color(232, 23, 100, 255)
};

color[] paletteFantasy = {
  color(245, 221, 101, 201), 
  color(101, 205, 245, 201), 
  color(245, 101, 101, 201), 
  color(245, 101, 212, 201), 
  color(120, 101, 245, 201), 
  color(101, 245, 117, 201), 
  color(255, 0)
};

color[] paletteDinos = {
  color(237, 177, 12, 201), 
  color(237, 240, 12, 201), 
  color(237, 140, 12, 201), 
  color(12, 237, 0, 201), 
  color(100, 237, 0, 201), 
  color(200, 237, 0, 201), 
  color(255, 0)
};



// -----------------------------
// SETUP
// -----------------------------

void setup() {
  // Screen
  //size(displayWidth, displayHeight, JAVA2D);
  fullScreen();
  surface.setResizable(true);
  smooth();

  // Font
  large  = loadFont("Fonts/Knockout-HTF49-Liteweight-96.vlw"); 
  medium = loadFont("Fonts/Knockout-HTF49-Liteweight-72.vlw"); 
  small  = loadFont("Fonts/Knockout-HTF49-Liteweight-48.vlw"); 

  
  textPositionX = int(width * .15);
  textPositionY = int(height * .15);
  datePositionX = int(width - (width * .15));
  datePositionY = int(height *.20);
  timePositionX = int(width - (width * .15));
  timePositionY = int(height * .15);
  
  dailyLabelPositionX = int(width / 2);
  dailyLabelPositionY = int(height - (height * .15));
  weeklyLabelPositionX = int(width / 2);
  weeklyLabelPositionY = int(height - (height * .15));
  monthlyLabelPositionX = int(width / 2);
  monthlyLabelPositionY = int(height - (height * .15)); 

  
  //MQTT IMPLEMENTATION
  client = new MQTTClient(this);
  client.connect("mqtt://MQTT_Username:MQTT_Password@Broker_IP", "processing1");
  // client.connect("mqtt://IP_Address", "Client_Name"); //Use this line of code instead of the previous line when you have not set up a username / password
  client.subscribe("pumpID");
  
  // Hands
  hands = new ArrayList<TheHand>();
 
  useGerms = false;

  
  //GERM IMPLEMENTATION
  if(useGerms == true){
    splatter = new ArrayList();
    CreateGermArray();
  }
  
  AssignTheme();

  // Logos
  eculogo = loadImage("Logos/EmilyCarr_White_Logo_Large.png");
  vchlogo = loadImage("Logos/W21C Logo.png");
 
  
  // Calendar
  getCalendar();


  // Misc
  start = millis();
  ellipseMode(CENTER); 
  
  if(useGerms == true){
     splatterStart = millis(); 
  }
  
  // Chart
  baseLineX = textPositionX;
  baseLineY = int(height - (height * .30));
  divStartX = textPositionX;
  divEndX = width - textPositionX;
  divOneY = int(height - (height * .40));
  divTwoY = int(height - (height * .50)); 
  divThreeY = int(height - (height * .60));
  
  
  
  println("");
  println("---- End Of Setup ----");
  println("");
  
} /* End Of Setup() */








 

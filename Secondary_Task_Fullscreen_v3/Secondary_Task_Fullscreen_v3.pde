// play this on a screen in front of the subject doing the block experiment

// all dots will be the same size
int dotSize = 60;
int len = 200;
int n = 0;

// bool to toggle looping
boolean looping = false;

// make a lil' timer
int startTime = 0;
int stopTime = 0;
int lastChangeTime = 0; // NEW: Replaces delay() to track time smoothly

// Define our color options and put them in an array
color yellow = color(255, 204, 0);
color red  = color(201,0,0);
color blue = color(0,128,222);
color black = color(0);
color[] colors = {yellow, red, blue, black};

// Define our speeds and put them in an array
int xfast = 500;
int fast = 1000;
int medium = 2000;
int slow = 3000;
int xslow = 4000;
int[] waitSpeeds = {xfast, fast, medium, slow, xslow};

// add a scalar value to allow changes to wait times
float scalar = 0.699;//1.00;

//we are going to pregenerate a list of values for each value, length l
// build empty arrays of int to store them
int[] randShape = new int[len];
int[] randColor = new int[len];
int[] randVis = new int[len];
int[] randWait = new int[len];
int[] randX = new int[len];
int[] randY = new int[len];

void setup () {
  // make a full black screen (Assuming you are dragging with Alt+F7)
  fullScreen();
  background(0);
  
  // build our list of integers where every other one is blank
  // all i's are blanks, all k's are shapes
  for (int i = 0; i <len-1; i = i+2){
    int k = i + 1;
    randShape[k] = floor(random(2));
    randShape[i] = 0; 
    randColor[k] = floor(random(3));
    randColor[i] = 3; // the 3rd color in the color array is black ;)
    randWait[k] = floor(random(4));
    randWait[i] = floor(random(2,5));
    randX[k] = floor(random(2*dotSize, width-(2*dotSize))); 
    randX[i] = floor(width/2);
    randY[i] = floor(height/2);
    randY[k] = floor(random(2*dotSize, height-(2*dotSize))); 
  }
  print("Program initiated.\n");
  noLoop();
}

// draw cycle repeats forever unless you tell it not to
void draw () {
  // 1. Reassert the background to clear the screen
  background(0);  
  
  // 2. Draw your shape DIRECTLY to the screen
  fill(colors[randColor[n]]);
  noStroke();
  
  if (randShape[n] == 0){    // 0 is a circle
    circle(randX[n],randY[n], dotSize);
  }
  else { // 1 is a square
    square(randX[n], randY[n], dotSize);
  }
  
  // 3. Smooth Timer Logic (No freezing!)
  int currentDelay = round(scalar * waitSpeeds[randWait[n]]);
  
  // Check if enough milliseconds have passed to move to the next shape
  if (millis() - lastChangeTime >= currentDelay) {
    if (n < len - 1){
      n = n + 1;
    }
    else{ 
      n = 0; // it'll repeat after len cycles
    }
    // Reset the timer for the next shape
    lastChangeTime = millis();
  }
}

// add some button pressing commands
void keyPressed(){

  // we only want it to respond to specific keys
  if (key == CODED){
    // the down key makes the speed slower 
    if (keyCode == DOWN){
      scalar = scalar + 0.1;
      print("\nTime scalar:\t" + scalar);
    }
    
    // the up key makes the speed faster
    else if (keyCode == UP){
      if (scalar > 0.1){
        scalar = scalar - 0.1;
      }
      else{
        scalar = 0.1;
      }
      print("\nTime scalar:\t" + scalar);
    }
    else if (keyCode == RIGHT){
      looping = true;
      startTime = millis();
      lastChangeTime = millis(); // Start the shape timer fresh!
      loop();
      print("\n\nLooping engaged\n");
    }
    else if(keyCode == LEFT){
      looping = false;
      stopTime = millis();
      noLoop();
      int runTime = stopTime - startTime;
      print("\n\nLooping disengaged\n\nTime of run in ms:\t" + runTime + "\n");
    }
  }
}

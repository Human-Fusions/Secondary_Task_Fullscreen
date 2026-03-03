// play this on a screen in front of the subject doing the block experiment

// all dots will be the same size
int dotSize = 60;
int len = 200;
int n = 0;

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

//we are going to pregenerate a list of values for each value, length l
// build empty arrays of int to store them
int[] randShape = new int[len];
int[] randColor = new int[len];
int[] randVis = new int[len];
int[] randWait = new int[len];
int[] randX = new int[len];
int[] randY = new int[len];

// make a graphic to store the dot
PGraphics dot;

void setup () {
  // make a full black screen
  fullScreen();
  background(0);
  
  //initateour graphic
  dot = createGraphics(width, height);

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
    randX[k] = floor(random(width));
    randX[i] = floor(width/2);
    randY[i] = floor(height/2);
    randY[k] = floor(random(height));
  }
  
}

// draw cycle repeats forever unless you tell it not to
void draw () {

  //reassert the background or the old shape stays around
  background(0);  
  
  // draw your dot given the values for this round (n)
  dot.beginDraw();
  dot.fill(colors[randColor[n]]);
  dot.noStroke();
  
  if (randShape[n] == 0){    //0 is a circle
    dot.circle(randX[n],randY[n], dotSize);
  }
  else { // 1 is a square
    dot.square(randX[n], randY[n], dotSize);
  }
  
  // this finishes up the drawing
  dot.endDraw();
  
  // image makes the graphic actually appear
  image(dot, dotSize, dotSize);
  
  //unclear if I actually need the clear command
  dot.clear();
  
  //delay at the end* for clarity (*almost)
  delay(waitSpeeds[randWait[n]]);
  
  // finally update the value of n
  if (n<len){
    n = n+1;
  }
  else{ // it'll repeat after len cycles
  n = 0;
  }
}

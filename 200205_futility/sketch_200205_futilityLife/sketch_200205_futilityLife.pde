ArrayList<Line> population = new ArrayList();

void setup() {
  fullScreen();
  noCursor();
  smooth();
  background(0);

  int pplMax = 100;

  for (int i=0; i<pplMax; i++) {
    int x = (int)random(width);
    int y = (int)random(height);
    population.add(new Line(x, y));
  }
}

void draw() {

  for (Line line : population) {
    line.grow();
  }
//this records an image every 5 minutes for 2 hours, increase the number of imgMax to increase time (12 = 1 hour case 12 * 5 =  60min
  int imgMax = 24;
  for (int i = 0; i < imgMax; i++) {
    if (frameCount >= 17999.99 * i && frameCount <= 18000.01 * i) 
      save("futility" + i + ".jpg");
  }
  println(frameCount);
}



class Line {
  float x, y;

  Line (float xLine, float yLine) {
    x = xLine;
    y = yLine;
  }  

  float Length = 5;

  int numGenerate() {
    int numOptions = 8; //four potential placements = left, right, top, bottom
    return (int)random(1, numOptions + 1);
  }

  int[] colorOptions = {0, 255};
  int index = int(random(colorOptions.length));

  boolean drawnRight = false;
  boolean drawnLeft = false;
  boolean drawnUp = false;
  boolean drawnDown = false;
  boolean drawnUpRight = false;
  boolean drawnDownRight = false;
  boolean drawnUpLeft = false;
  boolean drawnDownLeft = false;

  float whiteOpacity = 10;

  float blackOpacity = 2*whiteOpacity;

  void grow() {


    int pos=numGenerate();

    switch(pos) {
    case 1 : //draw right
      if (drawnLeft) {
        x += Length;
        stroke(0, blackOpacity);
        line(x, y, x-Length, y);
        drawnLeft = false;
        drawnRight = true;
      } else {
        x += Length; 
        stroke(255, whiteOpacity);
        line(x, y, x-Length, y);
        drawnRight = true;
      }
      break; 
    case 2 : //draw left
      if (drawnRight) {
        x -= Length;
        stroke(0, blackOpacity);
        line (x, y, x-Length, y);
        drawnRight = false;
        drawnLeft = true;
      } else {
        x -= Length;
        stroke(255, whiteOpacity);
        line(x, y, x+Length, y);
        drawnLeft = true;
      }
      break; 
    case 3 : //up
      if (drawnDown) {
        y -= Length;
        stroke(0, blackOpacity);
        line(x, y, x, y+Length);
        drawnDown = false;
        drawnUp = true;
      } else { 
        y -= Length;
        stroke(255, whiteOpacity);
        line(x, y, x, y+Length);
        drawnUp = true;
      }
      break;
    case 4:  //down
      if (drawnUp) {
        y += Length;
        stroke(0, blackOpacity);
        line(x, y, x, y-Length);
        drawnUp = false;
        drawnDown = true;
      } else {
        y += Length;
        stroke(255, whiteOpacity);
        line(x, y, x, y-Length);
        drawnDown = true;
      }
      break;
    case 5:  //down right
      if (drawnUpLeft) {
        x += Length;
        y += Length;
        stroke(0, blackOpacity);
        line(x, y, x-Length, y-Length);
        drawnUpLeft = false;
        drawnDownRight = true;
      } else {
        x += Length;
        y += Length;
        stroke(255, whiteOpacity);
        line(x, y, x-Length, y-Length);
        drawnDownRight = true;
      }
      break;
    case 6:  //up right
      if (drawnDownLeft) {
        x += Length;
        y -= Length;
        stroke(0, blackOpacity);
        line(x, y, x-Length, y+Length);
        drawnDownLeft = false;
        drawnUpRight = true;
      } else {
        x += Length;
        y -= Length;
        stroke(255, whiteOpacity);
        line(x, y, x-Length, y+Length);
        drawnUpRight = true;
      }
      break;
    case 7:  //up left
      if (drawnDownRight) {
        x -= Length;
        y -= Length;
        stroke(0, blackOpacity);
        line(x, y, x+Length, y+Length);
        drawnUpLeft = true;
        drawnDownRight = false;
      } else { 
        x -= Length;
        y -= Length;
        stroke(255, whiteOpacity);
        line(x, y, x+Length, y+Length);
        drawnUpLeft = true;
      }
      break;
    case 8:  //down left
      if (drawnUpRight) {
        x -= Length;
        y +=Length;
        stroke(0, blackOpacity);
        line(x, y, x+Length, y-Length);
        drawnUpRight = false;
        drawnDownLeft = true;
      } else {      
        x -= Length;
        y +=Length;
        stroke(255, whiteOpacity);
        line(x, y, x+Length, y-Length);
        drawnDownLeft = true;
      }

      x = constrain(x, 0, width);
      y = constrain(y, 0, height);
    }
  }
}

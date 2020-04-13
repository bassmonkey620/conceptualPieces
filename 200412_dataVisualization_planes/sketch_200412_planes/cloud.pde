class Cloud {
  //Variables for position, size, opacity, and rotation speed.
  float x, y, size; 
  //Constructor. We'll want everything to be changeable because beauty is in the eye of the beholder.
  Cloud (float centerX, float centerY, float sizeCloud) {
    x = centerX; 
    y = centerY; 
    size = sizeCloud; 
  }

  //Just a display function is needed.
  void display() {
    
  rectMode(CENTER);
  fill(200);
  noStroke();

  rect(x, y, 1.8*size, size);
  circle(x+size, y, size);
  circle(x-size, y, size);
  
  circle(x-.5*size, y - .9*size, 1.4*size);
  circle(x + .7*size, y - .6*size, size);
  circle(x + .3*size, y - .9*size, 1.2*size);
               //and fade it, too.
  }
}

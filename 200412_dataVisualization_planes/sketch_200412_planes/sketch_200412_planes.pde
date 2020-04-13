//code for data visualization of planes over area of earth
//data taken from planeradar24.com

//array list of clouds for display each frame
ArrayList<Cloud> clouds = new ArrayList<Cloud>(1);
//cloud variables
float centerX, centerY, size;

//array for plane data
float planeData[];
//var for position within that array
int dataPos;

//background img
PImage UAE;

void setup() {

  //size based on background img
  size(1381, 1073);

  UAE = loadImage("Background.png");

  //load .csv data into string
  String planeNum[] = loadStrings("200412_planeData.csv");
  //split up string and add data into plane data array
  planeData = float (split(planeNum[0], ','));

  //set cloud size, arbitrary
  size =50;

  //initialize position within data array
  dataPos = 0;
}

void draw() {

  //defensive if statement
  //keeps it from bugging out at the end
  if (dataPos < 52) {
    //call the image each frame
    image(UAE, 0, 0);

    //each frame, iterate create number of clouds
    //according to data value at position within data array
    for (int i = 0; i < planeData[dataPos]; i++) {
      centerX = random(width);                          //randomize position
      centerY = random(height);
      clouds.add(new Cloud(centerX, centerY, size));    //add cloud to clouds
      Cloud cloud = clouds.get(clouds.size() - 1);      //access that cloud
      cloud.display();                                  //display that cloud
    }

    //move to the next data position (next week)
    dataPos ++;

    //for error checking
    println(planeData[dataPos]);

    //capture frames for video
    saveFrame();
  }
}

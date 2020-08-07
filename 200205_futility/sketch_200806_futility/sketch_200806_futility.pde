private ArrayList<Person> people;

void setup() {
  fullScreen();
  background(0);

  people = new ArrayList<Person>();
  int pplMax = 1000;
  for (int pplNum = 0; pplNum < pplMax; pplNum++) {
    int randX = (int)random(width);
    int randY = (int)random(height);
    Person newPerson = new Person(randX, randY);
    people.add(newPerson);
  }
}

void draw() {
  for (Person person : people) person.makeMove();
}

class Move {

  private String direction;

  public Move(String moveChoice) {
    direction = moveChoice;
  }

  public String getDirection() {
    return direction;
  }

  public void setDirection(String moveChoice) {
    direction = moveChoice;
  }
}

class Place {

  private int x;
  private int y;
  private color placeColor;
  public int placeDiameter;

  public Place(int xPos, int yPos) {
    x = xPos;
    y = yPos;
    placeColor = color(0, 0);
    placeDiameter = 2;
  }

  public void strengthen() {
    placeColor = color(255, 10);
  }

  public void weaken() {
    placeColor = color(0, 10);
  }

  public int getXPos() {
    return x;
  }

  public int getYPos() {
    return y;
  }

  public void update() {
    fill(placeColor);
    noStroke();
    circle(x, y, placeDiameter);
  }
}

class Legacy {

  private ArrayList<Move> moves;

  private Legacy() {
    moves = new ArrayList<Move>();
  }

  public ArrayList<Move> getMoves() {
    return  moves;
  }

  public void printMoves() {
    for (Move move : moves) {
      String moveDirection = move.getDirection();
      println(moveDirection);
    }
  }

  public void addMove(Move move) {
    moves.add(move);
  }

  public void removeMove(int movesIndex) {
    moves.remove(movesIndex);
  }

  private String compareThisMoveToEnd(Move moveChecking, int comparisonIndex) {

    String directionChecking = moveChecking.getDirection();

    Move moveComparing = moves.get(moves.size()-comparisonIndex);
    String directionComparing = moveComparing.getDirection();

    String oppositeMove = "noOpp";

    switch(directionComparing) {
    case "right":
      oppositeMove = "left";
      break;

    case "left":
      oppositeMove = "right";
      break;

    case "down":
      oppositeMove = "up";
      break;

    case "up":
      oppositeMove = "down";
      break;
    case "upRight":
      oppositeMove = "downLeft";
      break;

    case "upLeft":
      oppositeMove = "downRight";
      break;

    case "downRight":
      oppositeMove = "upLeft";
      break;

    case "downLeft":
      oppositeMove = "upRight";
      break;
    }

    if (directionChecking == oppositeMove) return "opposite";
    else return "notOpposite";
  }
}

class Person {
  private Legacy legacy;
  private Place currentPlace;
  public boolean movingBack;

  private int x;
  private int y;

  public Person(int homeX, int homeY) {
    x = homeX;
    y = homeY;
    legacy = new Legacy();
    currentPlace = new Place(x, y);
    movingBack = false;
  }

  public String checkBackward(Move moveChecking) {
    ArrayList<Move> myMoves = legacy.getMoves();

    if (!myMoves.isEmpty()) {

      if (!movingBack || myMoves.size() == 1) {
        String moveState = legacy.compareThisMoveToEnd(moveChecking, 1);

        if (moveState == "opposite") {
          movingBack = true;
          return "backward1";
        } else return "forward";
      }

      if (movingBack && myMoves.size() > 1) {
        String moveState1 = legacy.compareThisMoveToEnd(moveChecking, 1);
        String moveState2 = legacy.compareThisMoveToEnd(moveChecking, 2);

        if (moveState1 == "opposite" || moveState2 == "opposite") {
          movingBack = true;
          return "backward2";
        } else {
          movingBack = false;
          return "forward";
        }
      } else return "error";
    } else return "forward";
  }

  private String chooseMove() {
    int moveDis = currentPlace.placeDiameter;
    String moveDir = "noDir";

    int moveIndex = (int)random(8);

    switch(moveIndex) {
    case 0:
      x+=moveDis;
      moveDir = "right";
      break;
    case 1:
      x-=moveDis;
      moveDir = "left";
      break;
    case 2:
      y+=moveDis;
      moveDir = "down";
      break;
    case 3:
      y-=moveDis;
      moveDir = "up";
      break;
    case 4:
      x+=moveDis;
      y+=moveDis;
      moveDir = "downRight";
      break;
    case 5:
      x-=moveDis;
      y+=moveDis;
      moveDir = "downLeft";
      break;
    case 6:
      x-=moveDis;
      y-=moveDis;
      moveDir = "upLeft";
      break;
    case 7:
      x+=moveDis;
      y-=moveDis;
      moveDir = "upRight";
      break;
    }


    return(moveDir);
  }

  public void makeMove() {
    String moveDirection = chooseMove();

    Move newMove = new Move(moveDirection);
    currentPlace = new Place(x, y);
    String moveState = checkBackward(newMove);

    if (moveState == "backward1") {
      currentPlace.weaken();
      legacy.removeMove(legacy.moves.size() - 1);
    } else if (moveState == "backward2") {
      currentPlace.weaken();
      legacy.removeMove(legacy.moves.size() -1);
      legacy.removeMove(legacy.moves.size() - 1);
    } else if (moveState == "forward") {
      currentPlace.strengthen();
    }

    currentPlace.update();
    legacy.addMove(newMove);
  }
  //FOR TESTING

  //public void makeMove(String direction) {
  //  int moveDis = currentPlace.placeDiameter;
  //  String moveDir = "noDir";

  //  switch(direction) {
  //  case "right":
  //    x+=moveDis;
  //    moveDir = "right";
  //    break;
  //  case "left":
  //    x-=moveDis;
  //    moveDir = "left";
  //    break;
  //  case "down":
  //    y+=moveDis;
  //    moveDir = "down";
  //    break;
  //  case "up":
  //    y-=moveDis;
  //    moveDir = "up";
  //    break;
  //  }

  //  Move newMove = new Move(moveDir);
  //  currentPlace = new Place(x, y);
  //  String moveState = checkBackward(newMove);

  //  if (moveState == "backward1") {
  //    currentPlace.weaken();
  //    legacy.removeMove(legacy.moves.size() - 1);
  //  } else if (moveState == "backward2") {
  //    currentPlace.weaken();
  //    legacy.removeMove(legacy.moves.size() -1);
  //    legacy.removeMove(legacy.moves.size() -1);
  //  } else if (moveState == "forward") {
  //    currentPlace.strengthen();
  //  }

  //  currentPlace.update();
  //  legacy.addMove(newMove);
  //}
}

var people;
var bgColor = 255;
function setup() {

  createCanvas(1080,1080);
  background(bgColor);

  people = [];
  var pplMax = 100;

  for (var pplNum = 0; pplNum < pplMax; pplNum++) {
    var randX = random(width);
    var randY = random(height);
    
    var newPerson = new Person(randX,randY);
    people.push(newPerson);
   }
}

function draw() {
  for(var person of people) person.makeMove(); 
}


class Move {
  constructor(moveChoice) {

    this.direction = moveChoice;

    this.getDirection = function () {
      return this.direction;
    };

    this.setDirection = function (moveChoice) {
      this.direction = moveChoice;
    };
  }
}


class Place {
  constructor(xpos, ypos) {
    this.x = xpos;
    this.y = ypos;
    this.placeColor = color(0, 0);
    this.placeDiameter = 1;

    this.strengthen = function (strongRed, strongGreen, strongBlue) {
      this.placeColor = color(strongRed, strongGreen, strongBlue, 10);
    };

    this.weaken = function () {
      this.placeColor = color(bgColor, 10);
    };

    this.getXPos = function () {
      return this.x;
    };

    this.getYPos = function () {
      return this.y;
    };

    this.update = function () {
      fill(this.placeColor);
      noStroke();
      circle(this.x, this.y, this.placeDiameter);
    };
  }
}

class Legacy {
  constructor() {
    this.moves = [];

    this.getMoves = function () {
      return this.moves;
    };

    this.printMoves = function () {
      for (var move in this.moves) {
        var moveDirection = move.getDirection();
        println(moveDirection);
      }
    };

    this.addMove = function (move) {
      this.moves.push(move);
    };

    this.removeMove = function (movesIndex) {
      this.moves.splice(movesIndex, 1);
    };

    this.compareThisMoveToEnd = function (moveChecking, comparisonIndex) {

      var directionChecking = moveChecking.getDirection();

      var moveComparing = this.moves[this.moves.length - comparisonIndex];

      var directionComparing = moveComparing.getDirection();

      var oppositeMove = "noOpp";

      switch (directionComparing) {
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

      if (directionChecking == oppositeMove)
        return "opposite";
      else
        return "notOpposite";
    };
  }
}


class Person {
  constructor(homeX, homeY) {

    this.x = homeX;
    this.y = homeY;
    this.legacy = new Legacy();
    this.currentPlace = new Place(this.x, this.y);
    this.movingBack = false;
    this.myRed = random(50,250);
    this.myGreen = random(50,250);
    this.myBlue = random(50,250);

    this.checkBackward = function (moveChecking) {
      var myMoves = this.legacy.getMoves();

      if (myMoves.length > 0) {

        if (!this.movingBack || myMoves.length == 1) {
          var moveState = this.legacy.compareThisMoveToEnd(moveChecking, 1);

          if (moveState == "opposite") {
            this.movingBack = true;
            return "backward1";
          }
          else
            return "forward";
        }

        if (this.movingBack && myMoves.length > 1) {
          var moveState1 = this.legacy.compareThisMoveToEnd(moveChecking, 1);
          var moveState2 = this.legacy.compareThisMoveToEnd(moveChecking, 2);

          if (moveState1 == "opposite" || moveState2 == "opposite") {
            this.movingBack = true;
            return "backward2";
          }
          else {
            this.movingBack = false;
            return "forward";
          }
        }
        else
          return "error";
      }
      else
        return "forward";
    };

    this.chooseMove = function () {
      var moveDis = this.currentPlace.placeDiameter;
      var moveDir = "noDir";

      var moveIndex = int(random(8));

      switch (moveIndex) {
        case 0:
          this.x += moveDis;
          moveDir = "right";
          break;
        case 1:
          this.x -= moveDis;
          moveDir = "left";
          break;
        case 2:
          this.y += moveDis;
          moveDir = "down";
          break;
        case 3:
          this.y -= moveDis;
          moveDir = "up";
          break;
        case 4:
          this.x += moveDis;
          this.y += moveDis;
          moveDir = "downRight";
          break;
        case 5:
          this.x -= moveDis;
          this.y += moveDis;
          moveDir = "downLeft";
          break;
        case 6:
          this.x -= moveDis;
          this.y -= moveDis;
          moveDir = "upLeft";
          break;
        case 7:
          this.x += moveDis;
          this.y -= moveDis;
          moveDir = "upRight";
          break;
      }


      return moveDir;
    };

    this.checkBounds = function () {
      var posState = "in";

      if (this.x < 0 && this.y >= 0 && this.y <= height)
        posState = "outLeft";
      if (this.x > width && this.y >= 0 && this.y <= height)
        posState = "outRight";
      if (this.y < 0 && this.x >= 0 && this.x <= width)
        posState = "outUp";
      if (this.y > height && this.x >= 0 && this.x <= width)
        posState = "outDown";

      if (this.x < 0 && this.y < 0)
        posState = "outLeftUp";
      if (this.x < 0 && this.y > height)
        posState = "outLeftDown";
      if (this.x > width && this.y < 0)
        posState = "outRightUp";
      if (this.x > width && this.y > height)
        posState = "outRightDown";
      else
        posState = "in";

      return posState;
    };

    this.revolve = function (posState) {

      switch (posState) {
        case "outLeft":
          this.x += width;
          break;
        case "outRight":
          this.x -= width;
          break;
        case "outDown":
          this.y -= height;
          break;
        case "outUp":
          this.y += height;
          break;

        case "outLeftUp":
          this.x += width;
          this.y += height;
          break;
        case "outLeftDown":
          this.x += width;
          this.y -= height;
          break;
        case "outRightUp":
          this.x -= width;
          this.y += height;
          break;
        case "out RightDown":
          this.x -= width;
          this.y -= height;
          break;
      }
    };

    this.makeMove = function () {
      var moveDirection = this.chooseMove();

      var boundsCheck = this.checkBounds();

      if (boundsCheck != "in")
        this.revolve(boundsCheck);

      var newMove = new Move(moveDirection);
      this.currentPlace = new Place(this.x, this.y);
      var moveState = this.checkBackward(newMove);

      if (moveState == "backward1") {
        this.currentPlace.weaken();
        this.legacy.removeMove(this.legacy.moves.length - 1);
      }
      else if (moveState == "backward2") {
        this.currentPlace.weaken();
        this.legacy.removeMove(this.legacy.moves.length - 1);
        this.legacy.removeMove(this.legacy.moves.length - 1);
      }
      else if (moveState == "forward") {
        this.currentPlace.strengthen(this.myRed, this.myBlue, this.myGreen);
      }

      this.currentPlace.update();
      this.legacy.addMove(newMove);
    };
  }
}



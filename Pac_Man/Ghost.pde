//import java.util.Timer;
//import java.util.TimerTask;

public class Ghost extends Entity {
  color clr;
  int on;
  int[] spawnPoint;

  final int pointVal = 200;

  int movePattern;
  final int random = 0;
  final int onSight = 1;
  final int spawn = 2;

  Ghost(int startX, int startY, color startClr) {
    super(startX, startY);
    speed = (int) SQUARESIZE;
    clr = startClr;
    movePattern = onSight;
    on = SPACE;
    gameBoard[getRow()][getCol()] = GHOST;
    spawnPoint = ghostSpawn;
  }

  int getQPosition() {
    if (getRow() == ghostSpawn[0] && getCol() == ghostSpawn[1]) {
      return 0;
    } else if (getRow() == q1[0] && getCol() == q1[1]) {
      return 1;
    } else if (getRow() == q2[0] && getCol() == q2[1]) {
      return 2;
    } else if (getRow() == q3[0] && getCol() == q3[1]) {
      return 3;
    } else if ( getRow() == doorLocation[0] && getCol() == doorLocation[1]) {
      return -1;
    } else {
      return -2;
    }
  }

  void move(int dx, int dy) { //based on the key pressed (direction), dx and dy will either be -1, 0, or 1
    switch(getQPosition()) {
    case -2:
      if (inBounds(row+dy, col+dx) && gameBoard[row + dy][col + dx] != WALL && gameBoard[row + dy][col + dx] != GHOST && gameBoard[row + dy][col + dx] != TELEPORT && gameBoard[row + dy][col + dx] != DOOR) {
        setX(x + (speed * dx));
        setY(y + (speed * dy));

        row += dy;
        col += dx;

        gameBoard[row - dy][col - dx] = on;

        on = gameBoard[row][col];
        gameBoard[row][col] = GHOST;

        if (gameBoard[row][col] == PLAYER) {
          respawn();

          if (!PacMan.getState()) {
            PacMan.die();
          }
        }
      }

      break;

    case -1:
    case 0:
    case 3:
      if (gameBoard[row - 1][col] != WALL && gameBoard[row - 1][col] != GHOST) {
        setX(x + (speed * 0));
        setY(y + (speed * -1));

        row += -1;
        col += 0;

        gameBoard[row - -1][col - 0] = on;

        on = gameBoard[row][col];
        gameBoard[row][col] = GHOST;

        break;
      }

    case 1:
    case 2:
      if (gameBoard[row][col - 1] != WALL && gameBoard[row][col - 1] != GHOST) {
        setX(x + (speed * -1));
        setY(y + (speed * 0));

        row += 0;
        col += -1;

        gameBoard[row - 0][col - -1] = on;

        on = gameBoard[row][col];
        gameBoard[row][col] = GHOST;

        break;
      }
    }

    display();
  }

  void move() {
    if (movePattern == random) {
      int[] directions = new int[2];
      directions[0] = -1;
      directions[1] = 1;

      if (Math.random() < 0.5) {
        move(0, directions[(int) (Math.random() * 2)]);
      } else {
        move(directions[(int) (Math.random() * 2)], 0);
      }
    } else if (movePattern == onSight) {
      if (getRow() == PacMan.getRow()) {
        if (getCol() < PacMan.getCol()) {

          if (!PacMan.getState()) {
            if (gameBoard[row][col + 1] == WALL) {
              move(random);
            } else {
              move(1, 0);
            }
          } else {
            if (gameBoard[row][col - 1] == WALL) {
              move(random);
            } else {
              move(-1, 0);
            }
          }
        } else {

          if (!PacMan.getState()) {
            if (gameBoard[row][col - 1] == WALL) {
              move(random);
            } else {
              move(-1, 0);
            }
          } else {
            if (gameBoard[row][col + 1] == WALL) {
              move(random);
            } else {
              move(1, 0);
            }
          }
        }
      } else if (getCol() == PacMan.getCol()) {
        if (getRow() < PacMan.getRow()) {

          if (!PacMan.getState()) {
            if (gameBoard[row + 1][col] == WALL) {
              move(random);
            } else {
              move(0, 1);
            }
          } else {
            if (gameBoard[row - 1][col] == WALL) {
              move(random);
            } else {
              move(0, -1);
            }
          }
        } else {

          if (!PacMan.getState()) {
            if (gameBoard[row - 1][col] == WALL) {
              move(random);
            } else {
              move(0, -1);
            }
          } else {
            if (gameBoard[row + 1][col] == WALL) {
              move(random);
            } else {
              move(0, 1);
            }
          }
        }
      } else {
        //if (getQPosition() == -2) {
          int[] directions = new int[2];
          directions[0] = -1;
          directions[1] = 1;

          if (Math.random() < 0.5) {
            move(0, directions[(int) (Math.random() * 2)]);
          } else {
            move(directions[(int) (Math.random() * 2)], 0);
          }
        //}
      }
    }
  }

  void move(int mode) {
    if (mode == random) {
      int[] directions = new int[2];
      directions[0] = -1;
      directions[1] = 1;

      if (Math.random() < 0.5) {
        move(0, directions[(int) (Math.random() * 2)]);
      } else {
        move(directions[(int) (Math.random() * 2)], 0);
      }
    } else if (mode == onSight) {
      if (getRow() == PacMan.getRow()) {
        if (getCol() < PacMan.getCol()) {
          move(1, 0);
        } else {
          move(-1, 0);
        }
      } else if (getCol() == PacMan.getCol()) {
        if (getRow() < PacMan.getCol()) {
          move(0, 1);
        } else {
          move(0, -1);
        }
      } else {
        int[] directions = new int[2];
        directions[0] = -1;
        directions[1] = 1;

        if (Math.random() < 0.5) {
          move(0, directions[(int) (Math.random() * 2)]);
        } else {
          move(directions[(int) (Math.random() * 2)], 0);
        }
      }
    }
  }

  void display() {
    
    if (PacMan.getState() == true) {
      image(weak,getX(),getY());
    }else{
      if(clr == color(255, 50, 10)) image(red, getX(), getY());
      if(clr == color(255, 53, 184)) image(pink, getX(), getY());
      if(clr == color(0, 255, 255)) image(blue, getX(), getY());
      if(clr == color(235, 97, 35)) image(orange, getX(), getY());
    }
    //arc(getX() + SQUARESIZE/2, getY() + SQUARESIZE/2, SQUARESIZE, SQUARESIZE, 0, 2 * PI);
    
  }

  //void timer() {
  //  Timer timer = new Timer();
  //  TimerTask task = new TimerTask() {

  //    int counter = 8;

  //    @Override
  //      public void run() {
  //      if (counter > 0 ) {
  //        if (counter % 2 == 0) {
  //          fill(100, 0, 255);
  //          //println("dark");
  //        } else {
  //          fill(150, 150, 255);
  //          //println("light");
  //        }
  //        counter--;
  //      } else {
  //        fill(clr);
  //      }
  //    }
  //  };

  //  timer.schedule(task, 0, 2 * 1000);
  //}

  int[] otherTel(int r, int c) {
    int[] rn = {r, c};
    int index =0;
    for (int i = 0; i < teleports.size(); i++) {
      if (teleports.get(i)[0] == rn[0] && teleports.get(i)[1] == rn[1])index = i;
    }
    if (index % 2 == 0)return teleports.get(index+1);
    else {
      return teleports.get(index-1);
    }
  }

  void respawn() {
    if (!PacMan.getState()) {
      gameBoard[getRow()][getCol()] = SPACE;
    }

    setX(spawnPoint[1] * (int) SQUARESIZE);
    setY(spawnPoint[0] * (int) SQUARESIZE);

    setRow(spawnPoint[0]);
    setCol(spawnPoint[1]);

    on = SPACE;
  }

  int getVal() {
    return pointVal;
  }
}

//import java.util.Timer;
//import java.util.TimerTask;

public class Ghost extends Entity {
  color clr;
  int on;

  final int pointVal = 200;

  int movePattern;
  final int random = 0;
  final int onSight = 1;

  Ghost(int startX, int startY, color startClr) {
    super(startX, startY);
    speed = (int) SQUARESIZE;
    clr = startClr;
    movePattern = onSight;
    on = SPACE;
  }

  void move(int dx, int dy) { //based on the key pressed (direction), dx and dy will either be -1, 0, or 1
    if (inBounds(row+dy, col+dx) && ! (gameBoard[row + dy][col + dx] == WALL) && ! (gameBoard[row + dy][col + dx] == GHOST)) {
      setX(x + (speed * dx));
      setY(y + (speed * dy));

      row += dy;
      col += dx;

      gameBoard[row - dy][col - dx] = on;

      if (gameBoard[row][col] == PLAYER) {
        respawn();

        if (!PacMan.getState()) {
          PacMan.die();
        }
      }

      on = gameBoard[row][col];

      gameBoard[row][col] = GHOST;

      display();
    }
  }

  //void move(int dx, int dy) { //based on the key pressed (direction), dx and dy will either be -1, 0, or 1
  //  if (! (gameBoard[row + dy][col + dx] == WALL) && ! (gameBoard[row + dy][col + dx] == GHOST)) {
  //    setX(x + (speed * dx));
  //    setY(y + (speed * dy));

  //    row += dy;
  //    col += dx;

  //    if (gameBoard[row][col] == PLAYER) {
  //      if (!PacMan.getState()) {
  //        PacMan.die();
  //      } else {
  //        //gameBoard[row - dy][col - dx] = SPACE;
  //      }

  //      respawn();
  //    } else if (gameBoard[row][col] == TELEPORT) {
  //      int[] warp = otherTel(row, col);

  //      setRow(warp[0]);
  //      setCol(warp[1]);

  //      setY(warp[0] * (int) SQUARESIZE);
  //      setX(warp[1] * (int) SQUARESIZE);
  //    } else {
  //      gameBoard[row - dy][col - dx] = on;
  //    }

  //    on = gameBoard[row][col];

  //    gameBoard[row][col] = GHOST;

  //    display();
  //  }
  //}

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
        
      
      } else if (getCol() == PacMan.getCol()) {
        if (getRow() < PacMan.getRow()) {
          
          
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
    fill(clr);
    if (PacMan.getState() == true) {
      fill(100, 0, 255);
    }
    arc(getX() + SQUARESIZE/2, getY() + SQUARESIZE/2, SQUARESIZE, SQUARESIZE, 0, 2 * PI);
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

    setX(ghostSpawn[1] * (int) SQUARESIZE);
    setY(ghostSpawn[0] * (int) SQUARESIZE);

    setRow(ghostSpawn[0]);
    setCol(ghostSpawn[1]);

    on = SPACE;
  }

  int getVal() {
    return pointVal;
  }
}

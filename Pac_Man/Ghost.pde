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
    if (! (gameBoard[row + dy][col + dx] == WALL)) {
      setX(x + (speed * dx));
      setY(y + (speed * dy));



      row += dy;
      col += dx;

      gameBoard[row - dy][col - dx] = on;

      on = gameBoard[row][col];

      gameBoard[row][col] = GHOST;



      if (on == PLAYER) {
        if (!PacMan.getState()) {
          PacMan.die();
        } else {
          respawn();
        }
      }




      display();
    }
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
    if (getEatable() == true) fill(215, 0, 0);
    arc(getX() + SQUARESIZE/2, getY() + SQUARESIZE/2, SQUARESIZE, SQUARESIZE, 0, 2 * PI);
  }

  void respawn() {
    setX(ghostSpawn[1] * (int) SQUARESIZE);
    setY(ghostSpawn[0] * (int) SQUARESIZE);

    setRow(ghostSpawn[0]);
    setCol(ghostSpawn[1]);
  }

  int getVal() {
    return pointVal;
  }
}

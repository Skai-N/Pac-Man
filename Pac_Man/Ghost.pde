public class Ghost extends Entity {
  color clr;
  int on;
  int[] spawnPoint;
  boolean moveable;

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
    moveable = false;
  }

  int getSpawnPosition() {
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

  int getQPosition() {
    return ghostSpawnQ.indexOf(this);
  }

  void setSpawn() {
    switch(getQPosition()) {
    case 0:
      spawnPoint = ghostSpawn;
      break;

    case 1:
      spawnPoint = q1;
      break;

    case 2:
      spawnPoint = q2;
      break;

    case 3:
      spawnPoint = q3;
      break;
    }
  }

  void move(int dx, int dy) { //based on the key pressed (direction), dx and dy will either be -1, 0, or 1
    if (moveable) {
      switch(getSpawnPosition()) {
      case -2:
        if (inBounds(row+dy, col+dx) && gameBoard[row + dy][col + dx] != WALL && gameBoard[row + dy][col + dx] != GHOST && gameBoard[row + dy][col + dx] != TELEPORT && gameBoard[row + dy][col + dx] != DOOR) {
          setX(x + (speed * dx));
          setY(y + (speed * dy));

          row += dy;
          col += dx;

          gameBoard[row - dy][col - dx] = on;

          if (gameBoard[row][col] == PLAYER) {
            if (!PacMan.getState()) {
              PacMan.die();
            }

            respawn();
          }

          on = gameBoard[row][col];
          gameBoard[row][col] = GHOST;
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
    } else if (mode == spawn) {
      switch(getSpawnPosition()) {
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
    }
  }

  void display() {
    fill(clr);
    if (PacMan.getState() == true) {
      fill(100, 0, 255);
    }
    arc(getX() + SQUARESIZE/2, getY() + SQUARESIZE/2, SQUARESIZE, SQUARESIZE, 0, 2 * PI);
  }

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
    setMoveable(false);
    ghostSpawnQ.add(this);
    setSpawn();

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

  void setMoveable(boolean b) {
    moveable = b;
  }
}

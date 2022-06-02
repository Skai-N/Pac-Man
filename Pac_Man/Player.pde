public class Player extends Entity {
  int lives;
  boolean invincible;
  Score points;

  Player(int x, int y) {
    super(x, y);
    speed = (int) SQUARESIZE;
    lives = 3;
    invincible = false;
    points = new Score();
  }

  void smooth(int dx, int dy) {
    if (! (gameBoard[row + dy][col + dx] == WALL)) {
      setX(x + ((speed * dx)/2));
      setY(y + ((speed * dy)/2));

      display();
    }
  }

  void move(int dx, int dy) { //based on the key pressed (direction), dx and dy will either be -1, 0, or 1
    if (! (gameBoard[row + dy][col + dx] == WALL || gameBoard[row + dy][col + dx] == DOOR)) {
      setX(x + (speed * dx));
      setY(y + (speed * dy));

      gameBoard[row][col] = SPACE;

      row += dy;
      col += dx;

      if (gameBoard[row][col] == FRUIT) {
        points.addScore(dots.remove(dots.size() - 1).getVal());
      }
      if (gameBoard[row][col] == BIGFRUIT) {
        points.addScore(bigdots.remove(bigdots.size() -1).getVal());
      }
      if (gameBoard[row][col] == GHOST) {
        if(!invincible)die();
        else{
          points.addScore(200);
        }
        ghost.respawn();
      }
      
      gameBoard[row][col] = PLAYER;

      display(dx, dy);
    }
  }

  void display() {
    fill(250, 200, 0);
    arc(getX() + SQUARESIZE/2, getY() + SQUARESIZE/2, SQUARESIZE, SQUARESIZE, 0, 2 * PI);
  }

  void display(int dx, int dy) {
    if (dx == 1 && dy == 0) {
      fill(250, 200, 0);
      arc(getX() + SQUARESIZE/2, getY() + SQUARESIZE/2, SQUARESIZE, SQUARESIZE, PI/6, 11 * PI/6);
    } else if (dx == 0 && dy == 1) {
      fill(250, 200, 0);
      arc(getX() + SQUARESIZE/2, getY() + SQUARESIZE/2, SQUARESIZE, SQUARESIZE, PI/6 + PI/2, 11 * PI/6 + PI/2);
    } else if (dx == -1 && dy == 0) {
      fill(250, 200, 0);
      arc(getX() + SQUARESIZE/2, getY() + SQUARESIZE/2, SQUARESIZE, SQUARESIZE, PI/6 + PI, 11 * PI/6 + PI);
    } else if (dx == 0 && dy == -1) {
      fill(250, 200, 0);
      arc(getX() + SQUARESIZE/2, getY() + SQUARESIZE/2, SQUARESIZE, SQUARESIZE, PI/6 + (3 * PI/2), 11 * PI/6 + (3 * PI/2));
    } else {
      display();
    }
  }

  void die() {
    setLives(lives - 1);
    if (getLives() > 0) {
      respawn();
    }
  }

  void respawn() {
    setX(playerSpawn[1] * (int) SQUARESIZE);
    setY(playerSpawn[0] * (int) SQUARESIZE);

    setRow(playerSpawn[0]);
    setCol(playerSpawn[1]);
  }

  void setLives(int numLives) {
    lives = numLives;
  }

  int getLives() {
    return lives;
  }

  int getScore() {
    return points.getScore();
  }

  int getRow() {
    return getY() / (int) SQUARESIZE;
  }

  int getCol() {
    return getX() / (int) SQUARESIZE;
  }

  void setInvincible() {
    invincible = !invincible;
  }
  
  void setInvincible(boolean b){
    invincible = b;
  }
  boolean getState() {
    return invincible;
  }
}

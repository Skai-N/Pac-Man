import java.util.Timer;
import java.util.TimerTask;

public class Player extends Entity {
  int lives;
  boolean invincible;
  boolean moveable = false;
  Score points;
  int on;
  boolean timerOn;

  Player(int x, int y) {
    super(x, y);
    speed = (int) SQUARESIZE;
    lives = 3;
    invincible = false;
    points = new Score();
    on = SPACE;
    timerOn = false;
  }

  Player(int x, int y, int startLives) {
    super(x, y);
    speed = (int) SQUARESIZE;
    lives = startLives;
    invincible = false;
    points = new Score();
    on = SPACE;
    timerOn = false;
  }

  void move(int dx, int dy) { //based on the key pressed (direction), dx and dy will either be -1, 0, or 1
    if (inBounds(row+dy, col+dx) && gameBoard[getRow() + dy][getCol() + dx] != WALL && gameBoard[getRow() + dy][getCol() + dx] != gameBoard[doorLocation[0]][doorLocation[1]]) {
      setX(getX() + ((int) speed * dx));
      setY(getY() + ((int) speed * dy));

      
      row += dy;
      col += dx;
      gameBoard[row - dy][col - dx] = on;
      
      if (gameBoard[row][col] == TELEPORT) {
        int[] warp = otherTel(row, col);

        setRow(warp[0]);
        setCol(warp[1]);

        setY(warp[0] * (int) SQUARESIZE);
        setX(warp[1] * (int) SQUARESIZE);

        on = TELEPORT;
      } else {

        if (gameBoard[row][col] == FRUIT) {
          points.addScore(dots.remove(dots.size() - 1).getVal());
        } else if (gameBoard[row][col] == BIGFRUIT) {
          points.addScore(bigdots.remove(bigdots.size() - 1).getVal());
          if (!timerOn) {
            setInvincible(true);
            invincibilityTimer();
            timerOn = true;
          }
        } else if (gameBoard[row][col] == GHOST) {
          if (!invincible) {
            die();
            for (Ghost g : ghosts) {
              g.respawn();
            }
          } else {
            points.addScore(200);
          }

          if (row == pinky.getRow() && col == pinky.getCol() ) ghostSpawnQ.add(pinky);
          if (row == blinky.getRow() && col == blinky.getCol() ) ghostSpawnQ.add(blinky);
          if (row == inky.getRow() && col == inky.getCol() ) ghostSpawnQ.add(inky);
          if (row == clyde.getRow() && col == clyde.getCol() ) ghostSpawnQ.add(clyde);
        }

        on = SPACE;
      

      gameBoard[row][col] = PLAYER;
      }
      display(dx, dy);
    }
  }

  void display() {
    fill(245, 191, 15);
    arc(getX() + SQUARESIZE/2, getY() + SQUARESIZE/2, SQUARESIZE, SQUARESIZE, 0, 2 * PI);
  }

  void display(int dx, int dy) {
    if (dx == 1 && dy == 0) {
      fill(245, 191, 15);
      arc(getX() + SQUARESIZE/2, getY() + SQUARESIZE/2, SQUARESIZE, SQUARESIZE, PI/6, 11 * PI/6);
    } else if (dx == 0 && dy == 1) {
      fill(245, 191, 15);
      arc(getX() + SQUARESIZE/2, getY() + SQUARESIZE/2, SQUARESIZE, SQUARESIZE, PI/6 + PI/2, 11 * PI/6 + PI/2);
    } else if (dx == -1 && dy == 0) {
      fill(245, 191, 15);
      arc(getX() + SQUARESIZE/2, getY() + SQUARESIZE/2, SQUARESIZE, SQUARESIZE, PI/6 + PI, 11 * PI/6 + PI);
    } else if (dx == 0 && dy == -1) {
      fill(245, 191, 15);
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
    gameBoard[getRow()][getCol()] = SPACE;

    setX(playerSpawn[1] * (int) SQUARESIZE);
    setY(playerSpawn[0] * (int) SQUARESIZE);

    setRow(playerSpawn[0]);
    setCol(playerSpawn[1]);

    gameBoard[getRow()][getCol()] = PLAYER;

    setMoveable(false);

    display();
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

  void setScore(int newScore) {
    points.addScore(newScore);
  }

  int getRow() {
    return getY() / (int) SQUARESIZE;
  }

  int getCol() {
    return getX() / (int) SQUARESIZE;
  }

  void toggleInvincible() {
    invincible = !invincible;
  }

  void setInvincible(boolean b) {
    invincible = b;
  }

  void invincibilityTimer() {
    Timer timer = new Timer();
    TimerTask task = new TimerTask() {
      @Override
        public void run() {
        timerOn = false;
        setInvincible(false);
      }
    };

    timer.schedule(task, 8 * 1000);
  }

  boolean getState() {
    return invincible;
  }

  boolean getMoveable() { 
    return moveable;
  }

  void setMoveable(boolean b) {
    moveable = b;
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
}

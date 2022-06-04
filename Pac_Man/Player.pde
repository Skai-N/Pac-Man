import java.util.Timer;

public class Player extends Entity {
  int lives;
  boolean invincible;
  boolean moveable = false;
  Score points;

  Player(int x, int y) {
    super(x, y);
    speed = (int) SQUARESIZE;
    lives = 3;
    invincible = false;
    points = new Score();
  }

  Player(int x, int y, int startLives) {
    super(x, y);
    speed = (int) SQUARESIZE;
    lives = startLives;
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
        //timer();
        points.addScore(bigdots.remove(bigdots.size() -1).getVal());
        //setInvincible(true);
      }
      if (gameBoard[row][col] == GHOST) {
        if (!invincible) {
          die();
        } else {
          points.addScore(200);
        }
        if(row == pinky.getRow() && col == pinky.getCol() )pinky.respawn();
        if(row == blinky.getRow() && col == blinky.getCol() )blinky.respawn();
      }
      if(gameBoard[row][col] == TELEPORT){
        int[] warp = otherTel(row, col);
        row = warp[0]; col = warp[1];
        setY(warp[0]); setX(warp[1]);
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
    gameBoard[getRow()][getCol()] = SPACE;

    setX(playerSpawn[1] * (int) SQUARESIZE);
    setY(playerSpawn[0] * (int) SQUARESIZE);

    setRow(playerSpawn[0]);
    setCol(playerSpawn[1]);

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

  void timer() {
    Timer timer = new Timer();
    
    timer.schedule(new TimerTask() {
      @Override
        public void run() {
        toggleInvincible();
      }
    }
    , 10*1000);
    //int countdown = 10000;
    //Timer delay = new Timer(countdown, toggleInvincible());
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
  
  int[] otherTel(int row, int col){
    int[] rn = {row, col};
    int index =0;
    for(int i = 0; i < teleports.size(); i++){
      if(teleports.get(i)[0] == rn[0] && teleports.get(i)[1] == rn[1])index = i;
    }
    if(index % 2 == 0)return teleports.get(index+1);
    return teleports.get(index-1);
  }
  
}

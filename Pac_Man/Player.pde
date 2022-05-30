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

  void display() {
    fill(250, 200, 0);
    arc(getX() + SQUARESIZE/2, getY() + SQUARESIZE/2, SQUARESIZE, SQUARESIZE, PI/6, 11 * PI/6);
  }

  void die() {
    setLives(lives - 1);
  }

  void respawn() {
    die();
    setX(width/2);
    setY(height/2);
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
}

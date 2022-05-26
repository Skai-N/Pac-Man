public class Player extends Entity {
  int lives;
  boolean invincible;
  Score points;

  Player(int x, int y) {
    super(x,y);
    speed = 3;
    lives = 3;
    invincible = false;
    points = new Score();
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
}

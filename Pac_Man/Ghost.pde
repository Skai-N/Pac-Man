public class Ghost extends Entity {
  color clr;
  final int pointVal = 200;
  int movePattern;
  final int RNDMMVM = 0;

  Ghost(int startX, int startY, color startClr) {
    super(startX, startY);
    speed = 2;
    clr = startClr;
    movePattern = RNDMMVM;
  }

  void move() {
    if (movePattern == RNDMMVM) {

      int[] directions = new int[2];
      directions[0] = -1;
      directions[1] = 1;
    }
  }
}

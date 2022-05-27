public class Ghost extends Entity {
  color clr;
  final int pointVal = 200;
  int movePattern;
  final int random = 0;

  Ghost(int startX, int startY, color startClr) {
    super(startX, startY);
    speed = 2;
    clr = startClr;
    movePattern = random;
  }

  void move() {
    if (movePattern == random) {
      int[] directions = new int[2];
      directions[0] = -1;
      directions[1] = 1;
      
      if(Math.random() < 0.5) {
        move(0, directions[(int) (Math.random() * 2)]);
      }
      else {
        move(directions[(int) (Math.random() * 2)], 0);
      }
    }
  }
}

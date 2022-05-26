public class Ghost extends Entity {
  color clr;
  final int pointVal = 200;
  
  Ghost(int startX, int startY, color startClr) {
    super(startX, startY);
    speed = 2;
    clr = startClr;
  }
  
  void move() {
    
  }
}

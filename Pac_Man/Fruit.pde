public class Fruit extends Entity {
 int type;
 final int pointVal;
 final int dot = 0;
 final int bigDot = 1;
 final int cherry = 2;
 
 Fruit(int startX, int startY, int startType) {
   super(startX, startY);
   isEatable = true;
   type = startType;
   pointVal = type;
 }
 
 void move() { //does nothing
 }
 
 int getType() {
  return type; 
 }
}

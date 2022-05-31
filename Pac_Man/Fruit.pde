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
   if(type == dot) {
     pointVal = 10;
   }
   else if(type == bigDot) {
     pointVal = 50;
   }
   else {
     pointVal = type;
   }
 }   
 
 int getType() {
  return type; 
 }
 
 void display() {
    fill(255,255,255);
    circle(getX() *SQUARESIZE + SQUARESIZE/2, getY() *SQUARESIZE + SQUARESIZE/2, SQUARESIZE/3);
  }
  
 int getVal() {
   return pointVal;
 }
 
 
}

public class Entity implements Eatable {
  int x;
  int y;
  int row;
  int col;
  int speed;
  boolean isEatable;

  Entity(int startX, int startY) {
    x = startX;
    y = startY;
    row = startY / (int) SQUARESIZE;
    col = startX / (int) SQUARESIZE;
    isEatable = false;
    speed = 0;
  }
  
  void move(int dx, int dy) { //based on the key pressed (direction), dx and dy will either be -1, 0, or 1
    setX(x + (speed * dx));
    setY(y + (speed * dy));
    
    row += dy;
    col += dx;
  }

  int[] eat(Eatable other) {
    int[] location = new int[2];
    if (other.isEatable) {
      int col = width / getX();
      int row = height / getY();

      location[0] = row;
      location[1] = col;
    }
    
    return location;
  }

  int getX() {
    return x;
  }

  int getY() {
    return y;
  }
  
  int getRow() {
    return row;
  }
  
  int getCol() {
    return col;
  }
  
  void setX(int newX) {
    x = newX;
  }
  
  void setY(int newY) {
    y = newY;
  }
  
  void setRow(int newRow) {
    row = newRow;
  }
  
  void setCol(int newCol) {
    col = newCol;
  }
  
  void setEatable(boolean eatable) {
    isEatable = eatable;
  }
  boolean getEatable() {
    return isEatable;
  }
  
  void changeSpeed(int speed_){
    speed += speed_;
  }
  
}

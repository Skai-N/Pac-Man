public class Entity implements Eatable {
  int x;
  int y;
  int speed;
  boolean isEatable;

  Entity(int startX, int startY) {
    x = startX;
    y = startY;
    isEatable = false;
  }
  
  void move(int dx, int dy) { //based on the key pressed (direction), dx and dy will either be -1, 0, or 1
    x += speed * dx;
    y += speed * dy;
  }

  int[] eat(Eatable other) {
    int[] location = new int[2];
    if (other.isEatable) {
      int col = width / getX();
      int row = height / getY();

      location[0] = row;
      location[1] = col;

      return location;
    }
  }

  int getX() {
    return x;
  }

  int getY() {
    return y;
  }
}

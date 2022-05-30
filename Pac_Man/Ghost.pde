public class Ghost extends Entity {
  color clr;
  final int pointVal = 200;
  int movePattern;
  final int random = 0;

  Ghost(int startX, int startY, color startClr) {
    super(startX, startY);
    speed = (int) SQUARESIZE;
    clr = startClr;
    movePattern = random;
  }

  void move(int dx, int dy) { //based on the key pressed (direction), dx and dy will either be -1, 0, or 1
    if (! (gameBoard[row + dy][col + dx] == WALL)) {
      setX(x + (speed * dx));
      setY(y + (speed * dy));

      int temp = gameBoard[row + dy][col + dx];

      row += dy;
      col += dx;

      gameBoard[row][col] = GHOST;
      if (temp == PLAYER) {
        PacMan.die();
      } else {
        gameBoard[row - dy][col - dx] = temp;
      }

      display();
    }
  }

  void move() {
    if (movePattern == random) {
      int[] directions = new int[2];
      directions[0] = -1;
      directions[1] = 1;

      if (Math.random() < 0.5) {
        move(0, directions[(int) (Math.random() * 2)]);
      } else {
        move(directions[(int) (Math.random() * 2)], 0);
      }
    }
  }

  void display() {
    fill(clr);
    arc(getX() + SQUARESIZE/2, getY() + SQUARESIZE/2, SQUARESIZE, SQUARESIZE, 0, 2 * PI);
  }
}

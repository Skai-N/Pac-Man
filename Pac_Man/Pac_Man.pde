import java.util.*;
import java.io.*;

final int WALL = 0;
final int SPACE = 1;
final int FRUIT = 2;
final int GHOST = 3;
final int PLAYER = 4;

int ROWS;
int COLS;

ArrayList<Fruit> dots;
ArrayList<Ghost> ghosts;
Player PacMan;

int xDir = 0;
int yDir = 0;

float SQUARESIZE;
int[][] gameBoard;
void setup() {
  size(720, 720);
  background(0);
  int ROWS = 30;
  int COLS = 30;
  SQUARESIZE = height/ROWS;

  dots = new ArrayList<Fruit>();
  ghosts = new ArrayList<Ghost>();

  PacMan = new Player(width/2, height/2);

  gameBoard = readFile("level1.txt");
  loadGame();
  StringToSquares(gameBoard);
  PacMan.display();

  dots.remove(dots.size() - 1);
  noStroke();
}
void draw() {
  background(0);
  noStroke();
  if (frameCount % 10 == 0) {
    run();
  }
  StringToSquares(gameBoard);
  //println(ghosts.size());
  //println(dots.size());
}
void run() {
  if (!done()) {
    PacMan.move(xDir, yDir);

    for (Ghost g : ghosts) {
      g.move();
    }
  }
}
boolean done() {
  return dots.size() == 0;
  //return false;
}

void keyPressed() {
  if (keyCode == UP || keyCode == 'w') {
    yDir = -1;
    xDir = 0;
  }
  if (keyCode == DOWN || keyCode == 's') {
    yDir = 1;
    xDir = 0;
  }
  if (keyCode == RIGHT || keyCode == 'd') {
    yDir = 0;
    xDir = 1;
  }
  if (keyCode == LEFT || keyCode == 'a') {
    yDir = 0;
    xDir = -1;
  }
}

void StringToSquares(int[][] map) {
  for (int i = 0; i < map.length; i++) {
    for (int j = 0; j < map[0].length; j++) {
      if (map[i][j] == WALL) {
        fill(0, 0, 250);
        rect(j*SQUARESIZE, i*SQUARESIZE, SQUARESIZE, SQUARESIZE);
      }
      if (map[i][j] == FRUIT) {
        fill(255, 255, 255);
        circle(j*SQUARESIZE + SQUARESIZE/2, i*SQUARESIZE + SQUARESIZE/2, SQUARESIZE/3);
      }
      if (map[i][j] == PLAYER) {
        PacMan.display();
      }
    }
  }
}

void loadGame() {
  for (int i = 0; i < gameBoard.length; i++) {
    for (int j = 0; j < gameBoard[i].length; j++) {
      if (gameBoard[i][j] == SPACE) {
        gameBoard[i][j] = FRUIT;
        dots.add(new Fruit(i, j, 0));
      }
    }
  }
}

int[][] readFile(String filename) {
  String[] lines = loadStrings(filename);
  println(lines.length + "x" + lines[0].length() );
  int len = lines[0].length();
  int[][] temp = new int[lines.length][len];
  for (int i = 0; i < lines.length; i++) {
    for (int j = 0; j < len; j++) {
      if (lines[i].charAt(j) == '#')temp[i][j] = WALL;
      if (lines[i].charAt(j) == '*')temp[i][j] = SPACE;
      if (lines[i].charAt(j) == 'S')temp[i][j] = PLAYER;
    }
  }

  return temp;
}

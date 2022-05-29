import java.util.*;
import java.io.*;

final int WALL = 0;
final int SPACE = 1;
final int FRUIT = 2;
final int GHOST = 3;
final int PLAYER = 4;

ArrayList<Fruit> dots;
ArrayList<Ghost> ghosts;
Player PacMan;

int xDir = 0;
int yDir = 0;

float SQUARESIZE;
int[][] gameBoard;
void setup() {
  dots = new ArrayList<Fruit>();
  ghosts = new ArrayList<Ghost>();

  PacMan = new Player(width/2, height/2);

  size(720, 720);
  background(0);
  int ROWS = 30;
  int COLS = 30;
  SQUARESIZE = height/ROWS;
  gameBoard = readFile("level1.txt");
  loadGame();
  StringToSquares(gameBoard);

  noStroke();
}
void draw() {
  run();
  StringToSquares(gameBoard);
}
void run() {
  if (done())return;
  PacMan.move(xDir, yDir);
  for (Ghost g : ghosts) {
    g.move();
  }
}
boolean done() {
  //return dots.size() == 0;
  return false;
}

void keyPressed() {
  if (keyCode == UP) {
    yDir = -1;
    xDir = 0;
  }
  if (keyCode == DOWN) {
    yDir = 1;
    xDir = 0;
  }
  if (keyCode == RIGHT) {
    yDir = 0;
    xDir = 1;
  }
  if (keyCode == LEFT) {
    yDir = -1;
    xDir = -1;
  }
}

void StringToSquares(int[][] map) {
  for (int i = 0; i < map.length; i++) {
    for (int j = 0; j < map[0].length; j++) {
      if (map[i][j] == WALL) {
        fill(0, 0, 250);
        rect(i*SQUARESIZE, j*SQUARESIZE, SQUARESIZE, SQUARESIZE);
      }
      if (map[i][j] == FRUIT) {
        fill(255, 255, 255);
        circle(i*SQUARESIZE + SQUARESIZE/2, j*SQUARESIZE + SQUARESIZE/2, SQUARESIZE/2);
      }
      //if(map[i][j] == PLAYER){
      // fill(255,233,0);
      // circle(i*SQUARESIZE,j*SQUARESIZE,3);
      //}
    }
  }
}

void loadGame() {
  for (int i = 0; i < gameBoard.length; i++) {
    for (int j = 0; j < gameBoard[i].length; j++) {
      if (gameBoard[i][j] == SPACE) {
        gameBoard[i][j] = FRUIT;
        //dots.add(new Fruit(i, j, 0));
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
      //println(j);
      //println(i);
      //println(len);
      //println(lines.length);
      if (lines[i].charAt(j) == '#')temp[i][j] = WALL;
      if (lines[i].charAt(j) == '*')temp[i][j] = SPACE;
    }
  }

  return temp;
}

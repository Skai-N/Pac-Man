import java.util.*;
import java.io.*;

final int WALL = 0;
final int SPACE = 1;
final int FRUIT = 2;
final int BIGFRUIT = 5;
final int CHERRY = 6;
final int GHOST = 3;
final int PLAYER = 4;
final int DOOR = 7;

int[] playerSpawn = new int[2];
int[] ghostSpawn = new int[2];

int ROWS;
int COLS;

ArrayList<Fruit> dots;
ArrayList<Fruit> bigdots;
ArrayList<Ghost> ghosts;
Player PacMan;
Ghost ghost;

int xDir = 0;
int yDir = 0;

float SQUARESIZE;
int[][] gameBoard;

int score = 0;
void setup() {
  size(720, 720);
  background(0);
  int ROWS = 30;
  int COLS = 30;
  SQUARESIZE = height/ROWS;

  dots = new ArrayList<Fruit>();
  ghosts = new ArrayList<Ghost>();
  bigdots = new ArrayList<Fruit>();
  
  gameBoard = readFile("level3.txt");

  PacMan = new Player(playerSpawn[1] * (int) SQUARESIZE, playerSpawn[0] * (int) SQUARESIZE);
  ghost = new Ghost(ghostSpawn[1] * (int) SQUARESIZE, ghostSpawn[0] * (int) SQUARESIZE, color(0, 255, 255));
  ghosts.add(ghost);

  loadGame();
  StringToSquares(gameBoard);
  PacMan.display();

  noStroke();
}
void draw() {
  background(0);
  noStroke();
  if (frameCount % 4 == 0) {
    run();
  }
  if (frameCount % 500 == 0) {
    PacMan.setInvincible(true);
    for (Ghost g : ghosts) {
      g.setEatable(true);
    }
  }
  if (frameCount % 700 == 0) {
    PacMan.setInvincible(false);
    for (Ghost g : ghosts) {
      g.setEatable(false);
    }
  }


  StringToSquares(gameBoard);
  //println(ghosts.size());
  //println(dots.size());
  fill(255, 255, 255);
  text("Score: "+(PacMan.getScore() + score), 10, 10);
  text("Lives: " + PacMan.getLives(), 10, 720);
  text("Invincible: "+PacMan.getState(), 200, 10);
}
void run() {

  //for(int i = 0; i < gameBoard.length; i++) {
  //  for(int j = 0; j < gameBoard[i].length; j++) {
  //    print(gameBoard[i][j] + " ");
  //  }
  //  println();
  //}
  //println();

  if (!levelDone() && !gameOver()) {
    PacMan.move(xDir, yDir);

    for (Ghost g : ghosts) {
      g.move();
    }
  } else if(levelDone() && !gameOver()) {
    score = PacMan.getScore();
    setup();
  }
  else {
    setup();
  }
}

boolean levelDone() {
  return dots.size() == 0 && bigdots.size() == 0;
}

boolean gameOver() {
  return PacMan.getLives() == 0;
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
      if (map[i][j] == BIGFRUIT){
        fill(255,255,255);
        circle(j*SQUARESIZE + SQUARESIZE/2, i*SQUARESIZE + SQUARESIZE/2, SQUARESIZE/1.5);
      }
      if (map[i][j] == PLAYER) {
        PacMan.display(xDir, yDir);
      }
      if (map[i][j] == GHOST) {
        ghost.display();
      }
      if(map[i][j] == DOOR) {
        fill(255,150,0);
        rect(j*SQUARESIZE, i*SQUARESIZE, SQUARESIZE, SQUARESIZE);
      }
    }
  }
}

void loadGame() {
  for (int i = 0; i < gameBoard.length; i++) {
    for (int j = 0; j < gameBoard[i].length; j++) {
      if (gameBoard[i][j] == FRUIT) {
        dots.add(new Fruit(i, j, 0));
      }
      if (gameBoard[i][j] == BIGFRUIT){
        bigdots.add(new Fruit(i,j,1)); 
      }
    }
  }
}

int[][] readFile(String filename) {
  String[] lines = loadStrings(filename);
  //println(lines.length + "x" + lines[0].length() );
  int len = lines[0].length();
  int[][] temp = new int[lines.length][len];
  for (int i = 0; i < lines.length; i++) {
    for (int j = 0; j < len; j++) {
      if (lines[i].charAt(j) == '#') {
        temp[i][j] = WALL;
      } else if (lines[i].charAt(j) == '*') {
        temp[i][j] = FRUIT;
      } else if (lines[i].charAt(j) == 'S') {
        temp[i][j] = PLAYER;
        playerSpawn[0] = i;
        playerSpawn[1] = j;
      } else if (lines[i].charAt(j) == 'G') {
        temp[i][j] = GHOST;
        ghostSpawn[0] = i;
        ghostSpawn[1] = j;
      } else if (lines[i].charAt(j) == ' ') {
        temp[i][j] = SPACE;
      } else if (lines[i].charAt(j) == 'D') {
        temp[i][j] = DOOR;
      }
      else if(lines[i].charAt(j) == '@') {
        temp[i][j] = BIGFRUIT;
      }
    }
  }
  return temp;
}

int indexOfFruit(int x, int y) {
  for (int i = 0; i < dots.size(); i++) {
    if (dots.get(i).getX() == x && dots.get(i).getY() == y)return i;
  }
  return -1;
}

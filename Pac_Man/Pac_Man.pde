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
final int TELEPORT = 8;
int[] playerSpawn = new int[2];
int[] ghostSpawn = new int[2];
int[] doorLocation = new int[2];

int ROWS;
int COLS;

ArrayList<Integer> scores; 
ArrayList<Fruit> dots;
ArrayList<Fruit> bigdots;
ArrayList<Ghost> ghosts;
Player PacMan;
Ghost pinky;
Ghost blinky;
Ghost clyde;
Ghost inky;

int xDir = 0;
int yDir = 0;

float SQUARESIZE;
int[][] gameBoard;

int score = 0;
int level = 1;
int gameSpeed = 10;

ArrayList<int[]> teleports;

boolean isStarted;
PImage start;
PImage end;
PImage pink;PImage red;PImage blue;PImage orange;PImage weak;


void setup() {
  size(720, 720);
  background(0);
  int ROWS = 30;
  int COLS = 30;
  SQUARESIZE = height/ROWS;

  isStarted = false;
  teleports = new ArrayList<int[]>();
  scores = new ArrayList<Integer>();

  dots = new ArrayList<Fruit>();
  ghosts = new ArrayList<Ghost>();
  bigdots = new ArrayList<Fruit>();

  gameBoard = readFile("level3.txt");
  start = loadImage("pacmenload.png");
  end = loadImage("endscreen.png");

  PacMan = new Player(playerSpawn[1] * (int) SQUARESIZE, playerSpawn[0] * (int) SQUARESIZE);
  pinky = new Ghost(ghostSpawn[1] * (int) SQUARESIZE, ghostSpawn[0] * (int) SQUARESIZE, color(255, 53, 184));
  inky = new Ghost(ghostSpawn[1] * (int) SQUARESIZE, ghostSpawn[0] * (int) SQUARESIZE, color(0, 255, 255));
  blinky = new Ghost(ghostSpawn[1] * (int) SQUARESIZE, ghostSpawn[0] * (int) SQUARESIZE, color(255, 50, 10));
  clyde = new Ghost(ghostSpawn[1] * (int) SQUARESIZE, ghostSpawn[0] * (int) SQUARESIZE, color(235, 97, 35));
  ghosts.add(blinky);red = loadImage("blinky.png");red.resize((int)SQUARESIZE,(int)SQUARESIZE);
  ghosts.add(pinky);pink = loadImage("pinky.png");pink.resize((int)SQUARESIZE,(int)SQUARESIZE);
  ghosts.add(inky);blue = loadImage("inky.png");blue.resize((int)SQUARESIZE,(int)SQUARESIZE);
  ghosts.add(clyde);orange = loadImage("1clyde.jpg");orange.resize((int)SQUARESIZE,(int)SQUARESIZE);
  weak = loadImage("weak.png");weak.resize((int)SQUARESIZE,(int)SQUARESIZE);

  loadGame();

  noStroke();
}

void draw() {
  background(0);
  noStroke();

  if (isStarted) {
    if (frameCount % gameSpeed == 0) {
      run();
    }

    StringToSquares(gameBoard);

    fill(255, 255, 255);
    text("Score: "+(PacMan.getScore() + score), 10, 10);
    text("High Score: " + highScore(), 100, 10);
    text("Level: " + level, 220, 10);
    switch(PacMan.getLives()) {
    case 3:
      fill(245, 191, 15);
      arc(72, 708, 15, 15, PI/6, 11 * PI/6);

    case 2:
      fill(245, 191, 15);
      arc(52, 708, 15, 15, PI/6, 11 * PI/6);

    case 1:
      fill(245, 191, 15);
      arc(32, 708, 15, 15, PI/6, 11 * PI/6);
    }
    if (gameOver()) {
      scores.add(PacMan.getScore());
      endDisplay();
    }
  } else {
    startDisplay();
  }
}

void run() {
  if (PacMan.getMoveable()) {
    if (!levelDone() && !gameOver()) {
      PacMan.move(xDir, yDir);

      for (Ghost g : ghosts) {
        g.move();
      }
    } else {
      if (levelDone()) {
        level++;
        advanceLevel();
      }
    }
  }
}

void advanceLevel() {
  if (gameSpeed > 1) {
    gameSpeed--;
  }  

  reset(PacMan.getLives(), PacMan.getScore());
}

void reset(int lives, int score) {
  dots = new ArrayList<Fruit>();
  ghosts = new ArrayList<Ghost>();
  bigdots = new ArrayList<Fruit>();

  gameBoard = readFile("level3.txt");

  PacMan = new Player(playerSpawn[1] * (int) SQUARESIZE, playerSpawn[0] * (int) SQUARESIZE, lives);
  PacMan.setScore(score);
  pinky = new Ghost(ghostSpawn[1] * (int) SQUARESIZE, ghostSpawn[0] * (int) SQUARESIZE, color(255, 53, 184));
  inky = new Ghost(ghostSpawn[1] * (int) SQUARESIZE, ghostSpawn[0] * (int) SQUARESIZE, color(0, 255, 255));
  blinky = new Ghost(ghostSpawn[1] * (int) SQUARESIZE, ghostSpawn[0] * (int) SQUARESIZE, color(255, 50, 10));
  clyde = new Ghost(ghostSpawn[1] * (int) SQUARESIZE, ghostSpawn[0] * (int) SQUARESIZE, color(235, 97, 35));
  ghosts.add(pinky);
  ghosts.add(blinky);
  ghosts.add(clyde);
  ghosts.add(inky);

  loadGame();
  StringToSquares(gameBoard);
  PacMan.display();

  noStroke();
}

void startDisplay() {
  image(start, 0, 0);
}

void endDisplay() {
  image(end, 0, 0);
}

boolean levelDone() {
  return dots.size() == 0 && bigdots.size() == 0;
}

boolean gameOver() {
  return PacMan.getLives() == 0;
}

void keyPressed() {
  PacMan.setMoveable(true);

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
  if (keyCode == ENTER) {
    isStarted = true;
  }
  if (key == 'f') {
    reset(3, 0);
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
      if (map[i][j] == BIGFRUIT) {
        fill(255, 255, 255);
        circle(j*SQUARESIZE + SQUARESIZE/2, i*SQUARESIZE + SQUARESIZE/2, SQUARESIZE/1.5);
      }
      if (map[i][j] == PLAYER) {
        PacMan.display(xDir, yDir);
      }
      if (map[i][j] == GHOST) {
        for (Ghost g : ghosts) {
          if (g.getRow() == i && g.getCol() == j)g.display();
        }
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
      if (gameBoard[i][j] == BIGFRUIT) {
        bigdots.add(new Fruit(i, j, 1));
      }
    }
  }
}

int[][] readFile(String filename) {
  String[] lines = loadStrings(filename);
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
        doorLocation[0] = i;
        doorLocation[1] = j;
      } else if (lines[i].charAt(j) == '@') {
        temp[i][j] = BIGFRUIT;
      } else if (lines[i].charAt(j) == 't') {
        temp[i][j] = TELEPORT;
        teleports.add(new int[] {i, j});
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

int highScore() {
  int max = 0;
  for (int i : scores) {
    if (i > max)max = i;
  }
  return max;
}

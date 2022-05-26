import java.util.*;
import java.io.*;

final int WALL = 0;
final int SPACE = 1;
final int FRUIT = 2;
final int GHOST = 3;
final int PLAYER = 4;

//ArrayList<Fruit> dots;
//ArrayList<Ghost> ghosts;

float SQUARESIZE = 3;
int[][] gameBoard;
void setup() {
  gameBoard = readFile("level0");
  loadGame();
  size(300,240);
  
}
void draw() {
  
}
void run() {
  
}
void done() {
  
}

void

void StringToSquares(int[][] map){
  for(int i = 0; i < 100; i++){
    for(int j = 0; j < 80; j++){
      if(map[i][j] == WALL){
        fill(0,0,250);
        rect(i*SQUARESIZE,j*SQUARESIZE,SQUARESIZE, SQUARESIZE);
      }
      if(map[i][j] == FRUIT){
        fill(255,255,255);
        circle(i*SQUARESIZE,j*SQUARESIZE,1);
      }
      
    }
  }
}
  
void loadGame(){
  for(int i = 0; i < gameBoard.length; i++){
   for(int j = 0; j < gameBoard[i].length; j++){
     if(gameBoard[i][j] == SPACE){
     gameBoard[i][j] = FRUIT;
     //dots.add(new Fruit(i, j, 0));
     }
   }
  }
}

int[][] readFile(String filename) {
  String[] lines = loadStrings(filename);
  //println(lines.length + "x" + lines[0].length() );
  int len = lines[0].length();
  int[][] temp = new int[lines.length][len];
  for(int i = 0; i < lines.length; i++){
    for(int j = 0; j < len; j++){
      if(lines[i].charAt(j) == '#')temp[i][j] = WALL;
      if(lines[i].charAt(j) == '*')temp[i][j] = SPACE;
    }
    
  }
  return temp;
}

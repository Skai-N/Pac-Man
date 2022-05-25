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

void StringToSquares(int[][] map){
  for(int i = 0; i < 100; i++){
    for(int j = 0; j < 80; j++){
      if(map[i][j] == WALL){
        fill(0,0,250);
        rect(i*SQUARESIZE,j*SQUARESIZE,SQUARESIZE, SQUARESIZE);
      }
      if(map[i][j] == FRUIT){
        fill(255,255,255);
        circle(i,j,1);
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
  try {
    File text = new File(filename);
    ArrayList<int[]> inpet = new ArrayList<int[]>();
    String line = "";
    Scanner input = new Scanner(text);

    while (input.hasNextLine()) {
      line = input.nextLine();
      int[] temp = new int[line.length()];
      for (int i = 0; i < line.length(); i++) {
        if (line.charAt(i) == '#')temp[i] = WALL;
        if (line.charAt(i) == ' ')temp[i] = SPACE;
      }
      inpet.add(temp);
    }

    int[][] map = new int[inpet.size()][inpet.get(0).length];
    for (int i = 0; i < inpet.size(); i++) {
      map[i] = inpet.get(i);
    }
    return map;
  }
  catch(FileNotFoundException ex) {
    print("filenotfound");
    return new int[1][1]; // change to make rndm map
  }
}

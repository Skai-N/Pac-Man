import java.util.*;
import java.io.*;

final int WALL = 0;
final int SPACE = 1;
final int FRUIT = 2;
final int GHOST = 3;
final int PLAYER = 4;

ArrayList<Fruit> dots;
ArrayList<Ghost> ghosts;

int[][] gameBoard;
void setup() {
  gameBoard = readFile("level0");
  gameBoard.loadGame();
  size(gameBoard.length*5,gameBoard[0].length*5);
  
}
void draw() {
  
}
void run() {
  
}
void done() {
  
}

void loadGame(){
  for(int i = 0; i < board.length; i++){
   for(int j = 0; j < board[i].length; j++){
     if(board[i][j] == SPACE)board[i][j] = FRUIT;
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
    return new int[1][1];
  }
}

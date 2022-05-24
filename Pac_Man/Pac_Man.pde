import java.util.*
import java.io.*;
final int WALL = 0;
final int SPACE = 1;
final int FRUIT = 2;
final int GHOST = 3;
final int PLAYER = 4;
void setup() {
}
void draw() {
}
void run() {
}
void done() {
}

GameBoard readFile(String filename) {
  File text = new File(filename);
  ArrayList<int[]> inpet = new ArrayList<int[]>();
  String line = "";
  Scanner input = new Scanner(text);
  
  while(input.hasNextLine()){
    line = input.nextLine();
    int[] temp = new int[line.length()];
    for(int i = 0; i < line.length(); i++){
      if(line.charAt(i) == '#')temp[i] = WALL;
      if(line.charAt(i) == ' ')temp[i] = SPACE;
    }
    inpet.add(temp);
  }
  
  int[][] map = new int[inpet.size()][inpet.get(0).length];
  for(int i = 0; i < inpet.size(); i++){
    map[i] = inpet.get(i);
  }
  Gameboard game = new Gameboard(map);
  return game;
}

public class Player extends Entity {
 int lives;
 boolean invincible;
 Score points;
 
 Player(int x, int y) {
   lives = 3;
   invincible = false;
   points = new Score();
 }
 
}

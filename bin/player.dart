

class Player {
  static String name;
  static int health = 100;
  static List<String> inventory = [];

 static void loseHealth(){
    health = health - 50;
    printHealth();
  }
  static void printHealth(){
    print('Your health is ${Player.health}');
  }
  static bool isDead(){
   return health <= 0;
   if(health == 0){
     return true;
   }
  }
}


// class Player {
//   String name;
//   int health;
//   List<String> inventory;
//
//   Player({this.name,this.health,this.inventory});
//
//
// }
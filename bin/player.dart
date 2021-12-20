import 'rpg_package.dart';

class Player {
  static String name;
  static int health = 100;
  static List<String> inventory = [];
  static bool isGameOver = false;

  static void loseHealth() {
    health = health - 50;
    printHealth();
  }

  static void printHealth() {
    print('Your health is ${Player.health}');
  }

  static bool isDead() {
    print('You have sustained too much injury and bleed to death');
    return health <= 0;
  }

  static void addInventory(List<String> item) {
    print(
        'You have added ${Room.printElementWithoutBrackets(item)} to your backpack');
    inventory.addAll(item);
  }

  static void printInventory() {
    if (inventory.isNotEmpty) {
      print('You look through your backpack: $inventory');
      print('Your health: $health');
    } else {
      print('Your inventory is empty');
      print('Your health: $health');
    }
  }
}

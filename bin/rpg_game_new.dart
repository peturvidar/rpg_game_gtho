import 'rpg_package.dart';

void main() {
  // print('Welcome to ??? please select a name for your character');
  // String playerName = stdin.readLineSync();
  // Player player = Player(name: playerName);
  Map map = Map(); //initiates the map!

  while(true){   //game loop
    map.renderGame();
    String input = stdin.readLineSync();
    map.updateState(input);
  }

}

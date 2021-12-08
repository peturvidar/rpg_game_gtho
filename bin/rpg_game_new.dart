import 'rpg_package.dart';

void main() {
  Map map = Map(); //initiates the map!


  //StartGame startGame = StartGame();
  // Inventory inventory = Inventory();
  // print('Please select a name for your character:');
  // String playerName = stdin.readLineSync(encoding: Encoding.getByName('utf-8'));
  // Player player = Player(name: playerName);
  // // print(inventory);
  // print('Greetings $playerName get ready to begin the game');

  while(true){   //game loop
    map.showState();
    String input = stdin.readLineSync();
    map.updateState(input);
  }








  //Storage().optionsStorage();

}

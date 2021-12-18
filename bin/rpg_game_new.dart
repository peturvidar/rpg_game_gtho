import 'rpg_package.dart';

void main() {
  Map map = Map(); //initiates the map!
  map.iniateGame();
  while (Player.isGameOver == false) { //game loop
      map.renderGame();
      //print('waiting for input....');
      String input = stdin.readLineSync();
      map.updateState(input);
  }
  print('Game over');
}
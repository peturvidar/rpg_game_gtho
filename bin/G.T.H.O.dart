import 'rpg_package.dart';

void main() {
  Map map = Map(); //setja upp map leiksins
  map.initiateGame();
  while (Player.isGameOver == !true) { //game loop
      map.renderGame();
      if(Player.isGameOver == true){
        break;
      }
      String input = stdin.readLineSync();
      map.updateState(input);
  }
  print('Game over');
}
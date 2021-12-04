import 'dart:convert';

import 'rpg_package.dart';

void main() {
  //Map map = Map(); //initiates the map!
  Room room = Room().map;
  print('Please select a name for your character:');
  String playerName = stdin.readLineSync(encoding: Encoding.getByName('utf-8'));
  Player player = Player(name: playerName);
  print('Greetings ${player} get ready to begin the game');
  map.currentRoom.roomDescription();  //Leikurinn byrjar í storage=currentroom





  //Storage().optionsStorage();

}

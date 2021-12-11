
import 'rpg_package.dart';

class Player {
  String name;
  List<int> health = [100];
  static List<String> inventory = []; //hægt að gera growable með fixed length = []..length = 2;
  Player({this.name, this.health});
}


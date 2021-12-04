import 'rpg_package.dart';


class Room {
  Map map = Map();
  Player player = Player();
  String name;
  String description;
  String item;

  Room({this.name, this.description, this.item});
  //Room.noItem({this.name, this.description,});

  List<Room> adjacentRooms = [];

  void roomDescription() {
    print('You are in room: $description');
    int option = 1;
    print('From here you can enter:');
    for (Room room in adjacentRooms) {
      print('[$option] ${room.name}');
      option++;
    }
  }

  void addAdjacentRoom(Room room) {
    if (!adjacentRooms.contains(room)) {
      adjacentRooms.add(room); //bættu hinum sem nágranna á listann hjá mér
      room.addAdjacentRoom(this); //bættu mér sem nágranna á listann hjá honum
    }
  }
}

class Storage extends Room {
  String description;
  String item;

  Storage({this.description})
      : super(description: description, name: 'Storage', item: 'Crowbar');

  void roomDescription() {
    List<String> items = ['crowbar'];
    print('You are in room: $description');
    int option = 1;
    print('From here you can enter:');
    for (Room room in adjacentRooms) {
      print('[$option] ${room.name}');
      option++;
      print('[2] search room');
      String input = stdin.readLineSync();
      if(input == '1'){
        map.hallway.roomDescription();
      }else if(input == '2'){
        print('You find a crowbar laying in the corner\n [1] Pick up the crowbar\n[2] Leave the crowbar');
        String inputItem = stdin.readLineSync();
        if(inputItem == '1'){

        }
      }

    }
  }

}
class StorageNoItem extends Room {
  String description;
  String item;
  StorageNoItem({this.description})
      : super(description: description, name: 'Storage');
}

  // void actions() {
  //   //  Map map = Map();  //kalla í constructorin af Map bara gert einu sinni í main fallinu sama með Player() klassann
  //   // RoomsWithOutItems rooms = RoomsWithOutItems();
  //   List<String> items = ['crowbar'];
  //   Hallway hallway = Hallway();
  //   String input = stdin.readLineSync();
  //   if (input == '1') {
  //     hallway.roomDescription();
  //   } else if (input == '2') {
  //     print(
  //         'You find a crowbar in the corner\n[1] Pick up the crowbar\n[2] Leave the crowbar');
  //     String choice = stdin.readLineSync();
  //     if (choice == '1') {
  //
  //     } else if (choice == '2') {
  //       hallway.roomDescription();
  //     }
  //   }
  // }

class Hallway extends Room {
  List<String> item1 = ['note'];
  List<String> item2 = ['rusted pipe'];
  String description;
  Hallway({this.description})
      : super(description: description, name: 'Hallway');

  void roomDescription() {
    print('You are in room: $description');
    int option = 1;
    print('From here you can enter:');
    for (Room room in adjacentRooms) {
      print('[$option] ${room.name}');
      option++;
      print('[2] search room');
      String input = stdin.readLineSync();
      if(input == '1'){
        map.hallway.roomDescription();
      }else if(input == '2'){
        print('You see a table with a crumbled note and a rusted pipe standing next to it\n [1] Pick up the note and the rusted pipe\n[2] Leave them both where they are');
        String inputItem = stdin.readLineSync();
        if(inputItem == '1'){
          map.hallway.roomDescription();
        }
          //add inventory item1
        }
    }
  }
}

class Bedroom extends Room {
  String description;
  Bedroom({this.description})
      : super(description: description, name: 'Hallway');
}

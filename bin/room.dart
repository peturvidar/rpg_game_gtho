import 'map.dart';
import 'rpg_package.dart';

class Room {
  String name;
  String description;
  String item;
  List<String> items;
  bool isSearching;
  String actions;
  String mainDoor;

  Room({this.name, this.description, this.item, this.actions, this.mainDoor});

  List<Room> adjacentRooms = []; //listi yfir nágranna
  List<String> options = ['Search room', 'check inventory']; // options for room
  List<String> hallwayOptions = [
    'Try getting out the main door',
    'Search the room',
    'Check inventory'
  ];

  void addInventory(List<String> item) {
    print('You have added ${removeBrackets(item)} to your backpack');
    Player.inventory.addAll(item);
  }

  void shutter(int option) {
    int option = 1;
    print(
        'You search the room and find $actions\n[$option] Try to open the shutter');
    int input = int.parse(stdin.readLineSync());
    if (input == 1) {
      if (Player.inventory.contains('key')) {
        print(
            'You use the key to open the shutter and see a open window and you escape');
      } else {
        ///TODO hérna enda leikur þarf að implimenta break í while loopuna, ath með að gera true/false statement
        print('The shutter has a lock, you need to find a key to open it');
      }
    }
  }

  void performAction(int actionIndex) {
    //input -1 nágrannalisti.length
    int option = 1;
    if (Map.currentRoom == Map.livingRoom) {
      shutter(option);
    } else {
      searchActions(actionIndex);
    }
  }

  ///TODO updatestate þarf að spyrja fleiri spurninga
  void searchActions(int actionIndex) {
    if (actionIndex == 0) {
      if (Map.currentRoom.items.isEmpty) {
        print('You search the room and find nothing');
      } else {
        isSearching =
        true; // til að breyta state-inu á forritinu breytist í false þegar maður velur search room// og sett aftur í false til að komast aftur í main menu
        searchOptions();
        int input = int.parse(stdin.readLineSync());
        if (input == 1) {
          pickUpItem();
        } else if (actionIndex == 1) {
          isSearching = false;
        }
      }
    }
  }

  void setSearch(bool search) {
    ///TODO þarf að gera true/false fyrir items svipað þessu ath!
    isSearching = search;
  }
  String removeBrackets(List<String> input){
    return input.toString().replaceAll('[', '').replaceAll(']', '');
}
  void roomDescription() {
    print('You are in room: $description');
    int option = 1;
    print('From here you can enter:');
    for (Room room in adjacentRooms) {
      print('[$option] ${room.name}');
      option++;
    }
    if (Map.currentRoom == Map.entrance) {
      print(
          'You try getting out the main door but it´s barricaded from the outside');
    } else {
      for (String action in options) {
        print('[$option] $action');
        option++;
      }
    }
  }

  // if (option > adjacentRooms.length && option > options.length) {
  // }   ///TODO gæti verið að þetta valdi error
  void pickUpItem() {
    addInventory(items);
    items.removeAt(0);
  }

  void addAdjacentRoom(Room room) {
    if (!adjacentRooms.contains(room)) {
      adjacentRooms.add(room); //bættu hinum sem nágranna á listann hjá mér
      room.addAdjacentRoom(this); //bættu mér sem nágranna á listann hjá honum
    }
  }

  void searchOptions() {
    ///TODO er að vinna hér
    int option = 1;
    print('You search the room and $actions\n[$option] Pick up ${removeBrackets(items)}');
    print('[2] Leave the ${removeBrackets(items)}');
  }
}

class Storage extends Room {
  List<String> items;
  String description;
  String actions;
  Storage({this.description, this.actions, this.items})
      : super(description: description, name: 'Storage');
}

class Hallway extends Room {
  List<String> enemy;
  String description;
  List<String> items;
  String actions;
  String mainDoor;
  Hallway({this.description, this.items, this.actions, this.mainDoor,this.enemy})
      : super(description: description, name: 'Hallway');
}

class Bedroom extends Room {
  List<String> enemy;
  String actions;
  List<String> items;
  String description;
  Bedroom({this.description, this.items, this.actions,this.enemy})
      : super(description: description, name: 'Bedroom');
}

class Balcony extends Room {
  List<String> enemy;
  String actions;
  List<String> items;
  String description;
  Balcony({this.description, this.items, this.actions,this.enemy})
      : super(description: description, name: 'Balcony');
}

class Kitchen extends Room {
  String actions;
  List<String> items;
  String description;
  Kitchen({this.description, this.items, this.actions})
      : super(description: description, name: 'Kitchen');
}

class Bathroom extends Room {
  String actions;
  List<String> items;
  String description;
  Bathroom({this.description, this.items, this.actions})
      : super(description: description, name: 'Bathroom');
}

class LivingRoom extends Room {
  String description;
  String actions;
  List<String> items;
  LivingRoom({this.description, this.actions, this.items})
      : super(description: description, name: 'Living Room');
}

class Attic extends Room {
  String description;
  Attic({this.description}) : super(description: description, name: 'Attic');
}

class Entrance extends Room {
  String description;
  Entrance({this.description})
      : super(description: description, name: 'Main entrance');
}

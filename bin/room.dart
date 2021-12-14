import 'rpg_package.dart';

class Room {
  String name;
  String description;
  bool enemy;
  List<String> items;
  bool isSearching;
  String actions;
  String mainDoor;
  static bool endGame = true;

  Room({this.name, this.description, this.actions, this.mainDoor});
  List<Room> adjacentRooms = []; //listi yfir nágranna
  List<String> options = ['Search room', 'check inventory and health']; // options for room

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
        endGame = false;
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
      searchActions(actionIndex);
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
        if (Map.currentRoom != Map.bathroom) {
          searchOptions();
        } else {
          searchOptionsBathroom();
        }
        int input = int.parse(stdin.readLineSync());
        if (input == 1) {
          pickUpItem();
        } else if (input == 1) {
          isSearching = false;
        }
      }
    }
  }

  // void searchActionsGamalt(int actionIndex) {
  //   if (actionIndex == 0) {
  //     if (Map.currentRoom.items.isEmpty) {
  //       print('You search the room and find nothing');
  //     } else {
  //       isSearching =
  //       true; // til að breyta state-inu á forritinu breytist í false þegar maður velur search room// og sett aftur í false til að komast aftur í main menu
  //       searchOptions();
  //       int input = int.parse(stdin.readLineSync());
  //       if (input == 1) {
  //         pickUpItem();
  //       } else if (actionIndex == 1) {
  //         isSearching = false;
  //       }
  //     }
  //   }
  // }
  void setSearch(bool search) {
    isSearching = search;
  }

  // void engageEnemy(int option) {
  //   if (Map.currentRoom.enemy == true) {
  //     //int option = 1;
  //     print(
  //         'There is a zombie lurking the ${Map.currentRoom.description} you need to kill him to continue'); //fasi 1!
  //     print('[$option] Attack the zombie using a item from your backpack');
  //     int input = int.parse(stdin.readLineSync());
  //
  //     /// TODO
  //     if (input == 1 && Player.inventory.isNotEmpty) {
  //       print("You engage the zombie and kill him with ${Player.inventory[0]}");
  //       Player.inventory.removeAt(0);
  //       Map.currentRoom.enemy = false;
  //     } else {
  //       print(
  //           'You don´t have anything in your backpack to kill the zombie you still wish to continue?\n[1] Engage the zombie anyway\n[2] Don´t engage the zombie'); //fasi 2!
  //     }
  //     int input2 = int.parse(stdin
  //         .readLineSync()); //input til að engage enemy without item or don´t engage
  //     if (input2 == 1) {
  //       print(
  //           'You try fighting the zombie with your bare hands and barely take him down at the cost of half of your life');
  //       Player.loseHealth();
  //       if (Player.isDead()) {
  //         print('You are dead, game over!');
  //       }
  //       Map.currentRoom.enemy = false;
  //     }
  //   }
  // }

  void engageEnemy(int option) {
    if (Map.currentRoom.enemy == true) {
      print(
          'There is a zombie lurking the ${Map.currentRoom.description} you need to kill him to continue'); //fasi 1!
      print('[$option] Attack the zombie using a item from your backpack');
      int input = int.parse(stdin.readLineSync());

      if (input == 1 && Player.inventory.isNotEmpty) {
        print(
            "You engage the zombie and kill him with your ${Player.inventory[0]}");
        Player.inventory.removeAt(0);
        Map.currentRoom.enemy = false;
      } else {
        print(
            'You engage the zombie but you don´t have anything to fight him with in your backpack,\n'
            ' it´s a hard fight but you manage to kill the zombie, but you are badly wounded \n'
            '"I don´t think I can do that again"');
        Player.loseHealth();
        Map.currentRoom.enemy = false;
        if (Player.isDead()) {
          print('You are dead, game over!');
        }
      }
    }
  }

  String removeBrackets(List<String> input) {
    ///TODO gera fall hérna með for lykkju til að prenta út lista
    return input.toString().replaceAll('[', '').replaceAll(']', '');
  }

  // void roomDescription() {
  //   print('You are in room: $description');
  //   int option = 1;
  //   print('From here you can enter:');
  //   for (Room room in adjacentRooms) {
  //     print('[$option] ${room.name}');
  //     option++;
  //   }
  //   if (Map.currentRoom == Map.entrance) {
  //     print(
  //         'You try getting out the main door but it´s barricaded from the outside');
  //   } else {
  //     for (String action in options) {
  //       print('[$option] $action');
  //       option++;
  //     }
  //   }
  // }
  static void invalidOption() {
    print('You need to enter a valid option');
  }

  void entranceDescription() {
    print(
        'You try getting out the main door but it´s barricaded from the outside');
  }

  void roomDescriptionPrufa() {  //lýsing á herbergi
    int option = 1;
    if (Map.currentRoom.enemy == true) {  //ef óvinur er í herbergi þarf að engage-a hann áður en hægt er að fá frekar valmöguleika
      engageEnemy(option);
    }
    print(
        'You are in room: $description'); // ef óvinur þarf að drepa til að komast áfram
    print('From here you can enter:');
    for (Room room in adjacentRooms) {  // prentar út hvaða herbergi eru nágrannar og gefur valmöguleika að skipta um herbergi
      print('[$option] ${room.name}');
      option++;
    }
    if (Map.currentRoom == Map.entrance) { //sér möguleiki fyrir entrance
      entranceDescription();
    } else {
      for (String action in options) {  //prentar út actions fyrir hvert herbergi
        ///TODO ath skilgreina actions og options
        print('[$option] $action');
        option++;
      }
    }
  }

  void pickUpItem() {
    addInventory(items);
    items.removeAt(0);
  }

  void addAdjacentRoom(Room room) { //til að bæta herbergjum á list sem nágrannar hvers annars
    if (!adjacentRooms.contains(room)) {
      adjacentRooms.add(room); //bættu hinum sem nágranna á listann hjá mér
      room.addAdjacentRoom(this); //bættu mér sem nágranna á listann hjá honum
    }
  }

  void crackSafe() { //function til að opna peningaskápinn
    print('Enter code:');
    try {
      int input = int.parse(stdin.readLineSync());
      if (input == 3457) {
        print('"Click", the safe opens and you find a key inside it');
        print('You have added a key to your backpack');
        Player.inventory.add('key');//ef rétt input
        Map.currentRoom.items.removeAt(0);
        Map.currentRoom.roomDescriptionPrufa();
      } else {
        print('That code does not seem to work');
      }
    } catch (e) {
      print('You have entered an invalid number, please try again');
      crackSafe();
    }
  }

  void searchOptionsBathroom() {// sér option function fyrir bathroom til að gefa möguleika á að opna peningaskáp
    int option = 1;
    print(
        'You search the room and $actions\n[$option] Enter 4 digit code to unlock the safe\n[${option + 1}] Leave the safe');
    int input = int.parse(stdin.readLineSync());
    if (input == 1) {
      crackSafe();
    // } else if (input == 2) {
    //   Map.currentRoom.roomDescriptionPrufa();
     }
  }

  void searchOptions() {
    int option = 1;
    print(
        'You search the room and $actions\n[$option] Pick up ${removeBrackets(items)}');

    ///TODO
    print('[2] Leave the ${removeBrackets(items)}');
  }
}

class Storage extends Room {
  bool enemy;
  List<String> items;
  String description;
  String actions;
  Storage({this.description, this.actions, this.items, this.enemy})
      : super(description: description, name: 'Storage');
}

class Hallway extends Room {
  bool enemy;
  String description;
  List<String> items;
  String actions;
  String mainDoor;
  Hallway(
      {this.description, this.items, this.actions, this.mainDoor, this.enemy})
      : super(description: description, name: 'Hallway');
}

class Bedroom extends Room {
  bool enemy;
  String actions;
  List<String> items;
  String description;
  Bedroom({this.description, this.items, this.actions, this.enemy})
      : super(description: description, name: 'Bedroom');
}

class Balcony extends Room {
  bool enemy;
  String actions;
  List<String> items;
  String description;
  Balcony({this.description, this.items, this.actions, this.enemy})
      : super(description: description, name: 'Balcony');
}

class Kitchen extends Room {
  bool enemy;
  String actions;
  List<String> items;
  String description;
  Kitchen({this.description, this.items, this.actions, this.enemy})
      : super(description: description, name: 'Kitchen');
}

class Bathroom extends Room {
  bool enemy;
  String actions;
  List<String> items;
  String description;
  Bathroom({this.description, this.items, this.actions, this.enemy})
      : super(description: description, name: 'Bathroom');
}

class LivingRoom extends Room {
  bool enemy;
  String description;
  String actions;
  List<String> items;
  LivingRoom({this.description, this.actions, this.items, this.enemy})
      : super(description: description, name: 'Living Room');
}

class Attic extends Room {
  String description;
  Attic({this.description}) : super(description: description, name: 'Attic');
}

class Entrance extends Room {
  bool enemy;
  String description;
  Entrance({this.description, this.enemy})
      : super(description: description, name: 'Main entrance');
}

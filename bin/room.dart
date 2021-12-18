import 'rpg_package.dart';

class Room {
  String name;
  String description;
  bool enemy;
  List<String> items;
  bool isSearching;
  List<String> actions = [
    'Search room',
    'check inventory and health'
  ]; // valmöguleikar fyrir herbergin
  String searchResult;

  Room({this.name, this.description});
  List<Room> adjacentRooms = []; //listi yfir nágranna

  void addInventory(List<String> item) {
    print('You have added ${removeBrackets(item)} to your backpack');
    Player.inventory.addAll(item);
  }

  void openShutterMiniGame() {
    //function fyrir hlera í living room
    int option = 1;
    print(
        'You search the room and find $searchResult\n[$option] Try to open the shutter');
    try {
      int input = int.parse(stdin.readLineSync());
      if (input == 1 && Player.inventory.contains('key')) {
        print(
            'You use the key to open the shutter and climb up to the attic, you notice a small open\n'
                'window and crawl out of it and climb down the stair that lie right beneath it.\n'
                '"Congratulations you have managed to escape alive, see you again in G.T.H.O 2"');
        Player.isGameOver = true;
      } else {
        print('The shutter has a lock, you need to find a key to open it');
      }
    } catch (e){
      invalidInput();
      return;
    }
    }


  void performSearchAction() {
    if (Map.currentRoom.items.isEmpty) {
      print('You search the room and find nothing');
    } else {
      isSearching =
          true; // til að breyta state-inu á forritinu breytist í false þegar maður velur search room// og sett aftur í false til að komast aftur í main menu
      if (Map.currentRoom != Map.bathroom) {
        interactiveSearch();
      } else {
        interactiveBathroomSearch();
      }
    }
    isSearching = false;
  }

  void performAction(int actionIndex) {  ///TODO ath varðandi living room fastur í search mode
    if (Map.currentRoom != Map.livingRoom) {
      if (actions[actionIndex] == 'Search room') {
        //search room
        performSearchAction();
      } else if (actions[actionIndex] == 'check inventory and health') {
        Player.printInventory();
      }
    }else {
      openShutterMiniGame();
    }
  }

  void setSearch(bool search) {
    //method til að skipta yfir í search state
    isSearching = search;
  }

  void engageEnemy(int option) {
    //method til að ráðast á óvin
    if (Map.currentRoom.enemy == true) {
      // ef óvinur er til staðar
      print(
          'There is a zombie lurking the ${Map.currentRoom.description} you need to kill him to continue'); //fasi 1!
      print('[$option] Attack the zombie using a item from your backpack');
      try {
        int input = int.parse(stdin.readLineSync());
        if (input == 1 && Player.inventory.isNotEmpty) {
          //ef ráðist er á óvin og item er til staðar í inventory
          print(
              "You engage the zombie and kill him with your ${Player
                  .inventory[0]} but your ${Player.inventory[0]} breaks");
          Player.inventory.removeAt(0); // tekur út 1 item í inventory
          Map.currentRoom.enemy = false;
        } else {
          print(
              'You engage the zombie but you don´t have anything to fight him with in your backpack,\n'
                  ' it´s a hard fight but you manage to kill the zombie, but you are badly wounded \n'
                  '"I don´t think I can do that again"');
          Player.loseHealth();
          Map.currentRoom.enemy = false;
          if (Player.isDead()) {
            Player.isGameOver = true;
          }
        }
      }catch (e){
        invalidInput();
        engageEnemy(option);
      }
    }
  }

  String removeBrackets(List<String> input) {
    ///TODO gera fall hérna með for lykkju til að prenta út lista
    return input.toString().replaceAll('[', '').replaceAll(']', '');
  }

  static void invalidInput() {
    print('You need to enter a valid option');
  }

  void entranceDescription() {
    print(
        'You try getting out the main door but it´s barricaded from the outside');
  }

  void roomDescription() {
    //lýsing á herbergi
    int option = 1;
    if (Map.currentRoom.enemy == false) {
      //ef óvinur er í herbergi þarf að engage-a hann áður en hægt er að fá frekar valmöguleika
      print(
          'You are in room: $description'); // ef óvinur er til staðar í herberbergi þarf að drepa hann til að komast áfram
      print('From here you can enter:');
      for (Room room in adjacentRooms) {
        // prentar út hvaða herbergi eru nágrannar og gefur valmöguleika að skipta um herbergi
        print('[$option] ${room.name}');
        option++;
      }
      if (Map.currentRoom == Map.entrance) {
        //sér möguleiki fyrir entrance
        entranceDescription();
      } else {
        for (String action in actions) {
          //prentar út actions fyrir hvert herbergi
          print('[$option] $action');
          option++;
        }
      }
    }else{
      engageEnemy(option);
      roomDescription();
    }
  }

  void pickUpItem() {
    addInventory(items);
    items.removeAt(0);
  }

  void addAdjacentRoom(Room room) {
    //til að bæta herbergjum á list sem nágrannar hvers annars
    if (!adjacentRooms.contains(room)) {
      adjacentRooms.add(room); //bættu hinum sem nágranna á listann hjá mér
      room.addAdjacentRoom(this); //bættu mér sem nágranna á listann hjá honum
    }
  }

  void crackSafeMiniGame() {
    //function til að opna peningaskápinn
    print('Enter code:');
    try {
      int input = int.parse(stdin.readLineSync());
      if (input == 3457) {// ef rétt input
        print('"Click", the safe opens and you find a key inside it');
        print('You have added a key to your backpack');
        Player.inventory.add(items[0]);
        Map.currentRoom.items.removeAt(0);
      } else {
        print('That code does not seem to work');
      }
    } catch (e) { // ef ekki eru slegnar inn int tölur þá prenta þetta og loopa til baka.
      print('You have entered an invalid number, please try again');
      crackSafeMiniGame();
    }
  }

  void interactiveBathroomSearch() {
    // sér function fyrir bathroom til að gefa möguleika á að opna peningaskáp
    int option = 1;
    print(
        'You search the room and $searchResult\n[$option] Enter 4 digit code to unlock the safe\n[${option + 1}] Leave the safe');
    try {
      int input = int.parse(stdin.readLineSync());
      if (input == 1) {
        crackSafeMiniGame();
      }
    }catch (e){
      invalidInput();
      return;
    }
  }

  void interactiveSearch() {
    int option = 1;
    print(
        'You search the room and $searchResult\n[$option] Pick up ${removeBrackets(items)}');
    print('[2] Leave the ${removeBrackets(items)}');
   try {
     int input = int.parse(stdin.readLineSync());

     if (input == 1) {
       pickUpItem();
     }
   }catch (e){
     invalidInput();
     return;

   }
  }
}

class Storage extends Room {
  bool enemy;
  String searchResult;
  List<String> items;
  String description;
  Storage({this.description, this.items, this.enemy, this.searchResult})
      : super(description: description, name: 'Storage');
}

class Hallway extends Room {
  bool enemy;
  String description;
  List<String> items;
  String searchResult;
  String mainDoor;
  Hallway(
      {this.description,
      this.items,
      this.searchResult,
      this.mainDoor,
      this.enemy})
      : super(description: description, name: 'Hallway');
}

class Bedroom extends Room {
  bool enemy;
  String searchResult;
  List<String> items;
  String description;
  Bedroom({this.description, this.items, this.searchResult, this.enemy})
      : super(description: description, name: 'Bedroom');
}

class Balcony extends Room {
  bool enemy;
  String searchResult;
  List<String> items;
  String description;
  Balcony({this.description, this.items, this.searchResult, this.enemy})
      : super(description: description, name: 'Balcony');
}

class Kitchen extends Room {
  bool enemy;
  String searchResult;
  List<String> items;
  String description;
  Kitchen({this.description, this.items, this.searchResult, this.enemy})
      : super(description: description, name: 'Kitchen');
}

class Bathroom extends Room {
  bool enemy;
  String searchResult;
  List<String> items;
  String description;
  Bathroom({this.description, this.items, this.searchResult, this.enemy})
      : super(description: description, name: 'Bathroom');
}

class LivingRoom extends Room {
  bool enemy;
  String description;
  String searchResult;
  List<String> items;
  LivingRoom({this.description, this.searchResult, this.items, this.enemy})
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

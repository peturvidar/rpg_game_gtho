import 'rpg_package.dart';

class Room  {

  String name;
  String description;
  String item;
  bool isSearching;


  Room({this.name, this.description, this.isSearching = false,this.item});
  List<String> inventory = [];
  List<Room> adjacentRooms = []; //listi yfir nágranna
  List<String> options = ['Search room', 'check inventory']; // options for room
  List<String> actionsStorage = ['[1] Pick up crowbar\n[2] Leave the crowbar where it is'];
  String storageItem = 'Crowbar';          ///TODO actions for room
  List<String> itemList = [];

  // void performAction(int actionIndex) {
  //   //input -1 nágrannalisti.length
  //
  //   if (actionIndex == 0) {
  //     isSearching = true; // til að breyta state-inu á forritinu breytist í false þegar maður velur search room
  //               // og sett aftur í false til að komast aftur í main menu
  //     print(actionsStorage[0]);
  //     int input = int.parse(stdin.readLineSync());
  //     if(input == 1){
  //       inventory.add(storageItem);
  //       print(inventory);
  //      // print('you add crowbar to your inventory');
  //     }
  //   } else if (actionIndex == 1) {
  //     isSearching = false;
  //   }
  //   // int userInput = int.parse(stdin.readLineSync());
  //   // if (userInput == 1) {




  void roomOptions(Room options){


  }
  // void setSearch(bool search) {
  //   ///TODO updatestate þarf að spyrja fleiri spurninga
  //   isSearching = search;
  // }

  void roomDescription() {
    print('You are in room: $description');
    int option = 1;
    print('From here you can enter:');
    for (Room room in adjacentRooms) {
      print('[$option] ${room.name}');
      option++;
    }
    for (String action in options) {
      print('[$option] $action');
      option++;
    }
  }

  void addAdjacentRoom(Room room) {
    if (!adjacentRooms.contains(room)) {
      adjacentRooms.add(room); //bættu hinum sem nágranna á listann hjá mér
      room.addAdjacentRoom(this); //bættu mér sem nágranna á listann hjá honum
    }
  }

  void addItemList(String item){
    if(!itemList.contains(item)) {
      itemList.add(item);
      print(itemList);
    }

  }
}

class Storage extends Room {
  //eftir að bæta inní There is a crowbar lying on a shelf\n
  String description;
  String item = 'Crowbar';

  Storage({this.description, this.item})
      : super(description: description, name: 'Storage', item: item);
  // List<String> actionOptions(){
  //   List<String> actionsStorage = [
  //     'Pick up the crowbar',
  //     'Leave them both where they are'
  //   ];
  //   return actionsStorage;
  // }

  // void performActionStorage(int actionIndex) {
  //   //input -1 nágrannalisti.length
  //   print('Performing action: ' + actions2[actionIndex]);
  //   if (actionIndex == 0) {
  //     isSearching = true; // til að breyta state-inu á forritinu breytist í false þegar maður velur search room
  //     // og sett aftur í false til að komast aftur í main menu
  //   } else if (actionIndex == 1) {
  //     isSearching = false;
  //   }
  //   int userInput = int.parse(stdin.readLineSync());
  //   if (userInput == 1) {}
  // }
}

//   void roomDescription() {
//     List<String> items = ['crowbar'];
//     print('You are in room: $description');
//     int option = 1;
//     print('From here you can enter:');
//     for (Room room in adjacentRooms) {
//       print('[$option] ${room.name}');
//       option++;
//       print('[2] search room');
//       String input = stdin.readLineSync();
//       if (input == '1') {
//         // map.hallway.roomDescription();
//       } else if (input == '2') {
//         print(
//             'You find a crowbar laying in the corner\n [1] Pick up the crowbar\n[2] Leave the crowbar');
//         String inputItem = stdin.readLineSync();
//         if (inputItem == '1') {}
//       }
//     }
//   }
// }

// class StorageNoItem extends Room {
//   //Storage description when the you have already searched the room
//   String description;
//   Map map = Map();
//
//   StorageNoItem({this.description})
//       : super(description: description, name: 'Storage');
//
//   void roomDescriptionNoItem() {
//     print('You are in room: $description');
//     int option = 1;
//     print('From here you can enter:');
//     for (Room room in adjacentRooms) {
//       print('[$option] ${room.name}');
//       option++;
//     }
//   }
// }
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
  // List<String> item1 = ['note'];
  // List<String> item2 = ['rusted pipe'];
  String description;

  Hallway({this.description})
      : super(description: description, name: 'Hallway');

  // void roomDescription() {
  //   print('You are in room: $description');
  //   int option = 1;
  //   print('From here you can enter:');
  //   for (Room room in adjacentRooms) {
  //     print('[$option] ${room.name}');
  //     option++;
  //     print('[2] search room');
  //     String input = stdin.readLineSync();
  //     if (input == '1') {
  //      // map.hallway.roomDescription();
  //     } else if (input == '2') {
  //       print(
  //           'You see a table with a crumbled note and a rusted pipe standing next to it\n [1] Pick up the note and the rusted pipe\n[2] Leave them both where they are');
  //       String inputItem = stdin.readLineSync();
  //       if (inputItem == '1') {
  //         print('Rusted pipe and a note');
  //         print('[1] Read the note\n[2] Dont read note');
  //         String inputNote = stdin.readLineSync();
  //         if (inputNote == '1') {
  //           print('345786');
  //         } else if (inputNote == '2') {
  //          // map.hallway.roomDescription();
  //         }
  //         //map.hallway.roomDescription();
  //       }
  //       //add inventory item1
  //     }
  //   }
  // }
}

class Bedroom extends Room {
  String description;
  Bedroom({this.description})
      : super(description: description, name: 'Bedroom');
}

class Balcony extends Room {
  String description;
  Balcony({this.description})
      : super(description: description, name: 'Balcony');
}

class Kitchen extends Room {
  String description;
  Kitchen({this.description})
      : super(description: description, name: 'Kitchen');
}

class Bathroom extends Room {
  String description;
  Bathroom({this.description})
      : super(description: description, name: 'Bathroom');
}

class LivingRoom extends Room {
  String description;
  LivingRoom({this.description})
      : super(description: description, name: 'Living Room');
}

class Attic extends Room {
  String description;
  Attic({this.description}) : super(description: description, name: 'Attic');
}
class MainDoor extends Room {
  String description;
  MainDoor({this.description}) : super(description: description, name: 'Try to get out the main door');
}
class StorageItem extends Room {
  String item;
  StorageItem({this.item})
      : super(item: 'crowbar');

}
class HallwayItem extends Room {
  String item;
  HallwayItem({this.item})
      : super(item: 'crumbled note');
}
class HallwayItemOption extends Room {
  String item;
  HallwayItemOption({this.item})
      : super(item: item);
}
class StorageItemOption extends Room {
  String item;
  StorageItemOption({this.item})
      : super(item: item);
}
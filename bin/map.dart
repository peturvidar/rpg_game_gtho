import 'rpg_package.dart';

class Map {
  Room storage;
  Room hallway;
  Room bedroom;
  Room balcony;
  Room bathroom;
  Room kitchen;
  Room livingRoom;
  Room attic;
  Room mainDoor;
  Room storageItem;
  Room hallwayItem;
  Room hallwayOption;
  Room storageOption;
  //State
  Room currentRoom;
  bool isSearching;
  List<String> options = ['Search room', 'check inventory']; // options for room
  List<String> actionsStorage = ['[1] Pick up crowbar\n[2] Leave the crowbar where it is'];
  Map() {
    // hallwayItem = HallwayItem(item: 'crumbled note');
    storageItem = StorageItem(item: 'crowbar');
    // hallwayOption = HallwayItemOption(item: 'crumbled note');
    // storageOption = StorageItemOption(item: 'crowbar');
    storage = Storage(description: 'Storage',item: 'crowbar');
    hallway = Hallway(description: 'Hallway');
    bedroom = Bedroom(description: 'Bedroom');
    balcony = Balcony(description: 'Balcony');
    kitchen = Kitchen(description: 'Kitchen');
    bathroom = Bathroom(description: 'Bathroom');
    livingRoom = LivingRoom(description: 'Living Room');
    attic = Attic(description: 'Attic');
    mainDoor = MainDoor(description: 'Main door');
    currentRoom = storage; // current room er ástand leiksins
    storage.addAdjacentRoom(hallway); //búa til nágranna
    hallway.addAdjacentRoom(bedroom);
    bedroom.addAdjacentRoom(balcony);
    bedroom.addAdjacentRoom(hallway);
    bathroom.addAdjacentRoom(kitchen);
    hallway.addAdjacentRoom(kitchen);
    livingRoom.addAdjacentRoom(hallway);
    livingRoom.addAdjacentRoom(attic);
    hallway.addAdjacentRoom(mainDoor);
    // storageOption.addItemList('crowbar');
    // hallwayOption.addItemList('crumbled note');
  }

  void updateState(String input) {
    //þessi method uppfærir current room
    int userInput = int.parse(input);
    //go through neighbours
    if (userInput - 1 < currentRoom.adjacentRooms.length) {
      changeCurrentRoom(userInput);
    } else {
      //ef ekki í gegnum nágranna þá förum við í actions
      currentRoom.performAction(
          userInput - 1 - currentRoom.adjacentRooms.length);
    }
    // int userActionInput = int.parse(input);
    // if (userActionInput == '1') {
    //   storageOptions;
    // }
  }
  void performAction(int actionIndex) {
    //input -1 nágrannalisti.length

    if (actionIndex == 0) {
      isSearching = true; // til að breyta state-inu á forritinu breytist í false þegar maður velur search room
      // og sett aftur í false til að komast aftur í main menu
      print(currentRoom.item);
      int input = int.parse(stdin.readLineSync());
      if(input == 1){
        // inventory.add(storageItem);
        // print(inventory);
        print('you add crowbar to your inventory');
      }
    } else if (actionIndex == 1) {
      isSearching = false;
    }
    // int userInput = int.parse(stdin.readLineSync());
    // if (userInput == 1) {

    void setSearch(bool search) {
      ///TODO updatestate þarf að spyrja fleiri spurninga
      isSearching = search;
    }

  }
  void showState() {
    // if currentRoom is isSearching false! do something else
    currentRoom.roomDescription(); //Leikurinn byrjar í storage=currentroom
  }

  void changeCurrentRoom(int userInput) {
    currentRoom = currentRoom.adjacentRooms[userInput - 1];
  }

  void itemOptions(int input) {
    if (input == 1) {

    }
  }
}

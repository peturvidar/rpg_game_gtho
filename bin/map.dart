import 'rpg_package.dart';

 class Map {
  Room storage;
  Room hallway;
  Room bedroom;
  Room balcony;
  Room bathroom;
  Room kitchen;
  static Room livingRoom;
  Room attic;
  static Room entrance;
  //State
  static Room currentRoom;
  Map() {
    storage = Storage(description: 'Storage',items: ['crowbar'],actions: 'you find a crowbar lying on a shelf');
    hallway = Hallway(description: 'Hallway', items: ['brick'],actions: 'there is a brick lying on the floor', mainDoor: 'Main Door', enemy: ['zombie']);
    bedroom = Bedroom(description: 'Bedroom', items: ['chair leg'],actions: ' and find a leg of a chair lying under the bed, hmm might be useful' );
    balcony = Balcony(description: 'Balcony', items: ['crumbled note'], actions: 'you find lying on the ground crumbled note with the numbers 3457 written on it');
    kitchen = Kitchen(description: 'Kitchen', items: ['frying pan'], actions:'and see a frying pan hanging over the cabinets, "this might come in handy"');
    bathroom = Bathroom(description: 'Bathroom', items: ['lock box'], actions: 'you find after a long search a lock box "Damn its locked I need a 4 digit code to unlock it');
    livingRoom = LivingRoom(description: 'Living Room',items: ['candlestick'],actions: 'stairs in the corner leading to a shutter');
    attic = Attic(description: 'Attic');
    entrance = Entrance(description: 'Main entrance');
    currentRoom = storage; // current room er ástand leiksins
    storage.addAdjacentRoom(hallway); //búa til nágranna
    hallway.addAdjacentRoom(bedroom);
    bedroom.addAdjacentRoom(balcony);
    bedroom.addAdjacentRoom(hallway);
    bathroom.addAdjacentRoom(kitchen);
    hallway.addAdjacentRoom(kitchen);
    livingRoom.addAdjacentRoom(hallway);
    hallway.addAdjacentRoom(entrance);

  }
  void updateState(String input) {  //þessi method uppfærir current room
    roomActions(input);
  }
  void roomActions(String input){
    int userInput = int.parse(input);
    if (userInput - 1 < currentRoom.adjacentRooms.length) {   //go through neighbours
      changeCurrentRoom(userInput);
    } else if(userInput - 1 == currentRoom.adjacentRooms.length) {
      currentRoom.performAction(userInput - 1 - currentRoom.adjacentRooms.length);   //ef ekki í gegnum nágranna þá förum við í actions
    }else{
      checkInventory();
      /// TODO skoða að taka út brackets á lista fyrir prent
    }
  }
  void renderGame() {
    // if currentRoom is isSearching false! do something else
    currentRoom.roomDescription(); //Leikurinn byrjar í storage=currentroom
  }

  void changeCurrentRoom(int userInput) {
    currentRoom = currentRoom.adjacentRooms[userInput - 1];
  }
  void checkInventory() {
    print('You look through your backpack: ${Player.inventory}');
  }
}

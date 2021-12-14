import 'rpg_package.dart';

class Map {
  Room storage;
  Room hallway;
  Room bedroom;
  Room attic;
  Room kitchen;
  static Room balcony;
  static Room livingRoom;
  static Room bathroom;
  static Room entrance;

  //State
  static Room currentRoom;
  static Room lastRoom;
  static Room previousRoom;

  Map() {
    storage = Storage(
        description: 'storage',
        items: ['crowbar'],
        actions: 'you find a crowbar lying on a shelf',  ///TODO actions á að vera actions ath breyta
        enemy: false);
    hallway = Hallway(
        description: 'hallway',
        items: ['brick'],
        actions: 'there is a brick lying on the floor',
        mainDoor: 'Main Door',
        enemy: true);
    bedroom = Bedroom(
        description: 'bedroom',
        items: ['chair leg'],
        actions:
            ' and find a leg of a chair lying under the bed, "might be useful"',
        enemy: true);
    balcony = Balcony(
        description: 'balcony',
        items: ['crumbled note "3457"'],
        actions:
            'you find lying on the ground crumbled note with the numbers 3457 written on it',
        enemy: true);
    kitchen = Kitchen(
        description: 'kitchen',
        items: ['frying pan'],
        actions:
            'and see a frying pan hanging over the cabinets, "this might come in handy"',
        enemy: false);
    bathroom = Bathroom(
        description: 'bathroom',
        items: ['key'],
        actions:
            'and you find a hidden safe behind one of the cabinets\n"its locked you´ll need a 4 digit code to unlock it"',
        enemy: false);
    livingRoom = LivingRoom(
        description: 'living Room',
        items: [],
        actions: 'stairs in the corner leading to a shutter',
        enemy: false);
    attic = Attic(description: 'attic');
    entrance = Entrance(description: 'main entrance', enemy: false);
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



  void updateState(String input) {
    //þessi method uppfærir current room
    int userInput = int.parse(input);

      if (userInput - 1 <= currentRoom.adjacentRooms.length) {
        //go through neighbours
        changeCurrentRoomByIndex(userInput);
        // } else if (userInput - 1 >= currentRoom.adjacentRooms.length) {
      } else if (userInput - 1 < currentRoom.adjacentRooms.length &&
          userInput - 1 <
              currentRoom.adjacentRooms.length + currentRoom.actions.length) {
        currentRoom.performAction(userInput - 1 - currentRoom.adjacentRooms
            .length); //ef ekki í gegnum nágranna þá förum við í actions
      } else {
        checkInventory();
      }
    }


  void renderGame() {
    // if currentRoom is isSearching false! do something else
    currentRoom.roomDescriptionPrufa(); //Leikurinn byrjar í storage=currentroom
  }

  void iniateGame() {
    print('Welcome to G.T.H.O');
    print('Please enter your name to start the game');
    String input = stdin.readLineSync(encoding: Encoding.getByName('utf-8'));
    print(
        'Hello $input its seems you have just woken up disoriented in an unknown house, your phone and wallet\n'
            'seem to be missing, all you carry is a old torn backpack, you think to yourself\n'
            '"I have to get the hell out of here this place looks creepy as hell I should look around and see if I find something useful,\n you grab the backpack\n'
            'and get on your feet and start looking around');
  }

  void changeCurrentRoomByIndex(int userInput) {
    previousRoom = currentRoom;
    currentRoom = currentRoom.adjacentRooms[userInput - 1];
  }
  void changeCurrentRoom(Room room) {
    previousRoom = currentRoom;
    currentRoom = room;
  }
  void goToPreviousRoom(){
    currentRoom = previousRoom;
  }

  void checkInventory() {
    if(Player.inventory.isNotEmpty) {
      print('You look through your backpack: ${Player.inventory}');
      print('Your health: ${Player.health}');
    }else{
      print('Your inventory is empty');
      print('Your health: ${Player.health}');
    }
  }
}

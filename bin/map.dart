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

  Map() {
    //kort af húsinu
    storage = Storage(
        description: 'storage',
        items: ['baseball bat'],
        searchResult: 'you find a baseball bat lying on a shelf',

        ///TODO actions á að vera actions ath breyta
        enemy: false);
    hallway = Hallway(
        description: 'hallway',
        items: ['brick'],
        searchResult: 'there is a brick lying on the floor',
        mainDoor: 'Main Door',
        enemy: true);
    bedroom = Bedroom(
        description: 'bedroom',
        items: ['chair leg'],
        searchResult:
            ' and find a leg of a chair lying under the bed, "might be useful"',
        enemy: true);
    balcony = Balcony(
        description: 'balcony',
        items: ['crumbled note "3457"'],
        searchResult:
            'you find lying on the ground crumbled note with the numbers 3457 written on it',
        enemy: true);
    kitchen = Kitchen(
        description: 'kitchen',
        items: ['rolling pin'],
        searchResult:
            'and see a rolling pin laying on the kitchen counter, "this might come in handy"',
        enemy: false);
    bathroom = Bathroom(
        description: 'bathroom',
        items: ['key'],
        searchResult:
            'and you find a hidden safe behind one of the cabinets\n"its locked you´ll need a 4 digit code to unlock it"',
        enemy: false);
    livingRoom = LivingRoom(
        description: 'living Room',
        items: [],
        searchResult: 'stairs in the corner leading to a shutter',
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
    //þetta function uppfærir ástand leiksins
    try {
      int userInput = int.parse(input);
      bool isNeighbourIndex = userInput - 1 < currentRoom.adjacentRooms.length;
      if (isNeighbourIndex) {
        //change to neighbour
        changeCurrentRoomByIndex(userInput);
        //if not to neighbour then to action
      } else {
        currentRoom
            .performAction(userInput - 1 - currentRoom.adjacentRooms.length);
      }
    }catch (e){
      Room.invalidInput();
      return;
    }
  }

  void renderGame() {
    //Leikurinn byrjar í storage=currentroom
    currentRoom.roomDescription();
  }

  void iniateGame() {
    //byrja leikinn/kynning
    print('Welcome to G.T.H.O');
    print('Please enter your name to start the game');
    try {
      String input = stdin.readLineSync(encoding: Encoding.getByName('utf-8'));
      print(
          'Hello $input its seems you have just woken up disoriented in an unknown house, your phone and wallet\n'
              'are missing, all you carry is a old torn backpack, you think to yourself\n'
              '"I have to get the hell out of here, this place looks creepy as hell I should look around and see if I find something useful,\n you grab the backpack\n'
              'and get on your feet and start looking around');
    }catch (e){
      Room.invalidInput();
      return;
    }
  }

  void changeCurrentRoomByIndex(int userInput) {
    //uppfæra currentRoom
    currentRoom = currentRoom.adjacentRooms[userInput - 1];
  }
}

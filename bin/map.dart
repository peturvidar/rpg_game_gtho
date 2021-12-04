import 'rpg_package.dart';

class Map {
  Room storage;
  Room hallway;
  Room bedroom;
  Room currentRoom;
  Map() {
    // Room storageWithoutItems = Storage(descriptionWithoutItems: '[1] Enter hallway');
    //  Room storageWithItems = Storage(description: '[1] Enter hallway \n[2] Search room');
    //  Room hallwayWithItems = Hallway(description: '[1] Search hallway\n[2] Enter bedroom\n[3] Enter kitchen\n[4] Enter living room\n[5] Exit through main door');
    //  Room bedroomWithItems = Bedroom(description: '[1] Search room \n[2] Enter the balcony\n[3] exit back to hallway');
    // storageW = storageWithoutItems;
    //  storage = Storage(description: '[1] Enter hallway \n[2] Search room');
    //  hallway = Hallway(description: '[1] Search hallway\n[2] Enter bedroom\n[3] Enter kitchen\n[4] Enter living room\n[5] Exit through main door');
    //  bedroom = Bedroom(description: '[1] Search room \n[2] Enter the balcony\n[3] exit back to hallway');
    storage = Storage(description: 'Storage');
    hallway = Hallway(description: 'Hallway');
    // bedroom = Bedroom(description: '[1] Search room \n[2] Enter the balcony\n[3] exit back to hallway');

    currentRoom = storage;
    storage.addAdjacentRoom(hallway);
    //hallway.addAdjacentRoom(bedroom);
  }
  Room changeCurrentRoom(Room room) {
  Room currentRoom = room;
  return currentRoom;

  }
}

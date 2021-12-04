// import 'rpg_package.dart';
//
// class RoomsWithOutItems {
//
//   String descriptionWithOutItems;
//   RoomsWithOutItems({this.descriptionWithOutItems});
//   List<Room> adjacentRooms = [];
//   void roomDescriptionWithoutItems(){
//     print(descriptionWithOutItems);
//     int option = 1;
//     for(Room room in Room().adjacentRooms){
//       print('[$option] ${room.name}');
//     }
//   }
// }
//
// class StorageWithoutItems extends RoomsWithOutItems {
//   String descriptionWithoutItems;
//   StorageWithoutItems({this.descriptionWithoutItems}) : super(descriptionWithOutItems: descriptionWithoutItems);
//
//   void optionsStorage(){
//     //RoomsWithOutItems rooms = RoomsWithOutItems();
//     String input = stdin.readLineSync();
//     if(input == '1'){
//       map.hallway.roomDescription();
//     }else if(input == '2'){
//       print('You find a crowbar in the corner\n[1] Pick up the crowbar\n[2] Leave the crowbar');
//       String choice = stdin.readLineSync();
//       if(choice == '1'){
//       }else if(choice == '2'){
//         map.storage.roomDescription();
//       }
//       //map.storage.roomDescriptionWithoutItems();
//     }
//   }
// }
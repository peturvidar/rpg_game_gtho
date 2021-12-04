import 'rpg_package.dart';
class Player {
  String name;
  List<int> health = [100];
 // List<String> inventory = ['1'];
  Player({this.name});


// // List Inventory(List item){
// //  List<String> newItem = item;
// //  if(newItem == newItem){
// //   List<String> newList = newItem + inventory;
// //   return newList;
// //  }
//
// }
  List inventory(List<String> item) {
    List<String> newlist = [];
    List<String> addItem = item;
    newlist.add(addItem.toString());
   // List<String> inventory = ['your inventory is empty'];
    return newlist;
  }
}



import 'dart:core';

import 'rpg_package.dart';
class Player {
  String playerName;
  List<int> health = [100];
  List<String> inventory = [];
  Player({this.playerName,this.health,this.inventory});
  // Player.inventory({this.inventory}){
  //   List<String> playerInventory = ['empty'];
  //
  // }
  List addInventory(String item){
   inventory.add(item);
 }
 }

 class Inventory {
  List<String> inventory = ['1'];

   void addInventory(List<String> item){
     inventory.addAll(item);
   }
 }

 // List checkInventory() {
 //   return
 // }

// // List Inventory(List item){
// //  List<String> newItem = item;
// //  if(newItem == newItem){
// //   List<String> newList = newItem + inventory;
// //   return newList;
// //  }
//
// }
// //  List inventory(List<String> item) {
//     List<String> newlist = [];
//     List<String> addItem = item;
//     newlist.add(addItem.toString());
//    // List<String> inventory = ['your inventory is empty'];
//     return newlist;
//   }
// }




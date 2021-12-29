import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todos_app/Home/ListFragments/ListItem.dart';

class ListProvider extends ChangeNotifier{
  List<Todo>todoList=[];
  CollectionReference todos = FirebaseFirestore.instance.collection('todos');
    void refreshTodos(){
      todos.get()
      .then((QuerySnapshot querySnapshot) {
        todoList= querySnapshot.docs.map((doc) {
          Timestamp timestamp=doc["dateTime"] as Timestamp;
          return Todo(id: doc.id,title: doc["title"],content: doc["content"],date: timestamp.toDate(),isDone:doc["isDone"] );
           }).toList();
        notifyListeners();
       });
    }
    // void updateData(List<Todo>newList){
    //   todoList=newList;
    //   notifyListeners();
    // }
    //

  void onDeleteButtonClick(Todo item){
    todos
        .doc(item.id)
        .delete()
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
    refreshTodos();
    notifyListeners();
  }
  void onCheckButtonClick(Todo item){
    todos
        .doc(item.id)
        .update({'isDone': item.isDone?false:true})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
    refreshTodos();
    notifyListeners();
  }

}
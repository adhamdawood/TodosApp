import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todos_app/Home/ListFragments/ListItem.dart';
import 'package:todos_app/Home/Providers/ListProvider.dart';

class TodosList extends StatefulWidget {
  DateTime selectedDay;
  TodosList({this.selectedDay});
  @override
  _TodosListState createState() => _TodosListState();
}

class _TodosListState extends State<TodosList> {
  List<Todo> todoList=[];

  ListProvider listProvider;
  CollectionReference todos;

    @override
    void initState() {
      // TODO: implement initState
      super.initState();
      todos = FirebaseFirestore.instance.collection('todos');
      //listProvider.refreshTodos();

      getTodosFromFireBase();
    }

  @override
  Widget build(BuildContext context) {
    listProvider =Provider.of<ListProvider>(context);
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [
              Expanded(
                child: ListView.builder(
                    itemBuilder: (context,index){
                  return ListItem(listProvider.todoList[index]);
                },
                  itemCount: listProvider.todoList.length,
                ),
              ),
            ],
          ),
    );
  }

  Future <void> getTodosFromFireBase (){
    todos.get()
        .then((QuerySnapshot querySnapshot) {
    setState(() {
      todoList= querySnapshot.docs.map((doc) {
        Timestamp timestamp=doc["dateTime"] as Timestamp;
        return Todo(id : doc.id,title: doc["title"],content: doc["content"],date: timestamp.toDate(),isDone:doc["isDone"] );
      }).toList();
      todoList=todoList.where((element) => element.date.day==widget.selectedDay.day).toList();
      todoList.sort((a,b){
        return a.date.compareTo(b.date);
      });
    });
    listProvider.updateData(todoList);
      });

  }

}


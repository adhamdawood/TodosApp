import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todos_app/main.dart';
import 'Providers/ListProvider.dart';
import 'Providers/ThemeProvider.dart';



class BottomSheetFragment extends StatefulWidget {

  @override
  _BottomSheetFragmentState createState() => _BottomSheetFragmentState();
}

class _BottomSheetFragmentState extends State<BottomSheetFragment> {
  String title="";
  String content="";
  DateTime dateTime=DateTime.now();
  CollectionReference todos;
  ListProvider listProvider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todos = FirebaseFirestore.instance.collection('todos');
  }
  @override
  Widget build(BuildContext context) {
    listProvider =Provider.of<ListProvider>(context);
    final themeProvider= Provider.of<ThemeProvider>(context);
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("add new task",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,
              color: themeProvider.theme=="Light"?Colors.black:Colors.white),),
          TextFormField(
            onChanged: (newTitle){
              title=newTitle;
            },
            decoration: InputDecoration(
              hintText: "Title",
             // labelText: "Title",
              hintStyle: TextStyle(color: themeProvider.theme=="Light"?Colors.black:Colors.white,
                  fontWeight: FontWeight.bold,fontSize: 20),
            ),
          ),
          TextFormField(
            onChanged: (newContent){
              content=newContent;
            },
            maxLines: 4,
            decoration: InputDecoration(
              //labelText: "Content",
              hintText: "Content",
              hintStyle: TextStyle(color: themeProvider.theme=="Light"?Colors.black:Colors.white,
                  fontWeight: FontWeight.bold,fontSize: 20),
            ),
          ),
          InkWell(
            onTap: timeModalDatePicker,
              child: Text("Select Time",style: TextStyle(color: themeProvider.theme=="Light"?Colors.black:Colors.white,
                  fontWeight: FontWeight.bold,fontSize: 20),)),
          ElevatedButton(
            onPressed: addTodos,
              child: Text("Add todo"),
            style: ButtonStyle(
            ),
          )
        ],
      ),
    );
  }
      void timeModalDatePicker() async {
      dateTime = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));

  }

    void addTodos() {
    // Call the user's CollectionReference to add a new user
      todos.add({
         'title' : title,
          'content': content,
           'dateTime' : dateTime,
              'isDone':false,
    })
        .then((value) => print("todo Added"))
        .catchError((error) => print("Failed to add todo: $error"))
    .timeout(Duration(seconds: 2),onTimeout: (){
      listProvider.refreshTodos();
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg: "Todo added successfully",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: MyThemeData.primaryColor,
          textColor: Colors.white,
          fontSize: 16.0
      );

    });
  }

}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todos_app/Home/ListFragments/ListItem.dart';
import 'package:todos_app/Home/Providers/ListProvider.dart';
import 'package:todos_app/Home/Providers/ThemeProvider.dart';


import '../../main.dart';

class DetailsOfItem extends StatefulWidget {
  static final ROUTE_NAME = "Details";

  @override
  _DetailsOfItemState createState() => _DetailsOfItemState();
}

class _DetailsOfItemState extends State<DetailsOfItem> {
  String title;
  String content;
  DateTime dateTime=DateTime.now();
  CollectionReference todos = FirebaseFirestore.instance.collection('todos');
   Todo args;
   ListProvider listProvider;
  @override
  Widget build(BuildContext context) {
     args = ModalRoute.of(context).settings.arguments as Todo;
      listProvider =Provider.of<ListProvider>(context);
     final themeProvider= Provider.of<ThemeProvider>(context);
    return Material(
      child: Stack(
              children: [
            Scaffold(
              backgroundColor: Theme.of(context).accentColor,
              appBar: AppBar(
                title: Text(AppLocalizations.of(context).todosList),
                toolbarHeight: 150,
              ),
            ),
               Center(
                 child: Container(
                  margin: EdgeInsets.only(top: 90),
                  width: 300,
                  height: 500,
                  decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor, borderRadius: BorderRadius.circular(8)),
                   child: Container(
                     padding: EdgeInsets.all(8),
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Center(child: Text("Edit Task",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,
                             color: themeProvider.theme=="Light"?Colors.black:Colors.white),)),
                         TextField(
                           onChanged: (newTitle){
                           title=newTitle;
                           },
                           decoration: InputDecoration(
                             hintText: args.title,
                             hintStyle: TextStyle(color: themeProvider.theme=="Light"?Colors.black:Colors.white
                                 ,fontWeight: FontWeight.bold,fontSize: 20),
                           ),
                         ),
                         TextField(
                           onChanged: (newContent){
                         content=newContent;
                           },
                           maxLines: 4,
                           decoration: InputDecoration(
                             hintText: args.content,
                             hintStyle: TextStyle(color: themeProvider.theme=="Light"?Colors.black:Colors.white
                                 ,fontWeight: FontWeight.bold,fontSize: 20),
                           ),
                         ),
                         InkWell(
                              onTap: timeModalDatePicker,
                             child: Text("Select Time",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,
                                 color: themeProvider.theme=="Light"?Colors.black:Colors.white),)),

                         Center(child: Text(args.date.toString(),style: TextStyle(color: themeProvider.theme=="Light"?Colors.black:Colors.white),)),
                         Center(
                           child: TextButton(
                               onPressed:(){
                                 setState(() {
                                   onSaveChanges();
                                   Navigator.pop(context);
                                   Fluttertoast.showToast(
                                       msg: "Changes Saved ",
                                       toastLength: Toast.LENGTH_LONG,
                                       gravity: ToastGravity.CENTER,
                                       timeInSecForIosWeb: 1,
                                       backgroundColor: MyThemeData.primaryColor,
                                       textColor: Colors.white,
                                       fontSize: 16.0
                                   );
                                 });
                               },
                               child: Text("Save Changes")),
                         )
                       ],
                     ),
                   ),
                 ),
              ),
          ]
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

  void onSaveChanges(){
    todos.doc(args.id)
        .update({'title': title!=null && title!=args.title?title:args.title,
      'content' :content!=null &&content!=args.content ?content:args.content,
      'dateTime':dateTime,
    })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
    listProvider.refreshTodos();
  }
}


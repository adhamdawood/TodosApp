import 'package:flutter/material.dart';
import 'package:todos_app/Home/BottomSheetFragment.dart';
import 'package:todos_app/Home/ListFragments/TodosList.dart';
import 'package:todos_app/Home/SettingsFragments/SettingsScreen.dart';
import 'package:todos_app/main.dart';

class HomeScreen extends StatefulWidget {
  static final ROUTE_NAME="Home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyThemeData.accentColor,
      appBar: AppBar(
        title: Text("Todos List"),
        toolbarHeight: 150,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: showBottomSheet,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.hardEdge,
        notchMargin: 10,
        shape: CircularNotchedRectangle(),
        child: BottomNavigationBar(
          onTap: (selectedIndex){
            setState(() {
              this.selectedIndex=selectedIndex;
            });
          },
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
                label: "List",
                icon: Icon(Icons.list)),
            BottomNavigationBarItem(
                label: "Settings",
                icon: Icon(Icons.settings)),
          ],
        ),
      ),
      body: selectedIndex==0?TodosList():SettingsScreen(),
    );
  }
  void showBottomSheet(){
     showModalBottomSheet(context:  context, builder: (context){
      return  BottomSheetFragment();
    });
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todos_app/Home/BottomSheetFragment.dart';
import 'package:todos_app/Home/ListFragments/TodosList.dart';
import 'package:todos_app/Home/Providers/ListProvider.dart';
import 'package:todos_app/Home/SettingsFragments/SettingsScreen.dart';
import 'package:todos_app/main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  static final ROUTE_NAME="Home";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex=0;
  DateTime selectedDay=DateTime.now();
  DateTime focusedDay=DateTime.now();
  @override
  Widget build(BuildContext context) {
    final listProvider =Provider.of<ListProvider>(context);
    return  Material(
      child: Stack(
        children:[
          Scaffold(
             backgroundColor: Theme.of(context).accentColor,
             appBar: AppBar(
               title: Text(AppLocalizations.of(context).todosList),
               toolbarHeight: 160,
             ),
             floatingActionButton: FloatingActionButton(
                 backgroundColor: MyThemeData.primaryColor,
                 child: Icon(Icons.add),

                 onPressed: showBottomSheet
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
             body: selectedIndex==0?TodosList(selectedDay: selectedDay,):SettingsScreen(),
           ),
          selectedIndex==0?Container(
            margin: EdgeInsets.only(top: 140),
            child: TableCalendar(
              firstDay: DateTime.now().subtract(Duration(days: 365)),
              lastDay: DateTime.now().add(Duration(days: 365)),
              focusedDay:focusedDay,
              headerVisible: false,
              calendarFormat:CalendarFormat.week,
              weekendDays: [],
              selectedDayPredicate: (day) {
                return isSameDay(selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  this.selectedDay = selectedDay;
                  this.focusedDay = focusedDay;
                  // update `_focusedDay` here as well
                });
                listProvider.selectedDay=selectedDay;
                listProvider.refreshTodos();
              },
              currentDay: selectedDay,
              calendarStyle: CalendarStyle(
                  defaultDecoration: BoxDecoration(
                      color: Theme.of(context).canvasColor
                  ),
                  defaultTextStyle: TextStyle(color: Theme.of(context).primaryColor),
                  weekendTextStyle: TextStyle(color: Theme.of(context).primaryColor),
              ),
              startingDayOfWeek: StartingDayOfWeek.saturday,

            ),
          ):Container(),
   ] ),
    );
    }
  void showBottomSheet(){
    showModalBottomSheet(
        context:  context, builder: (context){
      return  BottomSheetFragment();
    });
  }
  }


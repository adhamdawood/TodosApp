import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todos_app/main.dart';

class ThemeProvider extends ChangeNotifier{
  String theme;
  Future <void> changeTheme(String newValue) async {
    // prefs = await SharedPreferences.getInstance();
    if (newValue=="Light") {
      theme = "Light";
    //  prefs.setBool("isLight", true);
    } else {
      theme ="Dark";
      //prefs.setBool("isLight", false);
    }
    notifyListeners();
  }
}
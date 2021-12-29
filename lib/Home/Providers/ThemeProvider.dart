import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{
  String theme="Light";
  changeTheme(String newValue){
    theme=newValue=="Light"?"Light":"Dark";
    notifyListeners();
  }
}
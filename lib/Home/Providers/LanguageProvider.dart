

import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier{
  String language="en";
  changeLanguage(String newValue){
    language=newValue=="English"?"en":"ar";
    notifyListeners();
  }
}
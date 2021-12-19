import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todos_app/Home/HomeScreen.dart';


void main() {
  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}
 class MyThemeData{
  static final primaryColor=Color(0xff5D9CEC);
  static final accentColor=Color(0xffDFECDB);
  static final greenColor=Color(0xff61E757);
 }
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        HomeScreen.ROUTE_NAME: (context) => HomeScreen(),
      },
      initialRoute: HomeScreen.ROUTE_NAME,
    );

    }
}

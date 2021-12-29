import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todos_app/Home/HomeScreen.dart';
import 'package:todos_app/Home/ListFragments/DetailsOfItem.dart';
import 'package:todos_app/Home/Providers/ListProvider.dart';
import 'package:todos_app/Home/Providers/ThemeProvider.dart';
import 'Home/Providers/LanguageProvider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    FirebaseFirestore.instance.settings =
        Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
    await FirebaseFirestore.instance.disableNetwork();
  runApp(MyApp());
}
 class MyThemeData{
  static final primaryColor=Color(0xff5D9CEC);
  static final accentColor=Color(0xffDFECDB);
  static final greenColor=Color(0xff61E757);
  static final darkAccentColor=Color(0xff060E1E);
  static final darkCanvasColor=Color(0xff141922);

 }
class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=>ListProvider(),
      builder: (context,widget){

        return ChangeNotifierProvider<ThemeProvider>(
            create: (context)=>ThemeProvider(),
            builder: (context,widget){
              final themeProvider= Provider.of<ThemeProvider>(context);
              return ChangeNotifierProvider<LanguageProvider>(
                  create: (context)=>LanguageProvider(),
                  builder: (context,widget){
                    final provider = Provider.of<LanguageProvider>(context);
                    return  MaterialApp(
                      theme: ThemeData(
                        primaryColor: MyThemeData.primaryColor,
                        accentColor: MyThemeData.accentColor,
                        canvasColor: Colors.white,
                      ),
                      darkTheme: ThemeData(
                          primaryColor: MyThemeData.primaryColor,
                          accentColor: MyThemeData.darkAccentColor,
                          canvasColor: MyThemeData.darkCanvasColor
                      ),
                      themeMode: themeProvider.theme=="Light"?ThemeMode.light:ThemeMode.dark,
                      localizationsDelegates: [
                        AppLocalizations.delegate,
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate,
                      ],
                      supportedLocales: [
                        Locale('en', ''), // English, no country code
                        Locale('ar', ''), // Spanish, no country code
                      ],
                      locale: Locale(provider.language,''),
                      routes: {
                        HomeScreen.ROUTE_NAME: (context) => HomeScreen(),
                        DetailsOfItem.ROUTE_NAME:(context)=>DetailsOfItem(),
                      },
                      initialRoute: HomeScreen.ROUTE_NAME,
                    );
                  }
              );
            }
        );
      },
    );

    }
}

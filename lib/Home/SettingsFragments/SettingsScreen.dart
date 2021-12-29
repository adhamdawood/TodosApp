import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos_app/Home/Providers/LanguageProvider.dart';
import 'package:todos_app/Home/Providers/ThemeProvider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LanguageProvider>(context);
    final themeProvider= Provider.of<ThemeProvider>(context);
    String dropdownValue =provider.language=="en"?"English":"Arabic";
    String dropDownThemeValue=themeProvider.theme=="Light"?"Light":"Dark";

    return  Container(
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppLocalizations.of(context).language,style: TextStyle(color: themeProvider.theme=="Light"?Colors.black:Colors.white,fontWeight: FontWeight.bold,fontSize: 14),),
              Container(
                height: 45,
                width: 319,
                decoration: BoxDecoration(
                    border: Border.all(color:Color(0xff5D9CEC)),
                  color: Theme.of(context).canvasColor,
                ),
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(15),
                child: DropdownButton<String>(
                  value: dropdownValue,
                  icon: const  Icon(Icons.arrow_downward,color: Color(0xff5D9CEC) ,),
                  elevation: 16,
                  isExpanded: true,
                  style: const TextStyle(color: Color(0xff5D9CEC)),
                  underline: Container(
                    height: 0,
                    color: Colors.transparent,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                      provider.changeLanguage(newValue);

                    });
                  },
                  items: <String>['English', 'Arabic']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value))
                    ;
                  }).toList(),
                ),
              ),

              SizedBox(height: 20,),

              Text(AppLocalizations.of(context).mode,style: TextStyle(color: themeProvider.theme=="Light"?Colors.black:Colors.white,fontWeight: FontWeight.bold,fontSize: 14)),
              Container(
                height: 45,
                width: 319,
                decoration: BoxDecoration(
                  border: Border.all(color:Color(0xff5D9CEC)),
                  color: Theme.of(context).canvasColor,
                ),
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(15),
                child: DropdownButton<String>(
                  value: dropDownThemeValue,
                  icon: const  Icon(Icons.arrow_downward,color: Color(0xff5D9CEC)),
                  elevation: 16,
                  isExpanded: true,
                  style: const TextStyle(color: Color(0xff5D9CEC)),
                  underline: Container(
                    height: 0,
                    color: Colors.transparent,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      dropDownThemeValue = newValue;
                      themeProvider.changeTheme(newValue);

                    });
                  },
                  items: <String>['Light', 'Dark']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value))
                    ;
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      }
  }


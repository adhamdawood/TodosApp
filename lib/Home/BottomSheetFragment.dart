import 'package:flutter/material.dart';

class BottomSheetFragment extends StatefulWidget {

  @override
  _BottomSheetFragmentState createState() => _BottomSheetFragmentState();
}

class _BottomSheetFragmentState extends State<BottomSheetFragment> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("add new task",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
          TextField(
            decoration: InputDecoration(
              hintText: "Title",
              hintStyle: TextStyle(color: Color(0xffA9A9A9),fontWeight: FontWeight.bold,fontSize: 20),
            ),
          ),
          TextField(
            decoration: InputDecoration(
              hintText: "Content",
              hintStyle: TextStyle(color: Color(0xffA9A9A9),fontWeight: FontWeight.bold,fontSize: 20),
            ),
          ),
          InkWell(
            onTap: timeModalDatePicker,
              child: Text("Select Time",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
        ],
      ),
    );
  }

  void timeModalDatePicker(){
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));

  }
}

import 'package:flutter/material.dart';
import 'package:todos_app/Home/ListFragments/ListItem.dart';

class TodosList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child:
        Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context,index){
                return ListItem(Todo(title: "VolleyBall",content: "content",date: DateTime.now(),isDone: false));
              }
              ),
            ),
          ],
        )
    );
  }
}


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todos_app/main.dart';

class ListItem extends StatefulWidget {
  Todo todo;
  ListItem(this.todo);
  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  bool isDone=true;
  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
          extentRatio: 0.3,
          children: [
        Container(
          height: 115,
          width: 100,
          child: SlidableAction(
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ),]
      ) ,
      child: widget.todo.isDone==false?Container(
        height: 115,
        width: 352,
        margin: EdgeInsets.only(top: 10,right: 10,bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(height: 62,width: 4,decoration: BoxDecoration(color: MyThemeData.primaryColor),),
            Container(width: 180,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.todo.title,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,
                    color: MyThemeData.primaryColor
                  ),),
                  Text(widget.todo.date.toString()),
                ],
              ),
            ),
            Container(
              width: 69,
              height: 34,
              decoration: BoxDecoration(color: MyThemeData.primaryColor,
              borderRadius: BorderRadius.circular(8)),
              child: Icon(Icons.check,color: Colors.white,size: 35,),
            )
          ],
        ),
      ) :
      Container(
        height: 115,
        width: 352,
        margin : EdgeInsets.only(top: 10,right: 10,bottom: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(height: 62,width: 4,decoration: BoxDecoration(color: MyThemeData.greenColor),),
            Container(width: 180,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.todo.title,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,
                      color: MyThemeData.greenColor
                  ),),
                  Text(widget.todo.date.toString()),
                ],
              ),
            ),
            Container(
              width: 69,
              height: 34,
              child: Text("Done!",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,
              color: MyThemeData.greenColor),),
            )
          ],
        ),
      ),
    );

  }

}
  class  Todo{
  String title;
  String content;
  DateTime date;
  bool isDone;
  Todo({this.title,this.content,this.date,this.isDone});
}

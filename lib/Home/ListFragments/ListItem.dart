import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todos_app/Home/ListFragments/DetailsOfItem.dart';
import 'package:todos_app/Home/Providers/ListProvider.dart';
import 'package:todos_app/Home/Providers/ThemeProvider.dart';
import 'package:todos_app/main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ListItem extends StatefulWidget {
  Todo todo;
  ListItem(this.todo);
  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    final themeProvider= Provider.of<ThemeProvider>(context);
    final listProvider =Provider.of<ListProvider>(context);
    return Container(
      height: 115,
      width: 352,
      margin: EdgeInsets.all(10),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
            extentRatio: 0.3,
            children: [
           SlidableAction(
             onPressed: (context){
               listProvider.onDeleteButtonClick(widget.todo);
             },
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ]
        ) ,
        child:InkWell(
          onTap: (){
            Navigator.of(context).pushNamed(DetailsOfItem.ROUTE_NAME,
            arguments: widget.todo);
          },
          child: Container(
            //padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).canvasColor
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(height: 62,width: 4,decoration: BoxDecoration(
                    color: widget.todo.isDone?MyThemeData.greenColor:MyThemeData.primaryColor),),
                Container(width: 180,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${widget.todo.title}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,
                        color:widget.todo.isDone?MyThemeData.greenColor:MyThemeData.primaryColor
                      ),),

                      SizedBox(height: 8,),
                      Text(widget.todo.date.toString(),style: TextStyle(color: themeProvider.theme=="Light"?Colors.black:Colors.white),),
                    ],
                  ),
                ),
                InkWell(
                  onTap: (){
                    setState(() {
                    listProvider.onCheckButtonClick(widget.todo);
                    });
                  },
                  child: widget.todo.isDone?
                  Container(
                    width: 69,
                    height: 34,
                    child: Text(AppLocalizations.of(context).done,style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,
                        color: MyThemeData.greenColor),),
                  )
                    :Container(
                    width: 69,
                    height: 34,
                    decoration: BoxDecoration(color: MyThemeData.primaryColor,
                    borderRadius: BorderRadius.circular(8)),
                    child: Icon(Icons.check,color: Colors.white,size: 35,),
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}
  class  Todo{
  String id;
  String title;
  String content;
  DateTime date;
  bool isDone;
  Todo({this.id,this.title,this.content,this.date,this.isDone});
}

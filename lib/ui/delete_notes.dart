import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:personal_notes/database/services.dart';
import 'package:personal_notes/ui/home_page_screen.dart';
import 'package:personal_notes/uihelper/text_style.dart';

class DeleteNotesScreen extends StatefulWidget {
  int id;
  String title;
  String body;


  DeleteNotesScreen(
      {Key? key, required this.id, required this.title, required this.body})
      : super(key: key);

  @override
  State<DeleteNotesScreen> createState() => _DeleteNotesScreenState();
}

class _DeleteNotesScreenState extends State<DeleteNotesScreen> {
  ServicesFile servicesFile = ServicesFile();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delete Notes"),
      ),
      body: Card(
          color: Color(
              (math.Random().nextDouble() * 0xFFFFFF)
                  .toInt())
              .withOpacity(1.0),
          child: ListTile(
            trailing: IconButton(onPressed: (){
              servicesFile.delete(widget.id);
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (context) => HomePageScreen(),), (
                      route) => false);
            },icon: Icon(Icons.delete),color: Colors.white,),

            title: Text(widget.title.toString(), style: titleText()),
            subtitle: Text(widget.body.toString(), style: bodyText()),
          )),
    );
  }
}

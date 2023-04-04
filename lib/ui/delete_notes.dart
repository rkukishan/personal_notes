import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:personal_notes/database/services.dart';
import 'package:personal_notes/model/notes_delete_modal.dart';
import 'package:personal_notes/ui/home_page_screen.dart';
import 'package:personal_notes/uihelper/text_style.dart';

class DeleteNotesScreen extends StatefulWidget {
  const DeleteNotesScreen({Key? key}) : super(key: key);

  @override
  State<DeleteNotesScreen> createState() => _DeleteNotesScreenState();
}

class _DeleteNotesScreenState extends State<DeleteNotesScreen> {
  ServicesFile servicesFile = ServicesFile();

  @override
  Widget build(BuildContext context) {
    NotesDeleteModal? settings =
        ModalRoute.of(context)!.settings.arguments as NotesDeleteModal;
    return Scaffold(
      appBar: AppBar(
        title: Text("Delete Notes"),
      ),
      body: Card(
          color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
              .withOpacity(1.0),
          child: ListTile(
            trailing: IconButton(
              onPressed: () {
                servicesFile.delete(settings.id!);

                /*Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (context) => HomePageScreen(),), (
                      route) => false);*/

                Navigator.pushNamedAndRemoveUntil(
                    context, "homepagescreen", (route) => false);
              },
              icon: Icon(Icons.delete),
              color: Colors.white,
            ),
            title: Text(settings.title.toString(), style: titleText()),
            subtitle: Text(settings.body.toString(), style: bodyText()),
          )),
    );
  }
}

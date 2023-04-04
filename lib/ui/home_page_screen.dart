import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import 'package:personal_notes/database/db_helper.dart';
import 'package:personal_notes/database/services.dart';
import 'package:personal_notes/model/notes_delete_modal.dart';
import 'package:personal_notes/ui/about_app_screen.dart';
import 'package:personal_notes/ui/add_notes_screen.dart';
import 'package:personal_notes/ui/delete_notes.dart';
import 'dart:math' as math;

import '../uihelper/text_style.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  DBHelper? dbHelper;
  ServicesFile? servicesFile;
  NotesDeleteModal? notesDeleteModal;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = DBHelper();
    servicesFile = ServicesFile();
    servicesFile!.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
        actions: [
          IconButton(
              onPressed: () {
                MyDialog mydig = MyDialog();
                mydig.show(context);
              },
              icon: Icon(Icons.info)),
          IconButton(
              onPressed: () {
                Share.share(
                    "hey! check out this new app https://play.google.com/store/apps/details?id=com.kishanpatel.personal_notes");
              },
              icon: Icon(Icons.share))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
                child: FutureBuilder(
              future: servicesFile!.notesList,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  case ConnectionState.done:
                    {
                      if (snapshot.data == null) {
                        return const Center(
                          child: Text("First Create Your Notes!!!"),
                        );
                      } else {
                        return ListView.separated(
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 5,);
                          },
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Slidable(
                              direction: Axis.horizontal,
                              key: Key("$index"),
                              startActionPane:
                                  ActionPane(motion: const ScrollMotion(), children: [
                                    SlidableAction(
                                  onPressed: (context) {},
                                  autoClose: true,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(08)),
                                  icon: Icons.update_rounded,
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.blue,
                                  label: "Update",
                                ),
                                SizedBox(width: 5,),
                              ]),
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SizedBox(width: 5,),
                                  SlidableAction(
                                    onPressed: (context) {},
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(08)),
                                    icon: Icons.delete,
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.red,
                                    label: "Delete",
                                  ),
                                  SizedBox(
                                    width: 05,
                                  ),
                                  SlidableAction(
                                    onPressed: (context) {
                                      Share.share(
                                          "Title: ${snapshot.data![index].title.toString()} \nMessage: ${snapshot.data![index].body.toString()} ");
                                    },
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(08)),
                                    icon: Icons.share,
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.blue,
                                    label: "Share",
                                  ),
                                ],
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.75),
                                  borderRadius:const BorderRadius.all(Radius.circular(5))
                                ),
                              /*  color: Color(
                                        (math.Random().nextDouble() * 0xFFFFFF)
                                            .toInt())
                                    .withOpacity(0.70),*/
                                child: ListTile(
                                  onTap: () {
                                    int id = snapshot.data![index].id!.toInt();

                                    String title =
                                        snapshot.data![index].title.toString();

                                    String body =
                                        snapshot.data![index].body.toString();

                                    notesDeleteModal =
                                        NotesDeleteModal(id, title, body);
                                    Navigator.pushNamed(
                                        context, "deletenotesscreen",
                                        arguments: notesDeleteModal);

                                    setState(() {});
                                  },
                                  title: Text(
                                    snapshot.data![index].title,
                                    style: titleText(),
                                  ),
                                  subtitle: Text(
                                    snapshot.data![index].body,
                                    style: bodyText(),
                                  ),
                                  trailing: Text(
                                    snapshot.data![index].datetime.toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    }
                  case ConnectionState.none:
                    // TODO: Handle this case.
                    break;
                  case ConnectionState.active:
                    // TODO: Handle this case.
                    break;
                }
                return const Center(child: CircularProgressIndicator());
              },
            )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "addnotesscreen");
        },
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.add),
      ),
    );
  }
}

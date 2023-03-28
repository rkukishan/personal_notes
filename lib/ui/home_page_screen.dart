import 'package:flutter/material.dart';
import 'package:personal_notes/database/db_helper.dart';
import 'package:personal_notes/database/services.dart';
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
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Card(
                              color: Color(
                                      (math.Random().nextDouble() * 0xFFFFFF)
                                          .toInt())
                                  .withOpacity(1.0),
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => DeleteNotesScreen(
                                    id: snapshot.data![index].id!.toInt(),
                                      title: snapshot.data![index].title
                                          .toString(),
                                      body: snapshot.data![index].title
                                          .toString()),));
                                  // servicesFile!.delete(snapshot.data![index].id!.toInt());
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
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddNotes()));
        },
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.add),
      ),
    );
  }
}

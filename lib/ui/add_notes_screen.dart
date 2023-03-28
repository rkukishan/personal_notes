import 'package:flutter/material.dart';
import 'package:personal_notes/database/db_helper.dart';
import 'package:personal_notes/database/services.dart';
import 'package:personal_notes/model/notes_model.dart';
import 'package:personal_notes/ui/home_page_screen.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({Key? key}) : super(key: key);

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  DBHelper? dbHelper;
  ServicesFile? servicesFile;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = DBHelper();
    servicesFile = ServicesFile();
  }

  addNotes() async {
    dbHelper!
        .insertNotes(NotesModel(
            title: titleController.text.toString(),
            body: bodyController.text.toString()))
        .then((value) => print("insert"));

    servicesFile!.loadData();
    // Navigator.push(context, MaterialPageRoute(builder: (context) => HomePageScreen(),));
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePageScreen(),), (route) => false);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    var sizeHeight = MediaQuery.of(context).size.height;
    var sizeWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.text,
              textDirection: TextDirection.ltr,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              controller: titleController,
              decoration: const InputDecoration(
                  hintText: "Title",
                  hintStyle:
                      TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  border: InputBorder.none),
            ),
            SizedBox(
              height: sizeHeight * 0.01,
            ),
            TextField(
              maxLines: null,
              keyboardType: TextInputType.text,
              textDirection: TextDirection.ltr,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
              controller: bodyController,
              decoration: const InputDecoration(
                  hintText: "Message",
                  hintStyle:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  border: InputBorder.none),
            ),
            SizedBox(
              height: sizeHeight * 0.01,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await addNotes();
          setState(() {

          });
        },
        label: Text("Add Notes"),
        icon: Icon(Icons.add),
      ),
    );
  }
}

import 'dart:io';

import 'package:personal_notes/model/notes_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DBHelper {
  static const String id = 'id';
  static const String title = 'title';
  static const String body = 'body';
  static const String table_name = 'notes';
  static const String datetime = "datetime";
  static const String db_name = 'personal_notes.db';
  static const int db_version = 1;

  static Database? _db;

  Future<Database?> get database async{
    if(_db != null){
      return _db;
    }
    return _db = await initDB();
  }

 Future<Database> initDB()async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, db_name);
    return await openDatabase(path,version: db_version,onCreate: _onCreate);
  }

  _onCreate(Database db, int version)async{
      await db.execute('''
      CREATE TABLE $table_name (
        $id INTEGER PRIMARY KEY AUTOINCREMENT,
        $title TEXT NOT NULL,
        $body TEXT NOT NULL,
        $datetime DATETIME
      )
      ''');
  }

  Future<NotesModel> insertNotes(NotesModel notesModel) async{
    var dbClient = await database;
    await dbClient!.insert(table_name, notesModel.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
    return notesModel;
  }

  Future<List<NotesModel>> getNotes()async{
    var dbClient = await database;
    List<Map<String, dynamic>> result = await dbClient!.query(table_name);
    return result.map((e) {
      return NotesModel.fromMap(e);
    }).toList();
  }


  Future<int> deleteNotes(int id) async{
    var dbClient = await database;
    return await dbClient!.delete(table_name,where: "id = ?",whereArgs: [id]);
  }

}
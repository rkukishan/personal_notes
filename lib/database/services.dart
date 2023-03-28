import 'package:personal_notes/model/notes_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';

import 'db_helper.dart';

class ServicesFile{

  DBHelper? dbHelper = DBHelper();

  late Future<List<NotesModel>> notesList;

  loadData()  {
    notesList = dbHelper!.getNotes();
  }

  delete(int id){
    dbHelper!.deleteNotes(id);
    loadData();
  }

}
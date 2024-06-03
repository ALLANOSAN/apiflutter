import 'package:flutter/material.dart';
import 'package:getxtutorial6sqlitetodo/app/data/model/note_model.dart';
import 'package:getxtutorial6sqlitetodo/app/data/provider/note_provider.dart';
import 'package:sqflite/sqflite.dart';

class NoteRepository extends ChangeNotifier {
  late Database db;
  List<Note> _tarefas[];
}

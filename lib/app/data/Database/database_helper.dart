import 'package:getxtutorial6sqlitetodo/JsonModels/user.dart';
import 'package:getxtutorial6sqlitetodo/app/data/model/note_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database? _db;

  DatabaseHelper._instance();

  String notesTable = 'note_table';
  int colId = 'id' as int;
  String colTitle = 'title';
  String colContent = 'content';
  String colStartDate = 'startDate';
  String colStartTime = 'startTime';
  String colEndDate = 'endDate';
  String colEndTime = 'endTime';

  String usuariosTable = 'user_table';
  String colUsername = 'Usuario';
  String colPassword = 'Senha';

  Future<Database> get db async {
    if (_db == null) {
      _db = await _initDb();
    }
    return _db!;
  }

  Future<Database> _initDb() async {
    String path = join(await getDatabasesPath(), 'notes.db');
    final notesDb = await openDatabase(path, version: 1, onCreate: _createDb);
    return notesDb;
  }

  void _createDb(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $notesTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, $colContent TEXT, $colStartDate TEXT, $colStartTime TEXT, $colEndDate TEXT, $colEndTime TEXT)',
    );
    await db.execute(
      'CREATE TABLE $usuariosTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colUsername TEXT, $colPassword TEXT)',
    );
  }

  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database db = await this.db;
    final List<Map<String, dynamic>> result = await db.query(notesTable);
    return result;
  }

  Future<List<Note>> getNoteList() async {
    final List<Map<String, dynamic>> noteMapList = await getNoteMapList();
    final List<Note> noteList = [];
    noteMapList.forEach((noteMap) {
      noteList.add(Note.fromJson(noteMap));
    });
    return noteList;
  }

  Future<int> insert(Note note) async {
    Database db = await this.db;
    final int result = await db.insert(notesTable, note.toJson());
    return result;
  }

  Future<int> update(Note note) async {
    Database db = await this.db;
    final int result = await db.update(
      notesTable,
      note.toJson(),
      where: '$colId = ?',
      whereArgs: [note.id],
    );
    return result;
  }

  Future<int> delete(int id) async {
    Database db = await this.db;
    final int result = await db.delete(
      notesTable,
      where: '$colId = ?',
      whereArgs: [id],
    );
    return result;
  }

  Future<int> saveUser(Usuarios usuario ) async {
    Database db = await this.db;
    final int result = await db.insert(usuariosTable, usuario.toMap());
    return result;
  }

  Future<bool> login(Usuarios usuario) async {
    Database db = await this.db;
    final List<Map<String, dynamic>> result = await db.query(
      usuariosTable,
      where: '$colUsername = ? AND $colPassword = ?',
      whereArgs: [usuario.usrNome, usuario.usrSenha],
    );
    return result.isNotEmpty;
  }
}

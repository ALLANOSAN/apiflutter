import 'package:getxtutorial6sqlitetodo/JsonModels/user.dart';
import 'package:getxtutorial6sqlitetodo/jsonModels/note_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseNotes {
  DatabaseNotes._();
  static final DatabaseNotes instance = DatabaseNotes._();
  static Database? _database;

get database async {
  if (_database != null) return _database; 


  return await _initDatabase();
}


_initDatabase() async {
  return await openDatabase(
    join(await getDatabasesPath(), 'notes.db'),
    version: 1,
    onCreate: _onCreate,
  );
}

_onCreate(db, versao) async {
  await db.execute(notesTable);
  await db.execute(usuariosTable);
} 

String get notesTable => '''
  CREATE TABLE tabeladenotas (
    $colId INTEGER PRIMARY KEY AUTOINCREMENT,
    $colTitle TEXT,
    $colContent TEXT,
  );
''';

String get usuariosTable => '''
  CREATE TABLE tabelausuarios (
    $colId2 INTEGER PRIMARY KEY AUTOINCREMENT,
    $colUsername TEXT,
    $colPassword TEXT,
  );
''';
  

  
  String colId = 'id';
  String colTitle = 'title';
  String colContent = 'content';
  String colStartDate = 'startDate';
  String colStartTime = 'startTime';
  String colEndDate = 'endDate';
  String colEndTime = 'endTime';

  
  String colId2 = 'usrId';
  String colUsername = 'usrNome';
  String colPassword = 'usrSenha';

  

  Future<Database> _initDb(String filePath) async {
    print('Iniciando banco de dados...');
    String dbPath = await getDatabasesPath();
    final path =  join(dbPath, filePath );
     print('Banco de dados iniciado.');
    return await openDatabase(path, version: 1, onCreate: _createDb );
  }

  void _createDb(Database database, int version) async {
    print('Criando tabela $notesTable...');
    await database.execute('''
      CREATE TABLE $notesTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, $colContent TEXT, $colStartDate TEXT, $colStartTime TEXT, $colEndDate TEXT, $colEndTime TEXT)
    ''');
    print('Tabela $notesTable criada.');

    print('Criando tabela $usuariosTable...');
    await database.execute('''
      CREATE TABLE $usuariosTable($colId2 INTEGER PRIMARY KEY AUTOINCREMENT, $colUsername TEXT, $colPassword TEXT)
    ''');
    print('Tabela $usuariosTable criada.');
  }

  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> result = await db.query(notesTable);
    return result;
  }

  Future<List<Note>> getNoteList() async {
  final List<Map<String, dynamic>> noteMapList = await getNoteMapList();
  final List<Note> noteList = [];
  for (var noteMap in noteMapList) {
    noteList.add(Note.fromJson(noteMap));
  }
  return noteList;
}


  Future<Note> insert(Note note) async {
    final db = await instance.database;   
    final id = await db.insert(notesTable, note.toJson());
    return note.copy(id: id);
  }

  Future<int> update(Note note) async {
    final db = await instance.database;
    final result = await db.update(
      notesTable,
      note.toJson(),
      where: '$colId = ?',
      whereArgs: [note.id],
    );
    return result;
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    final result = await db.delete(
      notesTable,
      where: '$colId = ?',
      whereArgs: [id],
    );
    return result;
  }

  Future<int> saveUser(Usuarios usuario ) async {
    final db = await instance.database;
    final result = await db.insert(usuariosTable, usuario.toMap());
    return result;
  }

  Future<bool> login(Usuarios usuario) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> result = await db.query(
      usuariosTable,
      where: '$colUsername = ? AND $colPassword = ?',
      whereArgs: [usuario.usrNome, usuario.usrSenha],
    );
    return result.isNotEmpty;
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}



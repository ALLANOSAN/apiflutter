// tarefas.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class TarefasDatabase {
  static final TarefasDatabase instance = TarefasDatabase._init();

  static Database? _database;

  TarefasDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('dados.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tarefas (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        titulo TEXT,
        descricao TEXT,
        concluida INTEGER
      )
    ''');
  }
}
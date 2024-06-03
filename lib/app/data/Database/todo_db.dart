import 'package:getxtutorial6sqlitetodo/JsonModels/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:getxtutorial6sqlitetodo/app/data/Database/database_service.dart';
import 'package:getxtutorial6sqlitetodo/app/data/model/todo.dart';
import 'package:sqflite/sqlite_api.dart';

class Tododb{
  final tableName = 'notes';

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName(
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "title" TEXT NOT NUL,
    "content" TEXT NOT NULL,
    PRIMARY KEY("id" AUTOINCREMENT)
    )""");
  }

  Future<int> create({required String title,content}) async{
    final database = await DatabaseService().database;
    return await database.rawInsert('''INSERT INTO $tableName(title,content ) VALUES(??)''',
    [title, content]
    );
  }


  Future<List<Todo>> fetchAll() async {
    final databae = await DatabaseService().database;
    final todos = await databae.rawQuery('''SELECT * FROM $tableName''');
    return todos.map((todo) => Todo.fromSqfliteDatabase(todo)).toList();
  }

  Future<Todo> fetchById(int id) async {
    final database = await DatabaseService().database;
    final todo = await database.rawQuery('''SELECT * FROM $tableName WHERE id = ?''', [id]);
    return Todo.fromSqfliteDatabase(todo.first);
  }

  Future<int> update({required int id, required String title, required String content}) async{
    final database = await DatabaseService().database;
    return await database.rawUpdate(
      'UPDATE $tableName SET title = ? WHERE id = ?',
    [title, id],
    );
  }

  Future<int> delete(int id) async {
    final database = await DatabaseService().database;
    return await database.rawDelete('''DELETE FROM $tableName WHERE id = ?''', [id]);
  }

  Future<int> saveUser(Usuarios usuario ) async {
    final database = await DatabaseService().database;
    final result = await database.insert(usuariosTable, usuario.toMap());
    return result;
  }
}

import 'package:apiflutter/JsonModels/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  final databasename = "notes.db";
  String usuarios = 
  "CREATE TABLE usuarios (usrid INTEGER PRIMARY KEY AUTOINCREMENT, usrName TEXT UNIQUE, usrSenha TEXT)";
  
  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databasename);

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(usuarios);
      }
    );
  }

  Future<bool> login(Usuarios usuario) async {
    final Database db = await initDB();

    var result = await db.rawQuery(
      "SELECT * FROM usuarios WHERE usrNome = '${usuario.usrNome}' AND usrSenha = '${usuario.usrSenha}'"
    );

    if (result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<int> cadastro(Usuarios usuario) async {
    final Database db = await initDB();
    
    return db.insert("usuarios", usuario.toMap());
  }
}

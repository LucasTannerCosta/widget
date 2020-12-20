import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

final String usuarioTable = "usuarioTable";
final String idColumm = "idColumm";
final String loginColumm = "loginColumm";
final String senhaColumm = "senhaColumm";
final String imgColumm = "imgColumm";

class UsuarioItem {
  static final UsuarioItem _instance = UsuarioItem.internal();

  factory UsuarioItem() => _instance;

  UsuarioItem.internal();

  Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, "usuario.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
          await db.execute(
              "CREATE TABLE $usuarioTable(" +
                  " $idColumm INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, " +
                  " $loginColumm TEXT," +
                  " $senhaColumm TEXT," +
                  " $imgColumm TEXT" +
                  ")");
        });
  }

  Future<Usuario> saveUsuario(Usuario usuario) async {
    List<Usuario> usuario_corrente = List();
    Database dbUsuario = await db;
    usuario.id = await dbUsuario.insert(usuarioTable, usuario.toMap());
    return usuario;
  }

  Future<Usuario> getUsuario(int id) async {
    Database dbUsuario = await db;
    List<Map> maps = await dbUsuario.query(usuarioTable,
        columns: [idColumm, loginColumm, senhaColumm, imgColumm],
        where: "$idColumm = ?",
        whereArgs: [id]);
    if (maps.length > 0) {
      return Usuario.FromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deleteUsuario(int id) async {
    Database dbUsuario = await db;
    return await dbUsuario
        .delete(usuarioTable, where: "$idColumm = ?", whereArgs: [id]);
  }

  Future<int> updateUsuario(Usuario usuario) async {
    Database dbUsuario = await db;
    return await dbUsuario.update(usuarioTable, usuario.toMap(),
        where: "$idColumm = ?", whereArgs: [usuario.id]);
  }

  Future<List> getAllUsuario() async {
    Database dbUsuario = await db;
    List listMap = await dbUsuario.rawQuery("SELECT * FROM $usuarioTable");
    List<Usuario> listUsuario = List();
    for(Map m in listMap){
      listUsuario.add(Usuario.FromMap((m)));
    }
    return listUsuario;
  }

  Future<int> getNumber() async {
    Database dbUsuario = await db;
    return Sqflite.firstIntValue(await dbUsuario.rawQuery("SELECT COUNT(*) FROM $usuarioTable"));
  }

  Future close() async {
    Database dbUsuario = await db;
    dbUsuario.close();
  }

}

class Usuario {
  int id;
  String login;
  String senha;
  String img;

  Usuario();

  Usuario.FromMap(Map map) {
    id = map[idColumm];
    login = map[loginColumm];
    senha = map[senhaColumm];
    img = map[imgColumm];
  }

  Map toMap() {
    Map<String, dynamic> map = {loginColumm: login, senhaColumm: senha, imgColumm: img};

    if (id != null) {
      map[idColumm] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "Usuario(id: $id, login: $login, senha: $senha, imagem: $img)";
  }
}

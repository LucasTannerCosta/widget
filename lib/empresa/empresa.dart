import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

final String empresaTable = "empresaTable";
final String idColumm = "idColumm";
final String nameColumm = "nameColumm";
final String cnpjColumm = "cnpjColumm";
final String enderecoColumm = "enderecoColumm";
final String cepColumm = "cepColumm";
final String cidadeColumm = "cidadeColumm";
final String estadoColumm = "estadoColumm";
final String emailColumm = "emailColumm";
final String telefoneColumm = "telefoneColumm";
final String imgColumm = "telefoneColumm";

class EmpresaItem {
  static final EmpresaItem _instance = EmpresaItem.internal();

  factory EmpresaItem() => _instance;

  EmpresaItem.internal();

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
    final path = join(databasesPath, "empresa.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
          await db.execute(
              "CREATE TABLE $empresaTable(" +
                  " $idColumm INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, " +
                  " $nameColumm TEXT," +
                  " $cnpjColumm TEXT," +
                  " $enderecoColumm TEXT," +
                  " $cepColumm TEXT," +
                  " $estadoColumm TEXT," +
                  " $cidadeColumm TEXT," +
                  " $emailColumm TEXT," +
                  " $telefoneColumm TEXT" +
                  ")");
        });
  }

  Future<Empresa> saveEmpresa(Empresa empresa) async {
    Database dbEmpresa = await db;
    empresa.id = await dbEmpresa.insert(empresaTable, empresa.toMap());
    return empresa;
  }

  Future<Empresa> getEmpresa(int id) async {
    Database dbEmpresa = await db;
    List<Map> maps = await dbEmpresa.query(empresaTable,
        columns: [idColumm, nameColumm, cnpjColumm, enderecoColumm, cepColumm, cidadeColumm, emailColumm, telefoneColumm],
        where: "$idColumm = ?",
        whereArgs: [id]);
    if (maps.length > 0) {
      return Empresa.FromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deleteEmpresa(int id) async {
    Database dbEmpresa = await db;
    return await dbEmpresa
        .delete(empresaTable, where: "$idColumm = ?", whereArgs: [id]);
  }

  Future<int> updateEmpresa(Empresa empresa) async {
    Database dbEmpresa = await db;
    return await dbEmpresa.update(empresaTable, empresa.toMap(),
        where: "$idColumm = ?", whereArgs: [empresa.id]);
  }

  Future<List> getAllEmpresa() async {
    Database dbEmpresa = await db;
    List listMap = await dbEmpresa.rawQuery("SELECT * FROM $empresaTable");
    List<Empresa> listEmpresa = List();
    for(Map m in listMap){
      listEmpresa.add(Empresa.FromMap((m)));
    }
    return listEmpresa;
  }

  Future<int> getNumber() async {
    Database dbEmpresa = await db;
    return Sqflite.firstIntValue(await dbEmpresa.rawQuery("SELECT COUNT(*) FROM $empresaTable"));
  }

  Future close() async {
    Database dbEmpresa = await db;
    dbEmpresa.close();
  }

}

class Empresa {
  int id;
  String name;
  String cnpj;
  String endereco;
  String cep;
  String estado;
  String cidade;
  String email;
  String telefone;
  String img;

  Empresa();

  Empresa.FromMap(Map map) {
    id = map[idColumm];
    name = map[nameColumm];
    cnpj = map[cnpjColumm];
    endereco = map[enderecoColumm];
    cep = map[cepColumm];
    estado = map[estadoColumm];
    cidade = map[cidadeColumm];
    email = map[emailColumm];
    telefone = map[telefoneColumm];
    img = map[imgColumm];
  }

  Map toMap() {
    Map<String, dynamic> map = {nameColumm: name, cnpjColumm: cnpj, enderecoColumm: endereco, cepColumm: cep, estadoColumm: estado, cidadeColumm: cidade, emailColumm: email, telefoneColumm: telefone};

    if (id != null) {
      map[idColumm] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "Empresa(id: $id, name: $name, CNPJ: $cnpj, endereço: $endereco, CEP: $cep, estado: $estado, cidade: $cidade, email: $email, telefone: $telefone, imagem: $img";
  }
}

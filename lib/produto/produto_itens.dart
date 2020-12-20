import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

final String produtoTable = "produtoTable";
final String idColumm = "idColumm";
final String nameColumm = "nameColumm";
final String pesoColumm = "pesoColumm";
final String imgColumm = "imgColumm";

class ProdutoItem {
  static final ProdutoItem _instance = ProdutoItem.internal();
  factory ProdutoItem() => _instance;

  ProdutoItem.internal();

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
    final path = join(databasesPath, "produto.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(
          "CREATE TABLE $produtoTable(" +
          " $idColumm INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, " +
          " $nameColumm TEXT," +
          " $pesoColumm TEXT," +
          " $imgColumm TEXT" +
          ")");
    });
  }

  Future<Produto> saveProduto(Produto produto) async {
    Database dbProduto = await db;
    produto.id = await dbProduto.insert(produtoTable, produto.toMap());
    return produto;
  }

  Future<Produto> getProduto(int id) async {
    Database dbProduto = await db;
    List<Map> maps = await dbProduto.query(produtoTable,
        columns: [idColumm, nameColumm, pesoColumm, imgColumm],
        where: "$idColumm = ?",
        whereArgs: [id]);
    if (maps.length > 0) {
      return Produto.FromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deleteProduto(int id) async {
    Database dbProduto = await db;
    return await dbProduto
        .delete(produtoTable, where: "$idColumm = ?", whereArgs: [id]);
  }

  Future<int> updateProduto(Produto produto) async {
    Database dbProduto = await db;
    return await dbProduto.update(produtoTable, produto.toMap(),
        where: "$idColumm = ?", whereArgs: [produto.id]);
  }

  Future<List> getAllProduto() async {
    Database dbProduto = await db;
    List listMap = await dbProduto.rawQuery("SELECT * FROM $produtoTable");
    List<Produto> listProduto = List();
    for(Map m in listMap){
      listProduto.add(Produto.FromMap((m)));
    }
    return listProduto;
  }
  
  Future<int> getNumber() async {
    Database dbProduto = await db;
    return Sqflite.firstIntValue(await dbProduto.rawQuery("SELECT COUNT(*) FROM $produtoTable"));
  }

  Future close() async {
    Database dbProduto = await db;
    dbProduto.close();
  }
}

class Produto {
  int id;
  String name;
  String peso;
  String img;

  Produto();

  Produto.FromMap(Map map) {
    id = map[idColumm];
    name = map[nameColumm];
    peso = map[pesoColumm];
    img = map[imgColumm];
  }

  Map toMap() {
    Map<String, dynamic> map = {nameColumm: name, pesoColumm: peso, imgColumm: img};

    if (id != null) {
      map[idColumm] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "Produto(id: $id, name: $name, peso: $peso, imagem: $img";
  }
}

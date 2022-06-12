import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/product.dart';

class DbHelper{
  late Database _db;

  // getter oluşturalım.
  Future<Database> get db async {
    _db = await initializeDb();
    return _db;
  }

  Future<Database> initializeDb() async{
    String dbPath = join(await getDatabasesPath(), "etrade.db");
    var eTradeDb = await openDatabase(dbPath, version: 1, onCreate: createDb);
    return eTradeDb;
  }

  void createDb(Database db, int version) async {
    // veri tabanı
    await db.execute("Create table products(id integer primary key, name text, description text, unitPrice integer)");
  }

  // Tüm veri tabannı listeleyelim
  Future<List<Product>> getProducts() async {
    Database db = await this.db;
    var result = await db.query("products");
    return List.generate( result.length, (i){
      return Product.fromObject(result[i]);
    });
  }

  // Veri ekleme
  Future<int> insert(Product product) async {
    Database db = await this.db;
    var result = await db.insert("products", product.toMap());
    return result;
  }

  // Veri silme
  Future<int> delete(int id) async {
    Database db = await this.db;
    // burada standart sql sorgulaması ile silme komutu giriliyor.
    var result = await db.rawDelete("delete from products where id=$id");
    return result;
  }

  // Veri güncelleme
  Future<int> update(Product product) async {
    Database db = await this.db;
    // burada standart sql sorgulaması ile silme komutu giriliyor.
    var result = await db.update("products", product.toMap(), where:"id=?", whereArgs: [product.id]);
    return result;
  }
}







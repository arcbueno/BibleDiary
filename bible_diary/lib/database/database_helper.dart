import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.getInstance();
  DatabaseHelper.getInstance();

  factory DatabaseHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await _initDb();

    return _db;
  }

  Future _initDb() async {
    String databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'data.db');
      print("db $path");

      var db = await openDatabase(path, version: 1, onCreate: _onCreate,);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE data(id INTEGER PRIMARY KEY, date DATETIME, textRead TEXT'
        ', keyVerse TEXT, resume TEXT, whatLearned TEXT, comment TEXT, tag TEXT)');
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}

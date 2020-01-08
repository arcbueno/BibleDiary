import 'package:bible_diary/models/data.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'database_helper.dart';

// Data Access Object
class DataDAO {

  Future<Database> get db => DatabaseHelper.getInstance().db;

  Future<int> saveAsync(Data data) async {
    final dbClient = await db;
    var id = dbClient.insert('data', data.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    print('id: $id');
    return id; 
  }

  Future<List<Data>> getAllAsync() async{
    final dbClient = await db;
    final List<Map<String, dynamic>> list = await dbClient.query('data');
    return _mapToList(list);
  }

  Future<List<Data>> getByDateAsync(DateTime date) async{
    var formatter = DateFormat('yyyy-MM-dd');
    String formatted = formatter.format(date);
    final client = await db;
    final list = await client.rawQuery('select * from data where date = $formatted');
    return _mapToList(list);
  }

  _mapToList(List<Map<String, dynamic>> list){
    return List.generate(list.length, (i) { 
      return Data(
        id: list[i]['id'],
        date: list[i]['date'],
        textRead: list[i]['textRead'],
        resume: list[i]['resume'],
        keyVerse: list[i]['keyVerse'],
        whatLearned: list[i]['whatLearned'],
        comment: list[i]['comment'],
        tag: list[i]['tag']
      );
    });
  }

  // Future<int> save(Data data) async {
  //   var dbClient = await db;
  //   var id = await dbClient.insert("data", data.toMap(),
  //       conflictAlgorithm: ConflictAlgorithm.replace);
  //   print('id: $id');
  //   return id;
  // }

  // Future<List<Data>> findAll() async {
  //   final dbClient = await db;

  //   final list = await dbClient.rawQuery('select * from data');

  //   return list;
  // }

  // Future<List<Data>> findAllByTipo(DateTime date) async {
  //   final dbClient = await db;

  //   final list = await dbClient.rawQuery('select * from data where date =? ',[date]);

  //   final data = list.map<Data>((json) => Data.fromJson(json)).toList();

  //   return data;
  // }

  // Future<Data> findById(int id) async {
  //   var dbClient = await db;
  //   final list =
  //       await dbClient.rawQuery('select * from data where id = ?', [id]);

  //   if (list.length > 0) {
  //     return new Data.fromJson(list.first);
  //   }

  //   return null;
  // }

  // Future<bool> exists(Data data) async {
  //   Data c = await findById(data.id);
  //   var exists = c != null;
  //   return exists;
  // }

  // Future<int> count() async {
  //   final dbClient = await db;
  //   final list = await dbClient.rawQuery('select count(*) from data');
  //   return Sqflite.firstIntValue(list);
  // }

  // Future<int> delete(int id) async {
  //   var dbClient = await db;
  //   return await dbClient.rawDelete('delete from data where id = ?', [id]);
  // }

  // Future<int> deleteAll() async {
  //   var dbClient = await db;
  //   return await dbClient.rawDelete('delete from data');
  // }
}
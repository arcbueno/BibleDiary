// import 'package:bible_diary/models/data.dart';
// import 'package:sqflite/sqflite.dart';
// import 'database_helper.dart';

// // Data Access Object
// class DataDAO {

//   Future<Database> get db => DatabaseHelper.getInstance().db;

//   Future<int> save(Data data) async {
//     var dbClient = await db;
//     var id = await dbClient.insert("data", data.toMap(),
//         conflictAlgorithm: ConflictAlgorithm.replace);
//     print('id: $id');
//     return id;
//   }

//   Future<List<Data>> findAll() async {
//     final dbClient = await db;

//     final list = await dbClient.rawQuery('select * from data');

//     final datas = list.map<Data>((json) => Data.fromJson(json)).toList();

//     return datas;
//   }

//   Future<List<Data>> findAllByTipo(DateTime date) async {
//     final dbClient = await db;

//     final list = await dbClient.rawQuery('select * from data where date =? ',[date]);

//     final data = list.map<Data>((json) => Data.fromJson(json)).toList();

//     return data;
//   }

//   Future<Data> findById(int id) async {
//     var dbClient = await db;
//     final list =
//         await dbClient.rawQuery('select * from data where id = ?', [id]);

//     if (list.length > 0) {
//       return new Data.fromJson(list.first);
//     }

//     return null;
//   }

//   Future<bool> exists(Data data) async {
//     Data c = await findById(data.id);
//     var exists = c != null;
//     return exists;
//   }

//   Future<int> count() async {
//     final dbClient = await db;
//     final list = await dbClient.rawQuery('select count(*) from data');
//     return Sqflite.firstIntValue(list);
//   }

//   Future<int> delete(int id) async {
//     var dbClient = await db;
//     return await dbClient.rawDelete('delete from data where id = ?', [id]);
//   }

//   Future<int> deleteAll() async {
//     var dbClient = await db;
//     return await dbClient.rawDelete('delete from data');
//   }
// }
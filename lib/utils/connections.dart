import 'package:intl/intl.dart';
import 'package:lang/model/verb.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import "data.dart";
import "dart:io";

class DB {
  static Database? _db;
  final String columnId = "id";
  final String columnRu = "ru";
  final String columnEn = "en";
  final String columnPoints = "points";
  final String tablename = "verbs";

  Future<Database?> get db async {
    if (_db != null) return _db;
    _db = await init();
    return _db;
  }

  init() async {
    String dbpath = await getDatabasesPath();
    String path = join(dbpath, "$tablename.db");
    var db = await openDatabase(path, version: 1,
        onCreate: (Database db, int newVersion) async {
      await db.execute(
          "create table if not EXISTS $tablename(id INTEGER PRIMARY KEY autoincrement,ru text not null,en text not NULL,points int  ot null default 0,last_update text default '1900-01-01 00:00:00')");
      for (var sql in verbs) {
        await db.execute(sql);
      }
    });
    return db;
  }

  Future<List<Verb>> getVerbs() async {
    List<Verb> verbs = [];
    final d = await db;
    var sql =
        "select * from verbs where points<21 and points<(((points/3)*3)+3) and cast(julianday('now')-julianday(last_update) as INTEGER)>6 limit 10";
    var result = await d!.rawQuery(sql);
    if (result.isEmpty) return [];
    for (var vrb in result) {
      verbs.add(Verb.fromMap(vrb));
    }
    return verbs;
  }

  Future<int> updateVerb(Verb v) async {
    try {
      await db;
      DateTime now = DateTime.now();
      v.lastupdate = DateFormat('yyyy-MM-dd kk:mm:ss').format(now);
      print("Datetime: ${v.lastupdate}");
      return await _db!.update(tablename, v.toMap(),
          where: "$columnId=?", whereArgs: [v.id]);
    } catch (e) {
      print("Data ${v.toMap()[0]}");
      print("Error:  $e");
    }
    return 0;
  }

  Future<int?> getCount() async {
    var dbClient = await db;
    var sql = "SELECT sum(points) FROM $tablename";
    return Sqflite.firstIntValue(await dbClient!.rawQuery(sql));
  }

  Future close() async {
    var d = await db;
    return await d!.close();
  }
}

import 'package:sqflite/sqflite.dart';

import '../models/task.dart';

class DBHelper {
  static Database? _db;
  static const int _version = 1;
  static const String _dbName = 'tasks';

  static init() async {
    if (_db != null)
      print('DataBase already exisits');
    else {
      try {
        String path = await getDatabasesPath() + 'path.db';
        _db = await openDatabase(path, version: _version,
            onCreate: (Database db, int version) async {
          await db.execute(
            'CREATE TABLE $_dbName('
                'id INTEGER PRIMARY KEY AUTOINCREMENT, '
                'title STRING, note TEXT, date STRING, '
                'startTime STRING, endTime STRING, '
                'remind INTEGER, repeat STRING, '
                'color INTEGER, '
                'isCompleted INTEGER)',);
        });
      } catch (e) {
        print(e);
      }
    }
  }

  static Future insert(Task task) async {
    print('data inserted');
    return await _db!.insert(_dbName, task.toJson());
  }

  static Future delete(Task task) async {
    print('data deleted');
    return await _db!.delete(_dbName, where: 'id = ?', whereArgs: [task.id]);
  }

  static Future update(int id) async {
    print('data updated');
    return await _db!.rawUpdate('''
    UPDATE  tasks
    SET isCompleted = ? 
    WHERE id = ?
    ''', [1, id]);
  }

  static Future<List<Map<String, dynamic>>>query()async{
    print('query done');
    return await _db!.query(_dbName);
  }
}

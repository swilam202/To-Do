import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/task.dart';

class DBHelper {
  static Database? _db;
  static const int _version = 1;
  static const String _dbName = 'tasks';

  static init() async {
    if (_db == null) {
      String dbPath = await getDatabasesPath();
      String path = await join(dbPath, 'tod.db');
      _db = await openDatabase(path, version: _version,
          onCreate: (Database db, int version) async {
        return db.execute('CREATE TABLE $_dbName('
            'id INTEGER PRIMARY KEY AUTOINCREMENT, '
            'title TEXT, note TEXT, date TEXT, '
            'startTime TEXT, endTime TEXT, '
            'remind INTEGER, repeat TEXT, '
            'color INTEGER, '
            'isCompleted INTEGER)');
      });
    } else
      return;
  }

  static Future insert(Task task) async {
    return await _db!.insert(_dbName, task.toJson());
  }

  static Future delete(int id) async {
    return await _db!.delete(_dbName, where: 'id = ?', whereArgs: [id]);
  }

  static Future deleteAll() async {
    return await _db!.delete(_dbName);
  }

  static Future update(int id) async {
    print('data updated');
    return await _db!.rawUpdate('''
    UPDATE  tasks
    SET isCompleted = ? 
    WHERE id = ?
    ''', [1, id]);
  }

  static Future<List<Map<String, dynamic>>> query() async {
    return await _db!.query(_dbName);
  }

  static deleteDB() async {
    String dbPath = await getDatabasesPath();
    String path = await join(dbPath, 'tod.db');
    deleteDatabase(path);
    print('+++++++++++++++DATABASE deleted++++++++++++');
  }
}

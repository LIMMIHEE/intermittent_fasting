import 'package:intermittent_fasting/core/utils/prefs_utils.dart';
import 'package:intermittent_fasting/domain/entities/history.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class SQLiteHelper {
  static Database? _database;
  static get getDatabase async {
    if (_database != null) return _database;
    _database = await initDataBase();
    return _database;
  }

  static Future<Database> initDataBase() async {
    String path = p.join(await getDatabasesPath(), 'history_database.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  static Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE history (
      id INTEGER PRIMARY KEY,
      startDate TEXT,
      endDate TEXT,
      fastingRatio TEXT,
      memo TEXT
    )
    ''');
  }

  static Future insertHistory(History history) async {
    Database db = await getDatabase;

    await db
        .insert('history', history.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace)
        .then((value) {
      PrefsUtils.setInt(PrefsUtils.nowEatHistoryId, value);
    });
  }

  static Future clearHistory() async {
    Database db = await getDatabase;

    await db.delete('history');
  }

  static Future<List<History>> loadHistory() async {
    Database db = await getDatabase;

    final List<Map> maps = await db.query('history');
    return List.generate(
        maps.length,
        (index) => History(
            id: maps[index]['id'],
            startDate: maps[index]['startDate'],
            endDate: maps[index]['endDate'],
            fastingRatio: maps[index]['fastingRatio'],
            memo: maps[index]['memo']));
  }

  static Future<History> getHistory(int id) async {
    Database db = await getDatabase;

    final List<Map> maps =
        await db.query('history', where: 'id = ?', whereArgs: [id]);
    return List.generate(
        1,
        (index) => History(
            id: maps[index]['id'],
            startDate: maps[index]['startDate'],
            endDate: maps[index]['endDate'],
            fastingRatio: maps[index]['fastingRatio'],
            memo: maps[index]['memo'])).first;
  }

  static Future<History> getLastHistory() async {
    Database db = await getDatabase;

    final List<Map> maps =
        await db.query('history', orderBy: "id DESC", limit: 1);
    return List.generate(
        1,
        (index) => History(
            id: maps[index]['id'],
            startDate: maps[index]['startDate'],
            endDate: maps[index]['endDate'],
            fastingRatio: maps[index]['fastingRatio'],
            memo: maps[index]['memo'])).first;
  }

  static Future updateHistory(History newHistory) async {
    Database db = await getDatabase;

    await db.update('history', newHistory.toJson(),
        where: "id=?", whereArgs: [newHistory.id]);
  }

  static Future deleteHistory(History history) async {
    Database db = await getDatabase;

    await db.delete('history', where: "id=?", whereArgs: [history.id]);
  }
}

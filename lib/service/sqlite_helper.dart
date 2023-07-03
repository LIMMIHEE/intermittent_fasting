import 'package:intermittent_fasting/model/history.dart';
import 'package:intermittent_fasting/utils/globals.dart';
import 'package:intermittent_fasting/utils/prefs.dart';
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
      prefs.setInt(Prefs().nowEatHistoryId, value);
    });
  }

  static Future<List<History>> loadHistory() async {
    Database db = await getDatabase;

    List<Map> maps = await db.query('history');
    return List.generate(
        maps.length,
        (index) => History(
            id: maps[index]['id'],
            startDate: maps[index]['startDate'],
            endDate: maps[index]['endDate'],
            fastingRatio: maps[index]['fastingRatio'],
            memo: maps[index]['memo']));
  }

  static Future getHistory(int id) async {
    Database db = await getDatabase;

    List<Map> maps =
        await db.query('history', where: 'id = ?', whereArgs: [id]);

    return History(
        id: maps[0]['id'],
        startDate: maps[0]['startDate'],
        endDate: maps[0]['endDate'],
        fastingRatio: maps[0]['fastingRatio'],
        memo: maps[0]['memo']);
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

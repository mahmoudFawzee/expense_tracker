import 'package:expense_tracker/data/constants/json_keys.dart';
import 'package:expense_tracker/data/constants/sqflite_tables.dart';
import 'package:expense_tracker/domain/helper/i_sqflite_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final class SqfliteHelper implements SqfliteHelperInterface {
  static Database? _database;

  //?singleton pattern to make the database just one instance in
  //?the whole application.

  static final SqfliteHelper _instance = SqfliteHelper._internal();
  factory SqfliteHelper() => _instance;
  SqfliteHelper._internal();

  //todo:initialize the data base

  Future<Database> _initDb() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'expense_tracker.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

//?here when we start the chat we will create the history data base.
  Future _onCreate(Database db, int version) async {
    await _createTable(db, '''
CREATE TABLE $userTable(
${JsonKeys.id} INTEGER PRIMARY KEY AUTOINCREMENT,
${JsonKeys.userId} INTEGER,
${JsonKeys.firstName} TEXT,
${JsonKeys.lastName} TEXT,
${JsonKeys.phoneNumber} TEXT,
${JsonKeys.email} TEXT
)
''');
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }
  //?query is the sql command to create the new table.

  Future _createTable(Database db, String query) async {
    await db.execute(query);
  }

  @override
  Future delete(
    String tableName, {
    required String where,
    required List<Object?> whereArgs,
  }) async {
    final db = await database;
    final result = await db.delete(
      tableName,
      where: where,
      whereArgs: whereArgs,
    );
    return result != 0;
  }

  @override
  Future<List<Map<String, dynamic>>> filter(
    String tableName, {
    required String where,
    required List<Object?> whereArgs,
  }) async {
    final db = await database;
    final result = await db.query(
      tableName,
      where: where,
      whereArgs: whereArgs,
    );
    return result;
  }

  @override
  Future<List<Map<String, dynamic>>> index(String tableName) async {
    final db = await database;
    final result = await db.query(tableName);
    return result;
  }

  @override
  Future insert(String tableName, {required Map<String, dynamic> row}) async {
    final db = await database;
    final result = await db.insert(tableName, row);
    return result != 0;
  }

  @override
  Future update(String tableName, {required Map<String, dynamic> row}) async {
    final db = await database;
    final result = await db.update(
      tableName,
      row,
      where: 'id=?',
      whereArgs: [row['id']],
    );
    return result != 0;
  }

  @override
  Future dropTable(String tableName) async {
    final db = await database;
    final result = await db.delete(tableName);
    return result != 0;
  }

  @override
  Future<Map<String, dynamic>?> show(
    String tableName, {
    int? id,
  }) async {
    final db = await database;
    final result = await db.query(
      tableName,
      //?if the id = null then its no need to provide where
      where: id == null ? null : 'id=?',
      whereArgs: id == null ? null : [id],
      limit: 1,
    );
    return result.first;
  }
}

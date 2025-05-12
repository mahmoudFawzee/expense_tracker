import 'dart:developer';

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
    try {
      String dbPath = await getDatabasesPath();
      String path = join(dbPath, 'expense_tracker.db');
      return await openDatabase(path, version: 1, onCreate: _onCreate);
    } on DatabaseException catch (e) {
      log('db error: $e');
      throw Exception('Database error');
    }
  }

//?here when we start the chat we will create the history data base.
  Future _onCreate(Database db, int version) async {
    try {
      await _createTable(db, '''
CREATE TABLE $userTable(
${JsonKeys.id} INTEGER PRIMARY KEY AUTOINCREMENT,
${JsonKeys.firstName} TEXT,
${JsonKeys.lastName} TEXT,
${JsonKeys.phoneNumber} TEXT,
${JsonKeys.email} TEXT
)
''');
    } on DatabaseException catch (e) {
      log('db error: $e');
      throw Exception('Database error');
    }
  }

  Future<Database> get database async {
    try {
      if (_database != null) return _database!;
      _database = await _initDb();
      return _database!;
    } on DatabaseException catch (e) {
      log('db error: $e');
      throw Exception('Database error');
    }
  }
  //?query is the sql command to create the new table.

  Future _createTable(Database db, String query) async {
    try {
      await db.execute(query);
    } on DatabaseException catch (e) {
      log('db error: $e');
      throw Exception('Database error');
    }
  }

  @override
  Future delete(
    String tableName, {
    required String where,
    required List<Object?> whereArgs,
  }) async {
    try {
      final db = await database;
      final result = await db.delete(
        tableName,
        where: where,
        whereArgs: whereArgs,
      );
      return result != 0;
    } on DatabaseException catch (e) {
      log('db error: $e');
      throw Exception('Database error');
    }
  }

  @override
  Future<List<Map<String, dynamic>>> filter(
    String tableName, {
    required String where,
    required List<Object?> whereArgs,
  }) async {
    try {
      final db = await database;
      final result = await db.query(
        tableName,
        where: where,
        whereArgs: whereArgs,
      );
      return result;
    } on DatabaseException catch (e) {
      log('db error: $e');
      throw Exception('Database error');
    }
  }

  @override
  Future<List<Map<String, dynamic>>> index(String tableName) async {
    try {
      final db = await database;
      final result = await db.query(tableName);
      return result;
    } on DatabaseException catch (e) {
      log('db error: $e');
      throw Exception('Database error');
    }
  }

  @override
  Future insert(String tableName, {required Map<String, dynamic> row}) async {
    try {
      final db = await database;
      final result = await db.insert(tableName, row);
      return result != 0;
    } on DatabaseException catch (e) {
      log('db error: $e');
      throw Exception('Database error');
    }
  }

  @override
  Future update(String tableName, {required Map<String, dynamic> row}) async {
    try {
      final db = await database;
      final result = await db.update(
        tableName,
        row,
        where: 'id=?',
        whereArgs: [row['id']],
      );
      return result != 0;
    } on DatabaseException catch (e) {
      log('db error: $e');
      throw Exception('Database error');
    }
  }

  @override
  Future dropTable(String tableName) async {
    try {
      final db = await database;
      final result = await db.delete(tableName);
      return result != 0;
    } on DatabaseException catch (e) {
      log('db error: $e');
      throw Exception('Database error');
    }
  }

  @override
  Future<Map<String, dynamic>?> show(
    String tableName, {
    int? id,
  }) async {
    log('start get user in sqflite service: $id');

    try {
      final db = await database;
      final allUsers = await index(tableName);
      log('all users: $allUsers and l: ${allUsers.length}');
      if (id == null) {
        final data = await db.query(tableName);
        return data.first;
      }
      final result = await db.query(
        tableName,
        //?if the id = null then its no need to provide where
        where: 'id=?',
        whereArgs: [id],
        limit: 1,
      );
      return result.first;
    } on DatabaseException catch (e) {
      log('db error: $e');
      throw Exception('Database error');
    }
  }
}

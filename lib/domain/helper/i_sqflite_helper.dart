abstract class SqfliteHelperInterface {
  Future dropTable(String tableName);
  Future insert(String tableName, {required Map<String, dynamic> row});
  Future delete(
    String tableName, {
    required String where,
    required List<Object?> whereArgs,
  });
  //?update an old row
  Future update(String tableName, {required Map<String, dynamic> row});
  //?this for fetching all row in a table
  Future index(String tableName);
  //?this for fetch one row in a table
  Future show(String tableName, {required int id});
  //?get specific rows based on a condition.
  Future filter(
    String tableName, {
    required String where,
    required List<Object?> whereArgs,
  });
}

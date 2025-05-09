import 'package:expense_tracker/data/constants/sqflite_tables.dart';
import 'package:expense_tracker/data/helper/sqflite_helper.dart';
import 'package:expense_tracker/data/models/user/m_user.dart';
import 'package:expense_tracker/domain/entities/user.dart';
import 'package:expense_tracker/domain/services/user/i_local_user_service.dart';

final class LocalUserService implements LocalUserServiceInterface {
  final _sqfliteHelper = SqfliteHelper();

  @override
  Future<bool> deleteUser(String password) async {
    final user = await getUser();
    if (user == null) return false;
    final result = await _sqfliteHelper.delete(
      userTable,
      where: 'id=?',
      whereArgs: [user.id],
    );
    return result;
  }

  @override
  Future<User?> getUser() async {
    final result = await _sqfliteHelper.show(userTable);
    if (result == null) return null;
    return UserModel.fromJson(result);
  }

  //?store data locally.
  @override
  Future<bool> storeUser(UserModel user) async {
    final result =
        await _sqfliteHelper.insert(userTable, row: user.toSqliteJson());
    return result;
  }

  @override
  Future updateUser(UserModel user) async {
    final result =
        await _sqfliteHelper.update(userTable, row: user.toSqliteJson());
    return result;
  }
}

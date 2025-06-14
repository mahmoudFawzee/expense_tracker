import 'package:expense_tracker/data/constants/sqflite_tables.dart';
import 'package:expense_tracker/data/helper/sqflite_helper.dart';
import 'package:expense_tracker/data/models/user/m_user.dart';
import 'package:expense_tracker/domain/entities/user.dart';
import 'package:expense_tracker/domain/services/user/i_local_user_service.dart';

final class LocalUserServiceImpl implements LocalUserServiceInterface {
  final _sqfliteHelper = SqfliteHelper();

  @override
  Future<bool> deleteUser(int id) async {
    final user = await getUser(id: id);
    if (user == null) return false;
   return  await _sqfliteHelper.delete(
      userTable,
      where: 'id=?',
      whereArgs: [user.id],
    );
  }

  @override
  Future<User?> getUser({required int? id}) async {
    
    final result = await _sqfliteHelper.show(userTable, id: id);

    if (result == null) return null;
    final User user = UserModel.fromJson(result);

    return user;
  }

  //?store data locally.
  @override
  Future<User?> storeUser(UserModel user) async {
    await _sqfliteHelper.insert(userTable, row: user.toSqlJson());

    return await getUser(id: user.id);
  }

  @override
  Future<User?> updateUser(UserModel user) async {
    final rowUser = user.toSqlJson();

    await _sqfliteHelper.update(userTable, row: rowUser);
    return getUser(id: user.id);
  }
}

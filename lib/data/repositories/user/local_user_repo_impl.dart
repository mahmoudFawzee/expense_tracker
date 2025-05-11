import 'package:expense_tracker/data/models/user/m_user.dart';
import 'package:expense_tracker/data/services/user/local_user_service_impl.dart';
import 'package:expense_tracker/domain/entities/user.dart';
import 'package:expense_tracker/domain/repositories/user/i_local_user_repo.dart';

final class LocalUserRepoImpl implements LocalUserRepoInterface {
  final LocalUserServiceImpl _localUserServiceImpl;
  const LocalUserRepoImpl(this._localUserServiceImpl);

  @override
  Future<User?> getUser({int? id}) async =>
      await _localUserServiceImpl.getUser(id: id);

  @override
  Future<User?> updateUser(UserModel user) async =>
      await _localUserServiceImpl.updateUser(user);

  @override
  Future<bool> deleteUser() async {
    final user = await getUser();
    return _localUserServiceImpl.deleteUser(user!.id!);
  }

  @override
  Future<User?> storeUser(UserModel user) async =>
      await _localUserServiceImpl.storeUser(user);
}

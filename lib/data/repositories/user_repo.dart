import 'package:expense_tracker/data/models/user/m_user.dart';
import 'package:expense_tracker/data/services/apis/user_service.dart';
import 'package:expense_tracker/data/services/local/local_user_service.dart';
import 'package:expense_tracker/domain/entities/user.dart';
import 'package:expense_tracker/domain/repositories/i_user_repo.dart';

final class UserDataRepo implements UserRepoInterface {
  final LocalUserService _localUserService;
  final UserServiceApi _userServiceApi;
  const UserDataRepo(this._localUserService, this._userServiceApi);
  @override
  Future deleteUser(String password) async {
    final result = await _userServiceApi.deleteUser(password);
    if (result) {
      await _localUserService.deleteUser(password);
    }
  }

  @override
  Future<User?> getUser() async {
    final localUser = await _localUserService.getUser();
    if (localUser != null) return localUser;
    final remoteUser = await _userServiceApi.getUser();
    final isStored = await _localUserService.storeUser(remoteUser);
    if (isStored) {
      return await _localUserService.getUser();
    }
    return null;
  }

  @override
  Future updateUser(UserModel user) async {
    final updatedUser = await _userServiceApi.updateUser(user);
    await _localUserService.updateUser(updatedUser);
  }

  @override
  Future<bool> storeUserLocally(UserModel user) async =>
      await _localUserService.storeUser(user);

  @override
  Future deleteUserLocally() async => await _localUserService.deleteUser('');
}

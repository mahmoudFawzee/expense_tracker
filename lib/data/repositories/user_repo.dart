import 'package:expense_tracker/data/models/user/m_user.dart';
import 'package:expense_tracker/data/services/apis/user_service.dart';
import 'package:expense_tracker/data/services/local/local_user_service.dart';
import 'package:expense_tracker/domain/repositories/i_user_repo.dart';

final class UserRepo implements UserRepoInterface {
  final LocalUserService _localUserService;
  final UserServiceApi _userServiceApi;
  const UserRepo(this._localUserService, this._userServiceApi);
  @override
  Future deleteUser() async {
    final result = await _userServiceApi.deleteUser();
    if (result) {
      await _localUserService.deleteUser();
    }
  }

  @override
  Future getUser() async {
    final localUser = await _localUserService.getUser();
    if (localUser != null) return localUser;
    return _userServiceApi.getUser();
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
  Future deleteUserLocally() async => await _localUserService.deleteUser();
}

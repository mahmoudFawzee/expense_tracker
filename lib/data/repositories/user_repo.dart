import 'package:expense_tracker/data/models/user/m_user.dart';
import 'package:expense_tracker/data/services/apis/user_service.dart';
import 'package:expense_tracker/data/services/local/local_user_service.dart';
import 'package:expense_tracker/domain/repositories/i_user_repo.dart';

final class UserRepo implements UserRepoInterface {
  final LocalUserService _localUserService;
  final UserServiceApi _userServiceApi;
  const UserRepo(this._localUserService, this._userServiceApi);
  @override
  Future deleteUser(int id) async {
    final result = await _userServiceApi.deleteUser();
    if (result) {
      await _localUserService.deleteUser();
    }
  }

  @override
  Future getUser(int id) async {
    final localUser = await _localUserService.getUser(id);
    if (localUser != null) return localUser;
    return _userServiceApi.getUser(id);
  }

  @override
  Future updateUser(int id, {required UserModel user}) async {
    final updatedUser = await _userServiceApi.updateUser(id, user: user);
    await _localUserService.updateUser(id, user: updatedUser);
  }

  @override
  Future storeUserLocally(UserModel user) async =>
      await _localUserService.storeData(user);

  @override
  Future deleteUserLocally() async => await _localUserService.deleteUser();
}

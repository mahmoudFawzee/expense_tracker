import 'package:expense_tracker/data/models/user/exceptions/user_exception.dart';
import 'package:expense_tracker/data/models/user/m_user.dart';
import 'package:expense_tracker/data/repositories/user/local_user_repo_impl.dart';
import 'package:expense_tracker/data/repositories/user/remote_user_repo_impl.dart';
import 'package:expense_tracker/domain/entities/user.dart';
import 'package:expense_tracker/domain/repositories/user/i_user_repo.dart';

final class UserDataRepo implements UserRope {
  final LocalUserRepoImpl _localUserRepo;
  final RemoteUserRepoImpl _remoteUserRepo;
  const UserDataRepo(this._localUserRepo, this._remoteUserRepo);
  @override
  Future<User?> getUser() async {
    final localUser = await _localUserRepo.getUser();
    if (localUser == null) {
      final apiResponse = await _remoteUserRepo.getUser();
      if (apiResponse.user == null) {
        throw UserException(
            message: apiResponse.message, errors: apiResponse.errors);
      }
      final storedUser = await _localUserRepo.storeUser(apiResponse.user!);
      return storedUser;
    }
    return localUser;
  }

  @override
  Future<User?> storeUser(UserModel user) async =>
      await _localUserRepo.storeUser(user);

  @override
  Future<bool> deleteUser(String password) async {
    final deleted = await _remoteUserRepo.deleteUser(password);
    if (deleted.statusCode != 200) {
      throw UserException(message: deleted.message);
    }
    return await _localUserRepo.deleteUser();
  }

  //?in case user logged out we need to delete his data from
  //?local storage.
  @override
  Future<bool> deleteLocalUser() async => await _localUserRepo.deleteUser();

  @override
  Future<User?> updateUser(UserModel user, {String? password}) async {
    final updated = await _remoteUserRepo.updateUser(user, password: password);
    if (updated.user == null) {
      throw UserException(message: updated.message, errors: updated.errors);
    }

    return await _localUserRepo.updateUser(updated.user!);
  }

  @override
  Future<bool> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    final result = await _remoteUserRepo.changePassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
      confirmNewPassword: confirmNewPassword,
    );
    if (result.statusCode != 200) {
      
      throw UserException(
        message: result.message,
        errors: result.errors, //Map<String,List>
      );
    }
    return true;
  }
}

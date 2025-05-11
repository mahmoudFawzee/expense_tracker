import 'package:expense_tracker/data/models/user/m_user.dart';
import 'package:expense_tracker/data/models/user/user_data_response.dart';
import 'package:expense_tracker/domain/repositories/user/i_remote_user_repo.dart';
import 'package:expense_tracker/data/services/user/remote_user_service_impl.dart';
import 'package:expense_tracker/data/repositories/tokens_repo.dart';

final class RemoteUserRepoImpl implements RemoteUserRepoInterface {
  final TokensRepo _tokensRepo;
  final RemoteUserServiceImpl _remoteUserServiceImpl;
  const RemoteUserRepoImpl(this._remoteUserServiceImpl, this._tokensRepo);
  @override
  Future<UserDataResponse> getUser() async {
    final accessToken = await _tokensRepo.fetchAccessToken();
    return await _remoteUserServiceImpl.getUser(accessToken!);
  }

  @override
  Future<UserDataResponse> updateUser(
    UserModel user, {
    String? password,
  }) async {
    final accessToken = await _tokensRepo.fetchAccessToken();
    final updatedUser = await _remoteUserServiceImpl.updateUser(
      user,
      accessToken: accessToken!,
      password: password,
    );
    return updatedUser;
  }

  @override
  Future<bool> deleteUser(String password) async {
    final accessToken = await _tokensRepo.fetchAccessToken();
    return await _remoteUserServiceImpl.deleteUser(
      password:password,
      accessToken: accessToken!,
    );
  }
}

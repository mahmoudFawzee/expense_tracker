import 'package:expense_tracker/data/models/user/m_user.dart';
import 'package:expense_tracker/data/services/apis/auth_service.dart';
import 'package:expense_tracker/domain/repositories/i_auth_repo.dart';

final class AuthRepo implements AuthRepoInterface {
  final AuthService _authService;
  const AuthRepo(this._authService);
  @override
  Future login({required String email, required String password}) async =>
      await _authService.login(
        email: email,
        password: password,
      );

  @override
  Future logout() async => await _authService.logout();

  @override
  Future register(UserModel user, {required String password}) async =>
      await _authService.register(
        user,
        password: password,
      );
}

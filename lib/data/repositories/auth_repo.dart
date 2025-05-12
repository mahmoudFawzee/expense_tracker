import 'dart:io';
import 'package:expense_tracker/data/models/user/exceptions/auth_exception.dart';
import 'package:expense_tracker/data/models/user/logged_in_user.dart';
import 'package:expense_tracker/data/models/user/m_user.dart';
import 'package:expense_tracker/data/services/auth/auth_service.dart';
import 'package:expense_tracker/domain/entities/user.dart';
import 'package:expense_tracker/domain/repositories/i_auth_repo.dart';

final class AuthRepo implements AuthRepoInterface {
  final AuthService _authService;
  const AuthRepo(this._authService);
  @override
  Future<LoggedInUser> login({
    required String email,
    required String password,
  }) async {
    final response = await _authService.login(
      email: email,
      password: password,
    );
    if (response.statusCode != HttpStatus.ok) {
      throw AuthException(errors: response.errors, message: response.message);
    }
    return LoggedInUser(
      user: response.user!,
      accessToken: response.accessToken!,
      refreshToken: response.refreshToken,
      tokenType: response.tokenType!,
    );
  }

  @override
  Future<bool> logout(String accessToken) async {
    final response = await _authService.logout(accessToken);
    if (response.statusCode != HttpStatus.ok) {
      throw AuthException(
        errors: response.errors,
        message: response.message,
      );
    }
    return true;
  }

  @override
  Future<User?> register(
    UserModel user, {
    required String password,
    required String confirmPassword,
  }) async {
    final response = await _authService.register(
      user,
      password: password,
      confirmPassword: confirmPassword,
    );
    if (response.statusCode != HttpStatus.created) {
      throw AuthException(errors: response.errors, message: response.message);
    }
    return response.user;
  }
}

import 'package:expense_tracker/data/models/user/m_user.dart';

abstract class AuthInterface {
  Future<UserModel> register(
    UserModel user, {
    required String password,
    required String confirmPassword,
  });
  Future<UserModel> login({required String email, required String password});
  Future logout();
}

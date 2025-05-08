import 'package:expense_tracker/data/models/user/m_user.dart';

abstract class AuthRepoInterface {
  Future register(
    UserModel user, {
    required String password,
    required String confirmPassword,
  });

  Future login({required String email, required String password});

  Future logout(String accessToken);
}

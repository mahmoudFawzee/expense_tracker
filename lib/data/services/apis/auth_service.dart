import 'package:expense_tracker/data/models/user/m_user.dart';
import 'package:expense_tracker/domain/services/auth/i_auth.dart';

final class AuthService implements AuthInterface {
  @override
  Future login({required String email, required String password}) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future register(UserModel user, {required String password}) {
    // TODO: implement register
    throw UnimplementedError();
  }
}

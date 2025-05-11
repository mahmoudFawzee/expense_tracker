import 'package:expense_tracker/data/models/user/m_user.dart';

abstract class RemoteUserServiceInterface {
  Future getUser(String accessToken);

  Future updateUser(UserModel user, {required String accessToken});

  Future deleteUser({required String password, required String accessToken});
}

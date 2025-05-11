import 'package:expense_tracker/data/models/user/m_user.dart';

abstract interface class RemoteUserRepoInterface {
  Future getUser();

  Future updateUser(UserModel user, {String? password});

  Future deleteUser(String password);
}

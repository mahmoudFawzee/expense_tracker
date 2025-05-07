import 'package:expense_tracker/data/models/user/m_user.dart';

abstract class UserRepoInterface {
  Future getUser(int id);

  Future updateUser(int id, {required UserModel user});

  Future deleteUser(int id);

  Future storeUserLocally(UserModel user);

  Future deleteUserLocally();
}

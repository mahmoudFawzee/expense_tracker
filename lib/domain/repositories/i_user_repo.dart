import 'package:expense_tracker/data/models/user/m_user.dart';

abstract class UserRepoInterface {
  Future getUser();

  Future updateUser(UserModel user);

  Future deleteUser();

  Future storeUserLocally(UserModel user);

  Future deleteUserLocally();
}

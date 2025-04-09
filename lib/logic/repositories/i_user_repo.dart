import 'package:expense_tracker/data/models/user/m_user.dart';

abstract class UserRepoInterface {
  Future register(UserModel user, {required String password});

  Future login({required String email, required String password});

  Future getUser(int id);

  Future updateUser(int id, {required UserModel user});

  Future deleteUser(int id);
}

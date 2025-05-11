import 'package:expense_tracker/data/models/user/m_user.dart';

abstract interface class LocalUserRepoInterface {

  Future storeUser(UserModel user);
  Future getUser({int? id});

  Future updateUser(UserModel user);

  Future deleteUser();
}

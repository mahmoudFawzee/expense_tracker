import 'package:expense_tracker/data/models/user/m_user.dart';

abstract class LocalUserServiceInterface{
  Future storeUser(UserModel user);

  Future getUser({int? id});

  Future updateUser(UserModel user);

  Future deleteUser(int id);
}

import 'package:expense_tracker/data/models/user/m_user.dart';

abstract class UserServiceInterface {

  Future getUser(int id);

  Future updateUser(int id, {required UserModel user});

  Future deleteUser(int id);
}

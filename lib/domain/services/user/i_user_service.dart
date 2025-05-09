import 'package:expense_tracker/data/models/user/m_user.dart';

abstract class UserServiceInterface {

  Future getUser();

  Future updateUser(UserModel user);

  Future deleteUser(String password);
}

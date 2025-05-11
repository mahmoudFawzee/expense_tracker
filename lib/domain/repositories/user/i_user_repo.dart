import 'package:expense_tracker/data/models/user/m_user.dart';

abstract interface class UserRope {
  Future getUser();
  //?password: we may update email so we will need password.
  Future updateUser(
    UserModel user, {
    String? password,
  });

  Future deleteUser(String password);

  //?in case user logged out we need to delete his data from
  //?local storage.
  Future deleteLocalUser();

  Future storeUser(UserModel user);
  //?api store user this process happened when user register in auth service.
}

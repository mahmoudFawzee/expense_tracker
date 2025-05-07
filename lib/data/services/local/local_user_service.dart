import 'package:expense_tracker/data/models/user/m_user.dart';
import 'package:expense_tracker/domain/services/user/i_local_user_service.dart';

final class LocalUserService implements LocalUserServiceInterface {
  @override
  Future deleteUser() {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  Future getUser(int id) {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  //?store data locally.
  @override
  Future storeData(UserModel user) {
    // TODO: implement storeData
    throw UnimplementedError();
  }

  @override
  Future updateUser(int id, {required UserModel user}) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}

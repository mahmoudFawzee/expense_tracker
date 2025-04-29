import 'package:expense_tracker/data/models/user/m_user.dart';
import 'package:expense_tracker/domain/repositories/i_user_repo.dart';

final class UserRepo implements UserRepoInterface{
  @override
  Future deleteUser(int id) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  Future getUser(int id) {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future login({required String email, required String password}) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future register(UserModel user, {required String password}) {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  Future updateUser(int id, {required UserModel user}) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
  
}
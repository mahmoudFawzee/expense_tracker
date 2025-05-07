import 'package:expense_tracker/data/models/user/m_user.dart';
import 'package:expense_tracker/domain/services/user/i_user_service.dart';

abstract class LocalUserServiceInterface extends UserServiceInterface {
  Future storeUser(UserModel user);
}

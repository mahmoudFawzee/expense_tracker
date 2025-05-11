import 'package:expense_tracker/data/exceptions/response_exceptions.dart';
import 'package:expense_tracker/data/models/user/m_user.dart';

final class UserDataResponse {
  final UserModel? user;
  final ResponseExceptions? exceptions;
  const UserDataResponse({this.user, this.exceptions});
}

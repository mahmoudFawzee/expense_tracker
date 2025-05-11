import 'package:expense_tracker/data/constants/json_keys.dart';
import 'package:expense_tracker/data/exceptions/response_exceptions.dart';
import 'package:expense_tracker/data/models/user/m_user.dart';

final class UserDataResponse {
  final UserModel? user;
  final ResponseExceptions? _exceptions;
  final String? _message;
  const UserDataResponse(
      {this.user, ResponseExceptions? exceptions, String? message})
      : _exceptions = exceptions,
        _message = message;

  String get message =>
      _message ?? _exceptions?.errors?[JsonKeys.error] ?? 'Unexpected Error';
}

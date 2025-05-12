import 'package:expense_tracker/data/exceptions/base_exception.dart';

final class AuthException extends BaseException {
  const AuthException({super.message, super.errors});
}

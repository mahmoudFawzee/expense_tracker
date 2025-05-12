import 'package:expense_tracker/data/exceptions/base_exception.dart';

final class UserException extends BaseException {
  const UserException({super.message, super.errors});
}

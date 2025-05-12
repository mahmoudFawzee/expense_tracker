import 'package:expense_tracker/data/models/user/m_user.dart';
import 'package:expense_tracker/data/responses/base_response.dart';

final class UserDataResponse extends BaseResponse {
  final UserModel? user;
  const UserDataResponse(
    super.response, {
    this.user,
  });
}

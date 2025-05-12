import 'package:expense_tracker/data/responses/base_response.dart';
import 'package:expense_tracker/domain/entities/user.dart';

final class AuthResponse extends BaseResponse {
  final String? _accessToken;
  final String? _refreshToken;
  final String? _tokenType;
  final User? user;
  const AuthResponse(
    super.response, {
    this.user,
    String? accessToken,
    String? refreshToken,
    String? tokenType,
  })  : _accessToken = accessToken,
        _refreshToken = refreshToken,
        _tokenType = tokenType;

  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;
  String? get tokenType => _tokenType;
}

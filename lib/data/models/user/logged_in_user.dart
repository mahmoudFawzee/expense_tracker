import 'package:equatable/equatable.dart';
import 'package:expense_tracker/data/models/user/m_user.dart';

final class LoggedInUser extends Equatable {
  final UserModel user;
  final String _accessToken;
  final String _tokenType;
  final String? _refreshToken;
  const LoggedInUser({
    required this.user,
    required String accessToken,
    required String tokenType,
    String? refreshToken,
  })  : _refreshToken = refreshToken,
        _tokenType = tokenType,
        _accessToken = accessToken;

  String get accessToken => '$_tokenType $_accessToken';
  String get refreshToken => '$_tokenType $_refreshToken';
  @override
  List<Object?> get props => [user, _accessToken, _refreshToken, _tokenType];
}

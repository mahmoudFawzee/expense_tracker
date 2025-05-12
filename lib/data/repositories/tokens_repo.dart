import 'package:expense_tracker/data/services/auth/token_service.dart';
import 'package:expense_tracker/domain/repositories/i_tokens_repo.dart';

final class TokensRepo implements TokensRepoInterface {
  final TokensService _tokenService;
  const TokensRepo(this._tokenService);
  @override
  Future deleteAccessToken() async => _tokenService.deleteAccessToken();

  @override
  Future deleteRefreshToken() async => _tokenService.deleteRefreshToken();

  @override
  Future<String?> fetchAccessToken() async => _tokenService.fetchAccessToken();

  @override
  Future<String?> fetchRefreshToken() async =>
      _tokenService.fetchRefreshToken();

  @override
  Future<bool> storeAccessToken(String value) async =>
      await _tokenService.storeAccessToken(value);

  @override
  Future<bool> storeRefreshToken(String value) async =>
      await _tokenService.storeRefreshToken(value);

  @override
  Future<bool> updateAccessToken(String value) async =>
      await _tokenService.updateAccessToken(value);

  @override
  Future<bool> updateRefreshToken(String value) async =>
      await _tokenService.updateRefreshToken(value);
}

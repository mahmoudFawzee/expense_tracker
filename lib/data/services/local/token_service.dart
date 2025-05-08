import 'package:expense_tracker/data/constants/json_keys.dart';
import 'package:expense_tracker/domain/services/auth/i_tokens.dart';
import 'package:expense_tracker/data/helper/secure_storage.dart';

final class TokensService implements TokenServiceInterface {
  final _secureStorage = SecureStorage();
  @override
  Future deleteAccessToken() async =>
      _secureStorage.delete(JsonKeys.accessToken);

  @override
  Future deleteRefreshToken() async =>
      await _secureStorage.delete(JsonKeys.refreshToken);

  @override
  Future<String?> fetchAccessToken() async =>
      await _secureStorage.read(JsonKeys.accessToken);

  @override
  Future<String?> fetchRefreshToken() async =>
      await _secureStorage.read(JsonKeys.refreshToken);

  @override
  Future<bool> storeAccessToken(String value) async =>
      await _secureStorage.store(JsonKeys.accessToken, value);

  @override
  Future<bool> storeRefreshToken(String value) async =>
      await _secureStorage.store(JsonKeys.refreshToken, value);

  @override
  Future<bool> updateAccessToken(String value) async =>
      await _secureStorage.update(JsonKeys.accessToken, value);

  @override
  Future<bool> updateRefreshToken(String value) async =>
      await _secureStorage.update(JsonKeys.refreshToken, value);
}

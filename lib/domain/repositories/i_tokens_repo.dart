abstract class TokensRepoInterface {
  Future<bool> storeAccessToken(String value);
  Future<bool> storeRefreshToken(String value);

  Future<String?> fetchAccessToken();
  Future<String?> fetchRefreshToken();

  Future deleteAccessToken();
  Future deleteRefreshToken();

  Future<bool> updateAccessToken(String value);
  Future<bool> updateRefreshToken(String value);
}

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final class SecureStorage {
  static final SecureStorage _instance = SecureStorage._internal();
  factory SecureStorage() => _instance;
  SecureStorage._internal();

  final _storage = const FlutterSecureStorage();
  Future<bool> store(String key, String value) async {
    try {
      await _storage.write(key: key, value: value);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<String?> read(String key) async => await _storage.read(key: key);

  Future delete(String key) async => await _storage.delete(key: key);

  Future<bool> update(String key, String value) async => await store(key, value);
}

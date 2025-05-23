import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final _storage = const FlutterSecureStorage();
  static const String _userKey = "user_data";

  Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }

  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  Future<void> clearAll() async {
    await _storage.deleteAll();
  }

  Future<void> saveUser(String json) async {
    await write(_userKey, json);
  }

  Future<String?> getUser() async {
    return await read(_userKey);
  }

  Future<void> clearUser() async {
    await delete(_userKey);
  }
}

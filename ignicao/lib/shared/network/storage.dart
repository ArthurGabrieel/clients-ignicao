import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SecureStorage {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> removeToken();
}

class SecureStorageImpl implements SecureStorage {
  SecureStorageImpl(this.storage);

  final FlutterSecureStorage storage;

  @override
  Future<void> saveToken(String token) async {
    await storage.write(key: 'token', value: 'Bearer $token');
  }

  @override
  Future<String?> getToken() async {
    return storage.read(key: 'token');
  }

  @override
  Future<void> removeToken() async {
    await storage.delete(key: 'token');
  }
}

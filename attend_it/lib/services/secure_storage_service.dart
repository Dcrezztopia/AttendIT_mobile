import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final _storage = const FlutterSecureStorage();

  /// Simpan token ke Secure Storage
  Future<void> writeToken(String token) async {
    await _storage.write(key: 'authToken', value: token);
  }

  /// Baca token dari Secure Storage
  Future<String?> readToken() async {
    return await _storage.read(key: 'authToken');
  }

  /// Hapus token dari Secure Storage
  Future<void> deleteToken() async {
    await _storage.delete(key: 'authToken');
  }
}
